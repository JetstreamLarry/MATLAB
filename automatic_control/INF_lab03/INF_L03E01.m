clear
close all
clc

% State matrices
A = [-0.2 -1; 1 0];
B = [0.5; 0];
C = [0 1];
D = 0;

sys = ss(A, B, C, D);

% Requirements
overshoot = 0.06;
settingTime = 2;
settingPerc = 0.02;

% Check reachability
M_r = ctrb(A,B);
if (rank(M_r) < size(A))
    return
end

sysCtrl = ctrlIn(sys, overshoot, settingTime, settingPerc);

% Simulation
tSim = linspace(0, 3*settingTime, 10000); % Simulation time base, use 3 times the setting time
[y, t, x] = step(sysCtrl, tSim); % Simulation results

% Plot simulation results
%figure(1),
%subplot(111)
%plot(t, x(:, 1), 'b', 'linew', 1.5)
%grid on, zoom on, hold on, xlabel('t (s)'), ylabel('x_1(t)')

figure (2), plot (t, y, 'b', 'linew', 1.5)
grid on, zoom on, hold on, xlabel('t (s)'), ylabel ('y(t)')

% Step b
tol = 1e-3;
x0 = [0; 0];
s = tf('s');
% ref = step signal
R = 1/s;
[Ac, Bc, Cc, Dc] = tfdata(sysCtrl)
X = zpk(minreal(inv(s*eye(size(Ac,1)) + (-Ac))*(Bc*R+x0),tol))
