clear
close all
clc

% we want observer eigenvalues coincident in -0.5, 
% then repeat with -1 and -5.

A = [-0.4 -1; 1 0];
B = [1 0]';
C = [0 1];
D = 0;
x0 = [-0.1 0.5]';

% true system
sys = ss(A, B, C, D);

% is it observable?
Mo = obsv(A, C);
rho_Mo = rank(Mo); % it returns 2=n, so it's observable, we can compute L.

lambda_obsv_des = [-0.5 -0.5]; % part 1
L = acker(A', C', lambda_obsv_des)';

eig(A-L*C); % double-checking if we correctly assigned the desired eigenvalues

% observer system
sys_obsv = ss(A-L*C, [B L], eye(2), 0);
x0_hat = [0, 0]'; % given for the exercise

% simulation to generate observer inputs
t_sim = linspace(0, 50, 10000); % simulation time base
u_sim = 0.1*ones(size(t_sim)); % row vector
[y, ~, x] = lsim(sys, u_sim, t_sim, x0); % response simulation y is a column vector
% lsim allows us to simulate a dynamical system in the presence of an
% initial condition and input
% now the same for the observer system
[y_hat, t, x_hat] = lsim(sys_obsv, [u_sim', y], t_sim, x0_hat);

% now let's plot both x and x_hat
% time ended, remember to copy last bit which displays the two plots
figure(1),
subplot (211)
plot (t,x(:,1),'b','linew',1.5)
grid on, zoom on, hold on,
plot (t, x_hat(:,1),':r', 'linew', 1.5)
xlabel('t (s)')
legend('x_1', 'x_1hat')
subplot (212)
plot (t,x(:,2),'b','linew',1.5)
grid on, zoom on, hold on,
plot (t, x_hat(:,2),':r', 'linew', 1.5)
xlabel('t (s)')
legend('x_2', 'x_2hat')