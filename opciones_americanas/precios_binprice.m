function precios = precios_binprice(Smax, N, K, T, r, sigma, q, type, increment)
    % Vector de precios del subyacente
    vector_S = linspace(0, Smax, N+1);
    precios = zeros(1, N+1); % Inicializar el vector de la frontera

    % Recorrer cada tiempo t
    for i = 1:N+1
        [Price, Option] = binprice(vector_S(i), K, r, T, increment, sigma, type, q);
        precios(i) = Option(1,1);
    end
end
