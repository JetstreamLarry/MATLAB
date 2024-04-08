clear
close all
clc
format compact

A = [-0.1 -1; 1 0];
B = [0.9; 0];
C = [0 1];
D = 0;

damp(A)
sys = ss(A, B, C, D);
%step(sys)

% Check reachability
M_r = ctrb(A,B)
rho_m = rank(M_r)

% Define requirements
s_hat = 0.10; % Overshoot
t_s = 6.5; % Setting time
s_p = 0.02; % Setting percentage

zeta = abs(log(s_hat)) / (sqrt(pi^2 + (log(s_hat)) ^ 2)) % Damping coefficient
wn = log((s_p) ^ (-1)) / (zeta * t_s) % Natural frequency

% Define eigenvalues to assign
lambda_1 = - zeta * wn + 1i * wn * sqrt(1 - zeta ^ 2);
lambda_2 = - zeta * wn - 1i * wn * sqrt(1 - zeta ^ 2);
lambda_des = [lambda_1, lambda_2]

K = place(A, B, lambda_des)

% State matrices and dynamical systems needed to compute N
A_c = A-B*K;
sys_N = ss(A_c, B, C, D);

% Calculate N
N = 1/dcgain(sys_N)

% Controlled LTI system
sys_contr = ss(A-B*K, B*N, C, D);

% Simulation
t_sim = linspace(0, 20, 10000); % Simulation time base, use 20 as a limit since it's 2-3 times the setting time
[y, t, x] = step(sys_contr, t_sim); % Simulation results

% Plot simulation results
figure(2),
subplot(211)
plot(t, x(:, 1), 'b', 'linew', 1.5)
grid on, zoom on, hold on, xlabel('t (s)'), ylabel('x_1(t)')
subplot(212)
plot(t, x(:, 2), 'b', 'linew', 1.5)
grid on, zoom on, hold on, xlabel('t (s)'), ylabel('x_2(t)')

figure (3), plot (t, y, 'b', 'linew', 1.5)
grid on, zoom on, hold on, xlabel('t (s)'), ylabel ('y(t)')