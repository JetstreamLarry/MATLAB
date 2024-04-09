clear
close all
clc

A = [-1 0; 0 10];
B = [1; 1];
C = [1 0];

% Reachability
M_r = ctrb(A,B);
rankReach = rank(M_r)

% Observability
Mo = obsv(A, C);
rankObs = rank(Mo)