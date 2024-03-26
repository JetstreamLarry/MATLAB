% Return the BIBO stability of a system given its state matrices.

function biboStab = biboStab (A, B, C, D)
    tol = 1e-3;
    s = tf('s');
    H = zpk(minreal(C * inv(s * eye(size(A, 1)) - A) * B + D, tol));
    tfPoles = pole (H);
    biboStab = "BIBO Stable";
    for m = 1:size(tfPoles)
        if (tfPoles(m) >= 0)
            biboStab = "BIBO Unstable";
        end
    end
end