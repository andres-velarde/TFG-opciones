function frontera = frontera_call(F, K, Smax)
    % S_max: Precio máximo del activo subyacente
    % K: Precio de ejercicio de la opción
    % F: Matriz de dimensión (N + 1)(M + 1) con la función C(S, t) para todo t_j
    
    % OUTPUT: Vector de dimensión M + 1 con el valor de S*(t) para cada t_j
    %----------------------------------------------------------------------
    
    % Dimensiones de la matriz
    [N, M] = size(F);
    N = N - 1;
    M = M - 1;
    
    % Vectores
    frontera = zeros(1, M);
    S = linspace(0, Smax, N+1);
    
    % Índice aproximado de K en el vector S
    i_K = floor(K*N/Smax)+1;

    % Recorrer cada tiempo t para encontrar el valor S*(t)
    for t = 1:M
        % Recorrer cada valor de S para encontrar la separación del payoff
        for i = i_K:N+1
            % Calcular el payoff
            payoff = max(S(i) - K, 0);
            
            % Encontrar el primer punto donde F(s, t) se iguala el payoff
            if F(i, t) == payoff
                frontera(t) = S(i);
                break;
            end
        end
    end
end
