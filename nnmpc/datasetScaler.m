data = readmatrix("NNMPC_dataset.csv"); 
X = data(:, 1:20); 
Y = data(:, 21:22);

X_min = min(X);
X_max = max(X);

Y_min = min(Y);
Y_max = max(Y);

X_scaled = (X - X_min) ./ (X_max - X_min);
Y_scaled = (Y - Y_min) ./ (Y_max - Y_min);

XY=[X_scaled Y_scaled];

writematrix(XY,"scaledDataset.csv")