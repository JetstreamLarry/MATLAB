clear
close all
clc

% State matrices
%A = ;
%B = ;
%C = ;
%D = ;
%sys = ss(A, B, C, D);

% Initial conditions
%x0 = 

% Input
%U = 
selection = 0;
fprintf("Welcome to the Automatic Control Super System Solver (Powered by MATLAB) (AC-3S M9004 (PbM)). Choose which operation to perform:\n")
fprintf("1) Partial fraction expansion (requires A, B, C, D, initial conditions and input signal)\n")
fprintf("2) Internal stability analisys (requires A)\n")
fprintf("3) BIBO stability analisys (requires A, B, C and D)\n")
fprintf("4) Controlled input (requires A, B, C, D, overshoot, setting time and setting percentage)\n")

prompt = "Make your choice (0 to quit): ";
selection = input(prompt);
return

% Calculate and print PFE of X
if enablePfe == 1
  X = pfe(sys, x0, U);
  fprintf("The partial fraction expansion of the system is:\n%i", X)
end

% Analyze internal stability
if enableIntStab == 1
  [eigs, intStab, natModes, timeCons] = intStab(sys);
  fprintf("The system is %s, and has natural modes\n\t%i\t%i\nwith time constants", intStab)
end

% Analyze BIBO stability
if enableBiboStab == 1
  biboStab = biboStab(sys);
end