function prices = call_americana_cn(S_max, T, K, N, M, r, q, sigma, omega, tol, max_iter)
    % S_max: Precio máximo del activo subyacente
    % T: Tiempo hasta la madurez (en años)
    % K: Precio de ejercicio de la opción
    % N: Número de puntos en la partición del eje S
    % M: Número de puntos en la partición del eje del tiempo
    % r: Tasa libre de riesgo (en función del tiempo)
    % q: Rendimiento de los dividendos (en función del tiempo)
    % sigma: Volatilidad (en función del tiempo)
    % omega: Parámetro de sobre-relajación para el método SOR proyectado
    % tol: Nivel de error aceptable para terminar las iteraciones 
    % max_iter: Número máximo de iteraciones permitidas
    
    % OUTPUT: Vector de N + 1 coordenadas con el precio de la opción en t = 0
    %----------------------------------------------------------------------
        
    % Paso temporal
    dt = T / M;

    % Matrices y vectores
    sol = zeros(N + 1, M + 1);
    vector_S = linspace(0, S_max, N + 1);
    vector_i = (1:N-1)';
    vector_t = linspace(0, T, M + 1);

    % Evaluación de funciones sigma, r y q en los puntos del t_j
    sigma_t = sigma(vector_t);
    r_t = r(vector_t);
    q_t = q(vector_t);

    % Payoff de la opción
    v = max(vector_S - K, 0);

    % Condiciones terminal y de contorno
    sol(:, end) = v;
    integral_r = -arrayfun(@(t) integral(@(s) r(s), t, T), vector_t);
    integral_q = -arrayfun(@(t) integral(@(s) q(s), t, T), vector_t);
    sol(end, :) = max(v(end), vector_S(end) * exp(integral_q) - K * exp(integral_r));

    % Coeficientes iniciales para el método de Crank-Nicolson
    alpha = 0.5 * dt * ((vector_i * sigma_t(M + 1)).^2 - (r_t(M + 1) - q_t(M + 1)) * vector_i);
    betha = dt * ((vector_i * sigma_t(M + 1)).^2 + r_t(M + 1));
    gamma = 0.5 * dt * ((vector_i * sigma_t(M + 1)).^2 + (r_t(M + 1) - q_t(M + 1)) * vector_i);

    % Resolución del PCL con el método SOR proyectado
    for j = M + 1:-1:2
        
        % Vector de términos independientes
        ant = sol(2:N, j);
        p = (2 - betha) .* ant + alpha .* [0; ant(1:end-1)] + gamma .* [ant(2:end); 0];

        g = zeros(N - 1, 1);
        g(1) = alpha(1) * sol(1, j);
        g(N - 1) = gamma(N - 1) * sol(N + 1, j);

        d = p + g;

        % Actualización de los coeficientes
        alpha = 0.5 * dt * ((vector_i * sigma_t(j - 1)).^2 - (r_t(j - 1) - q_t(j - 1)) * vector_i);
        betha = dt * ((vector_i * sigma_t(j - 1)).^2 + r_t(j - 1));
        gamma = 0.5 * dt * ((vector_i * sigma_t(j - 1)).^2 + (r_t(j - 1) - q_t(j - 1)) * vector_i);

        % Iteración del método SOR para resolver el sistema lineal
        error = realmax;
        iter = 0;
        sol(2:N, j - 1) = sol(2:N, j);

        while error > tol && iter < max_iter
            marca = sol(:, j - 1);
            iter = iter + 1;

            sol(2, j - 1) = max(v(2), (1 - omega) * sol(2, j - 1) + (omega / (2 + betha(1))) * (d(1) + alpha(1) * sol(1, j - 1) + gamma(1) * sol(3, j - 1)));
            for k = 3:N - 1
                sol(k, j - 1) = max(v(k), (1 - omega) * sol(k, j - 1) + (omega / (2 + betha(k - 1))) * (d(k - 1) + alpha(k - 1) * sol(k - 1, j - 1) + gamma(k - 1) * sol(k + 1, j - 1)));
            end
            sol(N, j - 1) = max(v(N), (1 - omega) * sol(N, j - 1) + (omega / (2 + betha(N - 1))) * (d(N - 1) + alpha(N - 1) * sol(N - 1, j - 1) + gamma(N - 1) * sol(N + 1, j - 1)));

            % Cálculo del error para verificar la convergencia
            error = norm(sol(:, j - 1) - marca);
        end
    end
    
    prices = sol(:, 1);
end