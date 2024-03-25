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
step(sys)