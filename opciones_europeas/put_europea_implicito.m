function prices = put_europea_implicito(S_max,T,K,N,M,r,q,sigma)
    % S_max: Precio máximo del activo subyacente
    % T: Tiempo hasta la madurez (en años)
    % K: Precio de ejercicio de la opción
    % N: Número de puntos en la partición del eje S
    % M: Número de puntos en la partición del eje del tiempo
    % r: Tasa libre de riesgo (en función del tiempo)
    % q: Rendimiento de los dividendos (en función del tiempo)
    % sigma: Volatilidad (en función del tiempo)
    
    % OUTPUT: Vector de N + 1 coordenadas con el precio de la opción en t = 0
    %----------------------------------------------------------------------
        
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
    sol(:, M+1) = max(K - vector_S,0);
    integral_r = -arrayfun(@(t) integral(@(s) r(s), t, T), vector_t);
    sol(1, :) = K * exp(integral_r);
    
    % Generación de la matriz B_j y resolución del sistema
    for j = M:-1:1
        gamma = 0.5 * dt * ((vector_i * sigma_t(j)).^2 + (r_t(j) - q_t(j)) * vector_i);
        betha = dt * ((vector_i * sigma_t(j)).^2 + r_t(j));
        alpha = 0.5 * dt * ((vector_i * sigma_t(j)).^2 - (r_t(j) - q_t(j)) * vector_i);
        
        B = diag(1+betha) - diag(alpha(2:end), -1) - diag(gamma(1:end-1), 1);
    
        h = zeros(N-1, 1);
        h(1) = -alpha(1) * sol(1, j);
        h(N-1) = -gamma(N-1) * sol(N+1, j);
    
        sol(2:N, j) = tridiagonal_matrix(B, sol(2:N, j+1) - h);
    end
prices = sol(:,1);
end