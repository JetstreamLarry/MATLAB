% Return X after a partial fraction expansion, given the state space matrices, initial conditions and input signal.
% TODO: What about poles with multiplicity > 1 and/or imaginary parts?

% Increase multiplicity and skip ahead in the res/pol list
% This assumes that the residue() function returns the poles in a sorted list, or at least in a way that multiple identical poles are grouped together,
% and that residues "align" with multiple identical poles, needs testing
function X = pfe (sys, x0, U)
    tol = 1e-3;
    s = tf ('s');
    [A, B, ~, ~] = ssdata (sys);
    Xn = zeros (1, size (A, 1));
    X = zpk (minreal (inv (s * eye (size (A, 1)) - A) \ (B * U + x0), tol));
    % laplace() sucks so do it manually :(
    %U = laplace(u);
    for i = 1:size (X)
        [num, den] = tfdata (X (i), 'v');
        [res, pol] = residue (num, den);
        for j = 1:size (res)
            Xn (i) = Xn (i) + res (j) / (s - pol (j));
        end
    end

    % Calculate and print x using reverse Laplace transform
    % ilapalce() sucks so do it manually :(
    %for i = 1:size (X,1)
    %  x (i) = ilaplace (X (i));
    %end

    % Calculate and print y
    %y = C * x (t) + D * u (t)
end