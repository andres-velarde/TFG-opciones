function prices = put_europea_explicito(S_max,T,K,N,M,r,q,sigma)
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
    dS = S_max / N;
    
    % Paso temporal
    dt = T / M;
    
    % Matrices y vectores
    sol = zeros(N + 1, M + 1);
    vector_S = linspace(0,S_max,N+1);
    vector_t = linspace(0,T,M+1);

    % Condiciones terminal y de contorno
    sol(:, M+1) = max(K - vector_S,0);
    integral_r = -arrayfun(@(t) integral(@(s) r(s), t, T), vector_t);
    sol(1, :) = K * exp(integral_r);
    
    % Iteración temporal
    for j = M:-1:1
        alpha = 0.5 * dt * ((vector_S * sigma(vector_t(j+1)) / dS).^2 - (r(vector_t(j+1)) - q(vector_t(j+1))) * vector_S / dS);
        betha = 1 - dt * ((vector_S * sigma(vector_t(j+1)) / dS).^2 + r(vector_t(j+1)));
        gamma = 0.5 * dt * ((vector_S * sigma(vector_t(j+1)) / dS).^2 + (r(vector_t(j+1)) - q(vector_t(j+1))) * vector_S / dS);
        for i = 2:N
            sol(i,j) = alpha(i) * sol(i - 1,j+1)+betha(i) * sol(i,j+1)+gamma(i)* sol(i + 1, j + 1);
        end
    end
prices = sol(:,1);
end