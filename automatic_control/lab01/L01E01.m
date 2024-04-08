clear all
close all
clc

tol = 1e-3;

A = [5 8; 1 3]
B = [4; -1]
C = [3 -4]
D = 7

sys = ss (A, B, C, D);

x0 = [3; -3]

s = tf('s')
%U = 0 % Step a
 U = 4/s % Step b

%X = pfe(sys, x0, U)

% Calculate X
X = zpk(minreal(inv(s*eye(size(A,1))-A)*(B*U+x0),tol))

% Calculate PFE
[num_x1, den_x1] = tfdata(X(1),'v')
[r1,p1] = residue(num_x1, den_x1)
[num_x2, den_x2] = tfdata(X(2),'v')
[r2,p2] = residue(num_x2, den_x2)