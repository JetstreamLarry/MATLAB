function [sys_contr] = ctrlIn (sys, overshoot, settingTime, settingPerc)
    [A, B, C, D] = ssdata(sys);
    lambda_des = zeros(1, size(A, 1));
    
    % Compute damping coefficient and natural frequency
    zeta = abs(log(overshoot)) / (sqrt(pi^2 + (log(overshoot)) ^ 2));
    wn = log((settingPerc) ^ (-1)) / (zeta * settingTime);

    % Define eigenvalues to assign
    for i = 1:size(A)
        if i < size(A)
            if mod(i, 2) == 1
                lambda_des(1, i) = - zeta * wn + 1i * wn * sqrt(1 - zeta ^ 2);
            else
                lambda_des(1, i) = - zeta * wn - 1i * wn * sqrt(1 - zeta ^ 2);
            end
        else
            if mod(i, 2) == 1
                lambda_des(1, i) = - 10 * zeta * wn;
            else
                lambda_des(1, i) = - zeta * wn - 1i * wn * sqrt(1 - zeta ^ 2);
            end
        end
    end

    K = place(A, B, lambda_des);

    % State matrices and dynamical systems needed to compute N
    sys_N = ss(A-B*K, B, C, D);

    % Calculate N
    N = 1/dcgain(sys_N);

    % Controlled LTI system
    sys_contr = ss(A-B*K, B*N, C, D);
end