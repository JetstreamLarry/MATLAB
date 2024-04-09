clear
close all
clc

% Input is step function with
input_amplitude = 5;
ss_value = 1;
overshoot = 0.16;
peak_time = 0.45;

amplitude = ss_value / input_amplitude
damp = abs (log (overshoot)) / (sqrt (pi ^ 2 + (log (overshoot)) ^ 2))
natFreq = pi / (peak_time * sqrt(1 - damp ^ 2))