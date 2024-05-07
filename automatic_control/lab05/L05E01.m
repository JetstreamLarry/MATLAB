clear
close all
clc
format compact

tol = 1e-3;

s = tf('s');
G = 1 / (1 + s)^2;
C = (1 + s)^2 / (s * (1 + s/4));
L = C * G;

T = zpk(minreal(L / (1 + L), tol));
R = zpk(minreal(C / (1 + L), tol));
Q = zpk(minreal(G / (1 + L), tol));
S = zpk(minreal(1 / (1 + L), tol));


% 1
r = 1/s;
u = zpk(minreal(R * r, tol));
[num, den] = tfdata(u, 'v');
[res, pole] = residue(num, den);

% 4
%nyquist(L)

% 5
dy = 0.5 / (s^2 + 1);
e = zpk(minreal(-S * dy, tol));
[num, den] = tfdata(e, 'v');
[res, pole] = residue(num, den);
2*abs(res(3));
angle(res(3));

% 6
r6 = 3/s;
dy6 = 2/s;
y = zpk(minreal(T * r6 + S * dy6, tol));
[num, den] = tfdata(y, 'v');
[res, pole] = residue(num, den)