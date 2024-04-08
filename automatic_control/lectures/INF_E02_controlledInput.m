% 1. Design a controlled input given the parameters.
% 2. Suppose x(0) = [0; 0], compute the analytical expression of the output of the controlled system when r(t) = heaviside(t)

clear
close all
clc
format compact

s = tf('s');

% State matrices
A = [-1.8 -1.2 -1; 4 0 0; 0 1 0];
B = [0.5; 0; 0];
C = [0 0 5];
D = 0;

sys = ss(A, B, C, D);

% Initial conditions
x0 = [0; 0];

% Input
U = 1/s;

% Requirements
overshoot = 0.05; % Overshoot
settingTime = 8; % Setting time
settingPerc = 0.01; % Setting percentage +-

% Check reachability
M_r = ctrb(A,B);
if (rank(M_r) < size(A))
    return
end

sys_contr = ctrlIn(sys, overshoot, settingTime, settingPerc);

% Simulation
t_sim = linspace(0, 20, 10000); % Simulation time base, use 20 as a limit since it's 2-3 times the setting time
[y, t, x] = step(sys_contr, t_sim); % Simulation results

% Plot simulation results
figure(2),
subplot(311)
plot(t, x(:, 1), 'b', 'linew', 1.5)
grid on, zoom on, hold on, xlabel('t (s)'), ylabel('x_1(t)')
subplot(312)
plot(t, x(:, 2), 'b', 'linew', 1.5)
grid on, zoom on, hold on, xlabel('t (s)'), ylabel('x_2(t)')
subplot(313)
plot(t, x(:, 3), 'b', 'linew', 1.5)
grid on, zoom on, hold on, xlabel('t (s)'), ylabel('x_3(t)')

figure (3), plot (t, y, 'b', 'linew', 1.5)
grid on, zoom on, hold on, xlabel('t (s)'), ylabel ('y(t)')

%X = pfe(sys_contr, x0, U)