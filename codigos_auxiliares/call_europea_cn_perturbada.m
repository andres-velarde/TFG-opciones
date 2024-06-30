function prices = call_europea_cn_perturbada(S_max,T,K,N,M,r,q,sigma,media,desviacion_tipica,debug)
    % Paso temporal
    dt = T / M;
    
    % Matrices y vectores
    sol = zeros(N + 1, M + 1);
    vector_S = linspace(0,S_max,N+1);
    vector_i = (1:N-1)';
    vector_t = linspace(0,T,M+1);
    
    random_sigma = randn(1,M+1)*desviacion_tipica+media;
    sigma_t = max(sigma(vector_t) + random_sigma, 0);
    sigma_t = min(sigma_t, 1);
    
    random_r = randn(1,M+1)*desviacion_tipica*0.75+media;
    r_t = max(r(vector_t)+random_r,0);
    r_t = min(r_t,1);
    
    random_q = randn(1,M+1)*desviacion_tipica+media;
    q_t = max(q(vector_t)+random_q,0);
    q_t = min(q_t,1);
    
    if debug
        figure();
        plot(0:1:M, sigma_t, 'DisplayName', '\sigma(t)'); % Etiqueta para sigma_t
        hold on;
        plot(0:1:M, r_t, 'DisplayName', 'r(t)'); % Etiqueta para r_t
        plot(0:1:M, q_t, 'DisplayName', 'q(t)'); % Etiqueta para q_t
        axis([0 M -0.5 1.5]);

        xlabel('Tiempo');
        ylabel('Valor');
        title('Evolución de \sigma(t), r(t), y q(t)');

        legend; % Generar la leyenda con las etiquetas especificadas
        hold off;
    end
    
    % Condiciones terminal y de contorno
    sol(:, M+1) = max(vector_S - K,0);
    integral_r = -arrayfun(@(t) integral(@(s) r(s), t, T), vector_t);
    integral_q = -arrayfun(@(t) integral(@(s) q(s), t, T), vector_t);
    sol(N+1, :) = S_max * exp(integral_q) - K * exp(integral_r);
    
    gamma = 0.5 * dt * ((vector_i * sigma_t(M+1)).^2 + (r_t(M+1) - q_t(M+1)) * vector_i);
    betha = dt * ((vector_i * sigma_t(M+1)).^2 + r(T));
    alpha = 0.5 * dt * ((vector_i * sigma_t(M+1)).^2 - (r_t(M+1) - q_t(M+1)) * vector_i);
    
    % Generación de los coeficientes y resolución del sistema
    for j = M+1:-1:2
        
        ant = sol(2:N,j);
        d = (2-betha) .* ant + alpha .* [0;ant(1:end-1)] + gamma .* [ant(2:end);0];
        
        g = zeros(N-1, 1);
        g(1) = alpha(1) * sol(1, j);
        g(N-1) = gamma(N-1) * sol(N+1, j);
        
        %Nuevos coeficientes 
        
        gamma = 0.5 * dt * ((vector_i * sigma_t(j-1)).^2 + (r_t(j-1) - q_t(j-1)) * vector_i);
        betha = dt * ((vector_i * sigma_t(j-1)).^2 + r_t(j-1));
        alpha = 0.5 * dt * ((vector_i * sigma_t(j-1)).^2 - (r_t(j-1) - q_t(j-1)) * vector_i);
        
        C = diag(2+betha) - diag(alpha(2:end), -1) - diag(gamma(1:end-1), 1);
        
        h = zeros(N-1, 1);
        h(1) = -alpha(1) * sol(1, j-1);
        h(N-1) = -gamma(N-1) * sol(N+1,j-1);
    
        sol(2:N, j-1) = tridiagonal_matrix(C, d + g - h);
    end
prices = sol(:,1);
end