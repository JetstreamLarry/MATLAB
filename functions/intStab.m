% Return the eigenvalues, internal stability, natural modes and time constants of an LTI system.

function [eigs, intStab, natMode, timeCons] = intStab (sys)
    syms t;
    [A, ~, ~, ~] = ssdata (sys);
    intStab = "Asymptotically Stable";
    minMultZero = 0;
    %natMode = zeros (1, size (A, 1)); % Preallocating this causes type errors :(
    %natMode = setvartype (natMode, 'sym'); % This *may* fix it but it requires 2024a :(
    timeCons = zeros(1, size (A, 1));
    eigs = roots (minpoly (A));
    for i = 1:size (eigs)
        if (eigs (i) == 0)
            % Check if 0 appears more than once
            minMultZero = minMultZero + 1;
            if (minMultZero > 1)
                intStab = "Unstable";
                break
            else
                intStab = "Internally Stable";
            end
        elseif (eigs (i) > 0)
            intStab = "Unstable";
            break
        end
    end
    eigMult = 0;
    for i = 1:size (eigs)
        if (i > 1 && eigs (i) == eigs (i - 1))
            eigMult = eigMult + 1;
        else
            eigMult = 0;
        end
        if (imag (eigs (i))) ~= 0
            natMode (i) = t ^ eigMult * exp (real (eigs (i)) * t) * cos (2 * t + angle (eigs (i)));
        else
            natMode (i) = t ^ eigMult * exp (eigs (i) * t);
        end
    timeCons (i) = abs (1 / real (eigs (i))); % Why do unstable modes have a finite time constant???
    end
end