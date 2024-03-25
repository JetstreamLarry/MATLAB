clear all
close all
clc
wn = 0.1; %% natural frequency
z = 0.2; % damping coefficient in (0,1)
K = 1; % gain
tau = 1/(z*wn)
s = tf('s');
H = minreal( K/(1+2*z/wn*s+s^2/wn^2), 1e-3)
U = 1/s;
Y = H*U;
[n, d] = tfdata(Y,'v');
[r, p] = residue(n,d)

t = [0:1e-3: 7*tau];
% Given residues and poles, I compute y(t) "by hand":
y = 2*abs(r(1))*exp(real(p(1))*t).*cos( imag(p(1))*t+angle(r(1)))+1;

plot(t,y)
grid on

% fast way to plot the step response (input = step function with amplitude 1)
figure
step(H)


info = stepinfo(H,'RiseTimeLimits',[0,1]) 
%% pay ATTENTION to the parameters!
%% check >> help stepinfo 
%return 
%%%%%%%%%%%%%%%%%%%%%%
%% ADDITIONAL POLE
p = -1/tau %% p<0 % try faster poles, e.g., -10/tau, -100/tau
H_p = H*1/(1-s/p);
figure, step(H)
hold on, step(H_p)
legend('H', 'H + additional pole')

%% ADDITIONAL NEGATIVE ZERO
z = -wn % try -10*wn 
H_nz = H*(1-s/z);
figure, step(H)
hold on, step(H_nz)
legend('H', 'H + additional negative zero')

%% ADDITIONAL POSITIVE ZERO
z = 10*wn % try 10*wn 
H_pz = H*(1-s/z);
figure, step(H)
hold on, step(H_pz)
legend('H', 'H + additional positive zero')


