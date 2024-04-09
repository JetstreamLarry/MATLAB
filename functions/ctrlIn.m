function sysCtrl = ctrlIn (sys, overshoot, settingTime, settingPerc)
    [A, B, C, D] = ssdata (sys);
    eigsDes = zeros(1, size (A, 1));
    
    % Compute damping coefficient and natural frequency
    damp = abs (log (overshoot)) / (sqrt (pi ^ 2 + (log (overshoot)) ^ 2));
    natFreq = log ((settingPerc) ^ (-1)) / (damp * settingTime);

    % Define eigenvalues to assign
    for i = 1:size (A)
        if i < size (A)
            if mod (i, 2) == 1
                eigsDes (1, i) = - damp * natFreq + 1i * natFreq * sqrt (1 - damp ^ 2);
            else
                eigsDes (1, i) = - damp * natFreq - 1i * natFreq * sqrt (1 - damp ^ 2);
            end
        else
            if mod (i, 2) == 1
                eigsDes (1, i) = - 10 * damp * natFreq;
            else
                eigsDes (1, i) = - damp * natFreq - 1i * natFreq * sqrt (1 - damp ^ 2);
            end
        end
    end

    % Compute K
    K = place (A, B, eigsDes)

    % State matrices and dynamical systems needed to compute N
    sysN = ss (A - B * K, B, C, D);

    % Compute N
    N = 1 / dcgain (sysN)

    % Controlled LTI system
    sysCtrl = ss (A - B * K, B * N, C, D);
end