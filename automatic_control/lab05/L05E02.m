clear
close all
clc
format compact

s = tf('s');

c = 3750;
N = 60;
R = 0.246;
l = 1.86e-4;
k = 0.005;

q = c^2 / (2 * N) * exp(-s * R);
p = (s + (2 * N) / (R^2 * c)) * (s + 1 / R);
G = q / p;
C = l / (1 + s / k);

out = sim('simulink/feedback_system.slx');

figure,
plot (out.y.time, out.y.data, 'b', 'LineWidth', 1.5)
grid on, zoom on
xlabel('t (s)')
ylabel('y (t)')
