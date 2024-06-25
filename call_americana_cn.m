function prices = call_americana_cn(S_max, T, K, N, M, r, q, sigma, omega, tol, max_iter)
    % Paso temporal
    dt = T / M;
    
    % Matrices y vectores
    sol = zeros(N + 1, M + 1);
    vector_S = linspace(0,S_max,N+1);
    vector_i = (1:N-1)';
    vector_t = linspace(0,T,M+1);
    
    sigma_t = sigma(vector_t);
    r_t = r(vector_t);
    q_t = q(vector_t);

    % Condiciones terminal y de contorno
    sol(:, end) = max(vector_S - K,0);
    integral_r = -arrayfun(@(t) integral(@(s) r(s), t, T), vector_t);
    integral_q = -arrayfun(@(t) integral(@(s) q(s), t, T), vector_t);
    sol(end, :) = vector_S(end) * exp(integral_q) - K * exp(integral_r);
    
    alpha = 0.5 * dt * ((vector_i * sigma_t(M+1)).^2 - (r_t(M+1) - q_t(M+1)) * vector_i);
    betha = dt * ((vector_i * sigma_t(M+1)).^2 + r_t(M+1));
    gamma = 0.5 * dt * ((vector_i * sigma_t(M+1)).^2 + (r_t(M+1) - q_t(M+1)) * vector_i);
    
    v = max(vector_S - K, 0);
    
    % Generación de los coeficientes y resolución del sistema
    for j = M+1:-1:2
        
        ant = sol(2:N,j);
        p = (2-betha) .* ant + alpha .* [0;ant(1:end-1)] + gamma .* [ant(2:end);0];
        
        g = zeros(N-1, 1);
        g(1) = alpha(1) * sol(1, j);
        g(N-1) = gamma(N-1) * sol(N+1, j);
        
        d = p+g;
        
        %Nuevos coeficientes 
        
        alpha = 0.5 * dt * ((vector_i * sigma_t(j-1)).^2 - (r_t(j-1) - q_t(j-1)) * vector_i);
        betha = dt * ((vector_i * sigma_t(j-1)).^2 + r_t(j-1));
        gamma = 0.5 * dt * ((vector_i * sigma_t(j-1)).^2 + (r_t(j-1) - q_t(j-1)) * vector_i);
        
        
        error = realmax;
        iter = 0;
        sol(2:N, j - 1) = sol(2:N, j);
        
        while error > tol && iter < max_iter
            marca = sol(:, j - 1);
            iter = iter + 1;
            
            for k = 2:N
                sol(k, j - 1) = max(v(k), (1 - omega) * sol(k, j - 1) + (omega / (2 + betha(k - 1))) * (d(k - 1) + alpha(k - 1) * sol(k - 1, j - 1) + gamma(k - 1) * sol(k + 1, j - 1)));
            end
            sol(end,j-1) = max(v(end),sol(end,j-1));
            error = norm(sol(:, j - 1) - marca);
        end
    end
    prices = sol(:, 1);
end
