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
