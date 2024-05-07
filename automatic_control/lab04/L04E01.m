s = tf('s');

H1 = -1 / ((1+s) * (1-s) ^ 2)
H2 = 10 / (s^2 * (1 - s/2) ^ 2)
H3 = 9 * (s -1) / (s * (s^2 -9))

%bode(H1)
%bode(H2)
%bode(H3)

[re, im] = nyquist (H2);
%plot(squeeze(re), squeeze(im)), grid on

%nyquist(H1)
%nyquist(H2)
%nyquist(H3)

%nichols(H1)
%nichols(H2)
%nichols(H3)