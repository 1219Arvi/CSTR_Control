% Parameters
qc_min = 0.0;
qc_max = 10.0;   % coolant flow range [0,10]
q_min = 0.0;
q_max = 10.0;    % reactant flow range [0,10]

sim_time = 10000;  % total simulation time
dt = 0.1;           % time step
time = (0:dt:sim_time-dt)';
N = length(time);


qc_input = zeros(N,1);
q_input = zeros(N,1);


qc_input(1) = qc_min + (qc_max - qc_min)*rand();
q_input(1) = q_min + (q_max - q_min)*rand();

step_length = 4000; % steps between random changes (can tune)

for i = 2:N
    if mod(i, step_length) == 0
        qc_input(i) = qc_min + (qc_max - qc_min)*rand();
        q_input(i) = q_min + (q_max - q_min)*rand();
    else
        qc_input(i) = qc_input(i-1);
        q_input(i) = q_input(i-1);
    end
end

qc_signal.time = time;
qc_signal.signals.values = qc_input;
qc_signal.signals.dimensions = 1;

q_signal.time = time;
q_signal.signals.values = q_input;
q_signal.signals.dimensions = 1;

T0 = 317;   % Example initial reactor temperature
Tc0 = 297;  % Example initial coolant temperature

assignin('base', 'T0', T0);
assignin('base', 'Tc0', Tc0);


