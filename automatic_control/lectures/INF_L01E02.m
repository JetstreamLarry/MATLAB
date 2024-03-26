% 1. Design a controlled input given the parameters.
% 2. Suppose x(0) = [0; 0], compute the analytical expression of the output of the controlled system when r(t) = heaviside(t)

clear
close all
clc
format compact

% State matrices
A = [-1.8 -1.2 -1; 4 0 0; 0 1 0];
B = [0.5; 0; 0];
C = [0 0 5];
D = 0;

% Requirements
s_hat = 0.05; % Overshoot
t_s = 8; % Setting time
s_p = 0.01; % Setting percentage +-

damp(A)
sys = ss(A, B, C, D);
%step(sys)

% Check reachability
M_r = ctrb(A,B);
if (rank(M_r) < size(A))
    return
end

% Compute damping coefficient and natural frequency
zeta = abs(log(s_hat)) / (sqrt(pi^2 + (log(s_hat)) ^ 2))
wn = log((s_p) ^ (-1)) / (zeta * t_s)

% Define eigenvalues to assign
lambda_1 = - zeta * wn + 1i * wn * sqrt(1 - zeta ^ 2);
lambda_2 = - zeta * wn - 1i * wn * sqrt(1 - zeta ^ 2);
lambda_3 = - 10 * zeta *wn;
lambda_des = [lambda_1, lambda_2, lambda_3]

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