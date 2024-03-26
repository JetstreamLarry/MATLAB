clear
close all
clc

format compact

% State matrices
%A = ;
%B = ;
%C = ;
%D = ;

sys = ss(A, B, C, D);

% Requirements
%overshoot = ;
%settingTime = ;
%settingPerc = ;

% Check reachability
M_r = ctrb(A,B);
if (rank(M_r) < size(A))
    return
end

sys_ctrl = cntrIn(sys, overshoot, settingTime, settingPerc);

% Simulation
t_sim = linspace(0, 3*settingTime, 10000); % Simulation time base, use 3 times the setting time
[y, t, x] = step(sys_ctrl, t_sim); % Simulation results

% Plot simulation results
%figure(1),
%subplot(111)
%plot(t, x(:, 1), 'b', 'linew', 1.5)
%grid on, zoom on, hold on, xlabel('t (s)'), ylabel('x_1(t)')

figure (2), plot (t, y, 'b', 'linew', 1.5)
grid on, zoom on, hold on, xlabel('t (s)'), ylabel ('y(t)')