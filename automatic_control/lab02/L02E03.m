% Reset workspace
clear all
close all
clc

enablePfe = 0;
enableIntStab = 1;
enableBiboStab = 1;

% Tolerance for minreal
tol = 1e-3;

% Initialize variable
syms t;

% Initialize transfer function
s = tf('s');

% State matrices
A = [-2 0 0; 0 0 2; 0 0 0]
B = [1; 1; 1]
C = [1 0 0]
D = -2

% Initial conditions
%x0 = 

% Input
%u = 
% laplace() sucks so do it manually :(
%U = laplace(u);
%U = 

% Transfer function
H = zpk(minreal(C * inv(s * eye(size(A, 1)) - A) * B + D, tol))

% Calculate X
%X = zpk(minreal(inv(s * eye(size(A, 1)) - A) * (B * U + x0), tol));

% Calculate and print PFE of X
% TODO: What about poles with multiplicity > 1 and/or imaginary parts?
if enablePfe == 1
  for i = 1:size(X,1)
    [num, den] = tfdata(X(i), 'v');
    [res, pol] = residue(num, den);
    X(i) = 0;
    for j = 1:size(res, 1)
      mult = 1;
      while j < size(res, 1) && pol(j) == pol (j + 1)
        % Increase multiplicity and skip ahead in the res/pol list
        % This assumes that the residue() function returns the poles in a sorted list, or at least in a way that multiple identical poles are grouped together,
        % and that residues "align" with multiple identical poles, needs testing
        mult = mult + 1;
        j = j + 1;
      end
      X(i) = X(i) + res(j) / (s - pol(j)) ^ mult;
    end
  end
  X
end
% Calculate and print x using reverse Laplace transform
% ilapalce() sucks so do it manually :(
%for i = 1:size(X,1)
%  x(i) = ilaplace(X(i));
%end

% Calculate and print y
%y = C * x(t) + D * u(t)

% Analyze internal stability
if enableIntStab == 1
  eig = roots(minpoly(A))
  intStab = "Asymptotically Stable";
  minMultZero = 0;
  for k = 1:size(eig)
    if eig(k) == 0
      % Check if 0 appears more than once
      minMultZero = minMultZero + 1;
      if minMultZero > 1
        intStab = "Unstable";
        break
      else
        intStab = "Internally Stable";
      end
    elseif eig(k) > 0
      intStab = "Unstable";
      break
    end
  end
  intStab
  eigMult = 0;
  for l = 1:size(eig)
    if l > 1 && eig (l) == eig (l - 1)
      eigMult = eigMult + 1;
    else
      eigMult = 0;
    end
    if imag(eig (l)) ~= 0
      natMode(l) = t ^ eigMult * exp(real(eig(l)) * t) * cos(2 * t + angle(eig(l)));
    else
      natMode(l) = t ^ eigMult * exp(eig(l) * t);
    end
    timeCons(l) = abs(1/real(eig(l)));
  end
  natMode
  timeCons
end

% Analyze BIBO stability
if enableBiboStab == 1
  tfPoles = pole (H);
  biboStab = "BIBO Stable";
  for m = 1:size(tfPoles)
    if tfPoles(m) >= 0
      biboStab = "BIBO Unstable";
    end
  end
  biboStab
end