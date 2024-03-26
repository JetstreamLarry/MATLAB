% Return X after a partial fraction expansion, given the state space matrices, initial conditions and input signal.
% TODO: What about poles with multiplicity > 1 and/or imaginary parts?

function X = pfe(A, B, ~, ~, x0, U)
    tol = 1e-3;
    s = tf('s');
    X = zpk(minreal(inv(s * eye(size(A, 1)) - A) * (B * U + x0), tol));
    for i = 1:size(X)
        [num, den] = tfdata(X(i), 'v');
        [res, pol] = residue(num, den);
        X(i) = 0;
        for j = 1:size(res)
            mult = 1;
            while j < size(res) && pol(j) == pol (j + 1)
            % Increase multiplicity and skip ahead in the res/pol list
            % This assumes that the residue() function returns the poles in a sorted list, or at least in a way that multiple identical poles are grouped together,
            % and that residues "align" with multiple identical poles, needs testing
            mult = mult + 1;
            j = j + 1;
            end
            X(i) = X(i) + res(j) / (s - pol(j)) ^ mult;
        end
    end

    % Calculate and print x using reverse Laplace transform
    % ilapalce() sucks so do it manually :(
    %for i = 1:size(X,1)
    %  x(i) = ilaplace(X(i));
    %end

    % Calculate and print y
    %y = C * x(t) + D * u(t)
end