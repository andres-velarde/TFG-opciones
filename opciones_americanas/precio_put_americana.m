% Datos del derivado financiero
S_1 = 55;
K = 40;
T = 8/12;
q = @(x) x-x;
r = @(x) 0.1+x-x;
sigma = @(x) 0.3+x-x;

% Datos de la discretización explícita
Smax = 100;
N = 500;
M = 100;
result = put_americana_cn(Smax, T, K, N, M, r, q, sigma, 1.42, 0.0001, 100);
% Calcular el payoff
vector_S = linspace(0, Smax, N + 1);
payoff = max(K - vector_S, 0);

% Graficar resultados
figure;
plot(vector_S, result, 'b', 'DisplayName', 'Precio opción americana put');
hold on;
plot(vector_S, payoff, 'r--', 'DisplayName', 'Payoff');
xlabel('S');
ylabel('P(S,0)');
legend('show');
axis([0 Smax 0 max(result)]);
hold off;
