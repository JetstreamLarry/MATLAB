clear
close all
clc
format compact

s = tf('s');

G = 2122.4 / (s * (s + 59.24));
C = 4.5423 * (1 + s / 59.2) / (1 + s / 218.8);

out = sim('simulink/feedback_system.slx');

figure,
plot (out.y.time, out.y.data, 'b', 'LineWidth', 1.5)
hold on
plot (out.r.time, out.r.data, 'r', 'LineWidth', 1.5)
grid on, zoom on
xlabel('t (s)')
ylabel('y (t)')