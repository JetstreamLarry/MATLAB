clear
close all
clc

% Step a
s=tf('s');
H = 10 / (s^2 + 1.6*s + 4);
poles=pole(H)
natFreq = abs(poles(1))
damp = -(-0.8/natFreq)
timeFreq = 1 / (natFreq * damp)

% Step b
2.5 + 0.05 * 2.5
2.5 - 0.05 * 2.5
step(H)
% Steady state value = 2.5
overshoot = 3.13/2.5 - 1
% Peak time = 1.7
% Rise time = 1.08
% Setting time 5% = 3.8