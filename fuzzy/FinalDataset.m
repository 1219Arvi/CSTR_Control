final_dataset_file = 'NNMPC_dataset.mat';

if isfile(final_dataset_file)
    load(final_dataset_file, 'X', 'Y'); % X, Y are final datasets
    fprintf("📂 Loaded existing final dataset with %d samples.\n", size(X, 1));
else
    X = [];
    Y = [];
    fprintf("📁 No existing dataset found. Creating a new one.\n");
end

load('dataset_file.mat'); 

if ~exist('X_new', 'var') || ~exist('Y_new', 'var')
    error('❌ Variables X_new and Y_new not found. Check your clean_dataset.m script.');
end


X = [X; X_new];
Y = [Y; Y_new];

save('NNMPC_dataset.mat', 'X', 'Y');

fprintf("✅ Appended %d new samples. Final dataset now has %d samples.\n", ...
    size(X_new,1), size(X,1));

