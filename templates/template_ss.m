clear
close all
clc

format compact

% Choose which operations to perform
enablePfe = 0;
enableIntStab = 0;
enableBiboStab = 0;

% State matrices
%A = 
%B = 
%C = 
%D = 

% Initial conditions
%x0 = 

% Input
%u = 
% laplace() sucks so do it manually :(
%U = laplace(u);
%U = 

% Calculate and print PFE of X
if enablePfe == 1
  X = pfe(A, B, C, D, x0, U)
end

% Analyze internal stability
if enableIntStab == 1
  [eigs, intStab, natModes, timeCons] = intStab(A)
end

% Analyze BIBO stability
if enableBiboStab == 1
  [biboStab] = biboStab(A, B, C, D)
end