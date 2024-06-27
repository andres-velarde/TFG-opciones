function precios = precios_binprice(Smax, N, K, T, r, sigma, q, type, increment)
    % S_max: Precio máximo del activo subyacente
    % N: Número de puntos en la partición del eje S
    % K: Precio de ejercicio de la opción
    % T: Tiempo hasta la madurez (en años)
    % r: Tasa libre de riesgo (en función del tiempo)
    % q: Rendimiento de los dividendos (en función del tiempo)
    % sigma: Volatilidad (en función del tiempo)
    % type: 1 para opciones Call y 0 para opciones Put
    % increment: Número de divisiones que genera el árbol binomial
    
    % OUTPUT: Vector de N + 1 coordenadas con el precio de la opción en t = 0
    %----------------------------------------------------------------------
    
    % Vectores
    vector_S = linspace(0, Smax, N+1);
    precios = zeros(1, N+1); 

    % Recorrer cada tiempo t_j
    for i = 1:N+1
        [Price, Option] = binprice(vector_S(i), K, r, T, increment, sigma, type, q);
        precios(i) = Option(1,1);
    end
end
