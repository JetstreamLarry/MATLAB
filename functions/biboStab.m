% Return the BIBO stability of a system given its state matrices.

function biboStab = biboStab (sys)
    poles = pole (sys);
    biboStab = "BIBO Stable";
    for m = 1:size(poles)
        if (poles(m) >= 0)
            biboStab = "BIBO Unstable";
        end
    end
end