function [v_a, v_b] = autovalores(T, N, M, r, q, sigma)
    % T: Tiempo hasta la madurez (en años)
    % N: Número de puntos en la partición del eje S
    % M: Número de puntos en la partición del eje del tiempo
    % r: Tasa libre de riesgo (en función del tiempo)
    % q: Rendimiento de los dividendos (en función del tiempo)
    % sigma: Volatilidad (en función del tiempo)
    
    % OUTPUT: dos vectores de M+1 componentes que contienen 
    % radio espectral de A_j y radio espectral de B^{-1}_j para cada j
    %----------------------------------------------------------------------
        
    % Paso temporal
    dt = T / M;
    
    % Vectores
    vector_i = (1:N-1)';
    vector_t = linspace(0, T, M+1);
    
    % Evaluar funciones en los puntos de tiempo
    sigma_t = sigma(vector_t);
    r_t = r(vector_t);
    q_t = q(vector_t);
    
    % Inicializar los vectores de autovalores
    autovalores_a = zeros(1, M+1);
    autovalores_b = zeros(1, M+1);
    
    % Generación de los coeficientes y resolución del sistema
    for j = 1:M+1
        % Valores actuales de sigma, r, y q
        sigma_val = sigma_t(j);
        r_val = r_t(j);
        q_val = q_t(j);
        
        % Cálculo de gamma, beta y alpha para la matriz D
        gamma = 0.5 * dt * ((vector_i .* sigma_val).^2 + (r_val - q_val) .* vector_i);
        beta = dt * ((vector_i .* sigma_val).^2 + r_val);
        alpha = 0.5 * dt * ((vector_i .* sigma_val).^2 - (r_val - q_val) .* vector_i);
        
        % Matriz A_j y sus valores propios
        A = diag(1 - beta) + diag(alpha(2:end), -1) + diag(gamma(1:end-1), 1);
        eigenvalues_A = eig(A);
        autovalores_a(j) = max(abs(eigenvalues_A));
        
        % Matriz B^{-1}_j y sus valores propios
        B = diag(1 + beta) - diag(alpha(2:end), -1) - diag(gamma(1:end-1), 1);
        B_inv = inv(B);
        eigenvalues_B_inv = eig(B_inv);
        autovalores_b(j) = max(abs(eigenvalues_B_inv));
    end
    % Asignar los valores máximos de los autovalores calculados
    v_a = autovalores_a;
    v_b = autovalores_b;
end
