% Datos del derivado financiero
K = 52;
T = 6/12;
q = @(x) 0.2+x-x;
r = @(x) 0.1+x-x;
sigma = @(x) 0.3+x-x;

% Datos de la discretización explícita
Smax = 100;
N = 500;
M = 500;
result = call_americana_cn(Smax, T, K, N, M, r, q, sigma, 1.42, 0.0001, 100);
% Calcular el payoff
vector_S = linspace(0, Smax, N + 1);
payoff = max(vector_S-K, 0);

% Graficar resultados
figure;
plot(vector_S, result, 'b', 'DisplayName', 'Precio opción americana call');
hold on;
plot(vector_S, payoff, 'r--', 'DisplayName', 'Payoff');
xlabel('S');
ylabel('C(S,0)');
legend('show');
axis([0 Smax 0 max(result)]);
hold off;