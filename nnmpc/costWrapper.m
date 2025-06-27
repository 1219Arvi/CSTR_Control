function J = costWrapper(qc_seq, history_vector, q_seq, qc_prev, T_ref, lambda, net)

    [T_preds, ~] = predictRolling_vector(history_vector, qc_seq, q_seq, net);

    tracking_error = sum((T_preds - T_ref).^2);
    delta_qc = diff([qc_prev, qc_seq]);
    effort = sum(delta_qc.^2);

    J = tracking_error + lambda * effort;
end
