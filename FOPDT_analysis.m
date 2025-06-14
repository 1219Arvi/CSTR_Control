T = out.T_data;
qc = out.qc_data;
t=out.tout;

% Estimate steady-state values
T0 = T(23);                % Temp at which the SS is achieved before applying Step Input
T_final = T(end);         
delta_T = T_final - T0; 
fprintf('Change in Temp %f\n',delta_T);
delta_q = qc(end) - qc(23);  
fprintf('Çhange in Coolant flow rate%f\n',delta_q);
% Process gain
Kp = delta_T / delta_q;

% Estimate dead time (t0): 
t_response=205.611;             % Time at which the system reacts to step input
t_step=200;                     % Time at which system ideally reacts to step input change
t0 =t_response-t_step;

% Estimate time constant (tau_p):
T63 = T0 + 0.632 * delta_T        % Temp at which system achives SS after step change
tau_p=236.0023-205.611;           % t at which Temp reaches T63 and dead time

% Plots
figure

subplot(2,1,1)  % time vs Temp curve
plot(t, T, 'b-', 'LineWidth', 2)
xlabel('Time')
ylabel('Temperature (T)')
title('Temperature vs Time')
grid on

subplot(2,1,2)  % time vs Coolant_flow_rate curve
plot(t, qc, 'r--', 'LineWidth', 2)
xlabel('Time')
ylabel('Cooling Rate (qc)')
title('Cooling Rate vs Time')
grid on

% Display results
fprintf('Process gain, Kp = %.3f\n', Kp);
fprintf('Dead time, t0 = %.2f min\n', t0);
fprintf('Time constant, tau_p = %.2f min\n', tau_p);

% PID parameters from Dahlins equation
Kc=tau_p/(Kp*(t0+tau_p));
tau_i=tau_p;
tau_d=t0/2;
tau_c=t0/5;

fprintf('Kp = %.3f\n', Kc);
fprintf('tau_i = %.2f min\n', tau_i);
fprintf('tau_d = %.2f min\n', tau_d);
fprintf('tau_c = %.2f min\n', tau_c);

P=Kc;
I=Kc/tau_i;
D=Kc*tau_d;

fprintf('P = %f\n', P);
fprintf('I = %f\n', I);
fprintf('D = %f\n', D);


