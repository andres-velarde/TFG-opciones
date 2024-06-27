function frontera = frontera_put(F, K, Smax)
    [N, M] = size(F); % Obtener las dimensiones de la matriz F
    N = N - 1; % Ajustar para el índice 0
    M = M - 1; % Ajustar para el índice 0
    
    frontera = zeros(1, M); % Inicializar el vector de la frontera
    % Vector de precios del subyacente
    S = linspace(0, Smax, N+1);
    
    % Recorrer cada tiempo t
    for t = 1:M
        % Recorrer cada valor de S para encontrar la separación del payoff
        for i = 1:N+1
            % Calcular el payoff
            payoff = max(K - S(i), 0);
            
            % Encontrar el primer punto donde F(s, t) se separa del payoff
            if F(i, t) ~= payoff
                frontera(t) = S(i);
                break;
            end
        end
    end
end
