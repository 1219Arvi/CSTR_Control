function qc_applied = NN_MPC_Controller(q_const, T_ref,history_vector,net )
% Inputs:
%   history_vector: 1x20 vector [q_hist, qc_hist, T_hist, Ca_hist]
%   T_ref: 1xP desired future temperatures
%   q_const: scalar assumed constant q for future steps
% Output:
%   qc_applied: scalar coolant input to apply

    P = length(T_ref);           
    lambda = 1.0;                 
    qc_prev = history_vector(10); 

    q_seq = repmat(q_const, 1, P);

    qc0 = repmat(qc_prev, 1, P);
    lb = zeros(1, P);
    ub = repmat(0.03, 1, P);

    costFcn = @(qc_seq) costWrapper(qc_seq, history_vector, q_seq, qc_prev, T_ref, lambda, net);

    options = optimoptions('fmincon','Display','none','Algorithm','sqp');
    [qc_opt, ~] = myFminconWrapper(qc0, lb, ub, options, history_vector, q_seq, qc_prev, T_ref, lambda);


    qc_applied = qc_opt(1);
end

function [T_preds, Ca_preds] = predictRolling_vector(history_vector, qc_seq, q_seq, net)
    P = length(qc_seq);
    T_preds = zeros(1, P);
    Ca_preds = zeros(1, P);

    q_hist  = history_vector(1:5);
    qc_hist = history_vector(6:10);
    T_hist  = history_vector(11:15);
    Ca_hist = history_vector(16:20);

    for i = 1:P
        input_vector = [q_hist, qc_hist, T_hist, Ca_hist];
        output = predict(net, input_vector);
        T_preds(i) = output(1);
        Ca_preds(i) = output(2);

        q_hist  = [q_hist(2:end), q_seq(i)];
        qc_hist = [qc_hist(2:end), qc_seq(i)];
        T_hist  = [T_hist(2:end), T_preds(i)];
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
