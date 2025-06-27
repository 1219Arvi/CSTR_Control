function NN_MPC_SFunction(block)
    setup(block);
end

function setup(block)
    % Register number of ports
    block.NumInputPorts  = 3;
    block.NumOutputPorts = 1;

    % Set input port properties
    block.SetPreCompInpPortInfoToDynamic;
    block.InputPort(1).Dimensions  = 1;     % q_const
    block.InputPort(2).Dimensions  = [1, 10];% T_ref (prediction horizon = 5)
    block.InputPort(3).Dimensions  = [1, 20];% history_vector

    % Set output port properties
    block.SetPreCompOutPortInfoToDynamic;
    block.OutputPort(1).Dimensions = 1;     % qc_applied (scalar)

    % Set sample time
    block.SampleTimes = [0 0];  % Inherited sample time

    % Register block methods
    block.RegBlockMethod('Start',    @Start);
    block.RegBlockMethod('Outputs',  @Outputs);
end

function Start(block)
    persistent netLoaded
    if isempty(netLoaded)
        netLoaded = evalin('base', 'net');  
    end
    block.UserData = netLoaded; 
end

function Outputs(block)
    q_const        = block.InputPort(1).Data;
    T_ref          = block.InputPort(2).Data;
    history_vector = block.InputPort(3).Data;

    net = block.UserData;

    %#codegen
    coder.extrinsic('fmincon', 'predict');

    P = length(T_ref);           
    lambda = 1.0;                 
    qc_prev = history_vector(10); 

    q_seq = repmat(q_const, 1, P);
    qc0   = repmat(qc_prev, 1, P);
    lb    = zeros(1, P);
    ub    = repmat(0.03, 1, P);

    costFcn = @(qc_seq) costWrapper(qc_seq, history_vector, q_seq, qc_prev, T_ref, lambda, net);

    options = optimoptions('fmincon','Display','none','Algorithm','sqp');

    qc_opt = fmincon(costFcn, qc0, [], [], [], [], lb, ub, [], options);

    block.OutputPort(1).Data = qc_opt(1);
end

function [T_preds, Ca_preds] = predictRolling_vector(history_vector, qc_seq, q_seq, net)
    coder.extrinsic('predict');

    P = length(qc_seq);
    T_preds = zeros(1, P);
    Ca_preds = zeros(1, P);

    q_hist  = history_vector(1:5);
    qc_hist = history_vector(6:10);
    T_hist  = history_vector(11:15);
    Ca_hist = history_vector(16:20);

    for i = 1:P
        input_vector = [q_hist, qc_hist, T_hist, Ca_hist];
        output = predict(net, input_vector); % Output: [T, Ca]
        T_preds(i)  = output(1);
        Ca_preds(i) = output(2);

        % Update histories
        q_hist  = [q_hist(2:end),  q_seq(i)];
        qc_hist = [qc_hist(2:end), qc_seq(i)];
        T_hist  = [T_hist(2:end),  T_preds(i)];
        Ca_hist = [Ca_hist(2:end), Ca_preds(i)];
    end
end

function J = costWrapper(qc_seq, history_vector, q_seq, qc_prev, T_ref, lambda, net)
    [T_preds, ~] = predictRolling_vector(history_vector, qc_seq, q_seq, net);

    tracking_error = sum((T_preds - T_ref).^2);
    delta_qc = diff([qc_prev, qc_seq]);
    effort = sum(delta_qc.^2);

    J = tracking_error + lambda * effort;
end
