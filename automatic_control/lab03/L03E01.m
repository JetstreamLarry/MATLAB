clear
close all
clc

% Step b
%s = 1i*0.1;
% Step c
s = 1i*3;
syms t;
H = 1 / (s^3 + 2*s^2 + 5.25*s + 4.25);
angFreq = 0.1;
amp_sin = 3;
amp_step = 2;
input = (amp_sin * sin(angFreq * t) + 2);
amp_ss = 3 * abs(H)
phase_ss = angle(H)
%y_ss_sin = amp_ss * sin(angFreq * t + phase) % Matlab sucks :(
ss_step = amp_step * 1 / 4.25

% Step c
%input_c = u_bar * sin(3 * t);
u_bar = 1/abs(H)