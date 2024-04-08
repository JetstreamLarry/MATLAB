% Return the BIBO stability of an LTI system.

function biboStab = biboStab (sys)
    poles = pole (sys);
    biboStab = "BIBO Stable";
    for m = 1:size (poles)
        if (poles (m) >= 0)
            biboStab = "BIBO Unstable";
            break
        end
    end
end