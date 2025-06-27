% === Extract time-series data from Simulink output ===
T_vals   = out.T_data.Data;    % T(t)
CA_vals  = out.Ca_data.Data;   % C_A(t)
qc_vals  = out.qc_data.Data;   % q_c(t)
q_vals   = out.q_data.Data;    % q(t)

% === Minimum length across all vectors ===
N = min([length(T_vals), length(CA_vals), length(qc_vals), length(q_vals)]);

% === Initialize dataset arrays ===
X_curr = [];
Y_curr = [];

% === Loop through sliding windows ===
for k = 5:(N - 1)
    
    % Create 5-step history windows (latest last)
    q_win   = q_vals(k-4:k);
    qc_win  = qc_vals(k-4:k);
    CA_win  = CA_vals(k-4:k);
    T_win   = T_vals(k-4:k);

    % OPTIONAL: Ensure inputs were constant in this window
    if all(q_win == q_win(1)) && all(qc_win == qc_win(1))

        % 1×20 input vector: [q(–4:0), qc(–4:0), CA(–4:0), T(–4:0)]
        X_k = [q_win', qc_win', CA_win', T_win'];

        % 1×2 label: [C_A(t+1), T(t+1)]
        Y_k = [CA_vals(k+1), T_vals(k+1)];

        % Append to dataset
        X_curr = [X_curr; X_k];
        Y_curr = [Y_curr; Y_k];
    end
end

% === Final Dataset ===
X_new = X_curr;
Y_new = Y_curr;

% === Save to .mat file ===
save('NNMPC_dataset.mat', 'X_new', 'Y_new');

fprintf("✅ Dataset created successfully:\n");
fprintf("   Input features (X): %d × %d\n", size(X_new,1), size(X_new,2));
fprintf("   Output labels  (Y): %d × %d\n", size(Y_new,1), size(Y_new,2));

load('NNMPC_dataset.mat');
XY = [X_new Y_new];
writematrix(XY, 'NNMPC_dataset.csv');
