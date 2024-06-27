function frontera = frontera_call(F, K, Smax)
    [N, M] = size(F); % Obtener las dimensiones de la matriz F
    N = N - 1; % Ajustar para el índice 0
    M = M - 1; % Ajustar para el índice 0
    
    frontera = zeros(1, M); % Inicializar el vector de la frontera
    % Vector de precios del subyacente
    S = linspace(0, Smax, N+1);
    
    % Encontrar el índice aproximado de K en el vector S
    i_K = floor(K*N/Smax)+1;

    % Recorrer cada tiempo t
    for t = 1:M
        % Recorrer cada valor de S para encontrar la separación del payoff
        for i = i_K:N+1
            % Calcular el payoff
            payoff = max(S(i) - K, 0);
            
            % Encontrar el primer punto donde F(s, t) se iguala o supera el payoff
            if F(i, t) == payoff
                frontera(t) = S(i);
                break;
            end
        end
    end
end
