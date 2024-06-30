Cap = 200;
% Datos del derivado financiero
K = 40;
T = 8/12;
q = 0.2;
r = 0.1;
sigma = 0.3;

% Datos de la discretización explícita
Smax = 100;
N = Cap;
M = Cap;
h = Smax / N;

n_eps = 200;

figure;

hold on;  % Para mantener todas las gráficas en el mismo dibujo
[c, p] = blsprice(0:h:Smax, K, r, T, sigma, q);
epsilon = zeros(n_eps + 1, 1); % Ajustado a n_eps + 1

for j = n_eps + 1:-1:1
    k = (j-1) / n_eps*0.2;
    % Calcular el resultado para cada valor de k
    result = call_europea_cn_perturbada(Smax, T, K, N, M, @(x) r+x-x, @(x) q+x-x, @(x) sigma+x-x, 0,k, false);
    
    % Graficar cada resultado con su propia etiqueta
    epsilon(j) = max(abs(c' - result)) / max(abs(c)) * 100;
end

plot(0:n_eps, epsilon);
axis([0 n_eps 0 5]);

xlabel('Desviación típica');
ylabel('Valor');
title('Evolución del error');

hold off;
