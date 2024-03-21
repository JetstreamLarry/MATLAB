clear all
close all
clc

tol = 1e-3;

A = [0 1; -1 -1];
B = [27 0; -23 1];
C = [1 0];
% D =

x0 = [0; 0];

s = tf('s');
U = [0; 1];

% Calculate X
X = zpk(minreal(inv(s*eye(2)-A)*(B*U+x0),tol))

% Calculate PFE
[num_x1, den_x1] = tfdata(X(1),'v')
[r1,p1] = residue(num_x1, den_x1)
[num_x2, den_x2] = tfdata(X(2),'v')
[r2,p2] = residue(num_x2, den_x2)

