load('NNMPC_dataset.mat');
whos;
XY = [X Y];  % Concatenate columns
writematrix(XY, 'NNMPC_dataset.csv');


