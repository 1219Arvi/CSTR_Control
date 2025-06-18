T_vals   = out.T_data.signals.values;
qc_vals  = out.qc_data.signals.values;
q_vals   = out.q_data.signals.values;

N = min([length(T_vals), length(qc_vals), length(q_vals)]);

X_curr = [];
Y_curr = [];

T0_val = T0;
Tc0_val = Tc0;

for k = 1:N-2
    % Check if qc or q changed at this step
    if qc_vals(k) == qc_vals(k+1) && q_vals(k) == q_vals(k+1)
        % Valid data point — input constant over [k, k+1]
        X_k = [T_vals(k), qc_vals(k), q_vals(k), T0_val, Tc0_val];
        Y_k = [T_vals(k+1)];
        
        X_curr = [X_curr; X_k];
        Y_curr = [Y_curr; Y_k];
    end
end

% Convert to final arrays
X_new = X_curr;
Y_new = Y_curr;

% Save
save('dataset_file.mat', 'X_new', 'Y_new');

fprintf(" Dataset part created:\n");
fprintf("  Valid samples: %d\n", size(X_new,1));
