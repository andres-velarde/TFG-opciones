% Datos del derivado financiero
S_1 = 55;
K = 40;
T = 8/12;
q = @(x) x-x;
r = @(x) 0.1+x-x;
sigma = @(x) 0.3+x-x;

% Datos de la discretización explícita para la opción americana
Smax_americana = 100;
N_americana = 200;
M_americana = 500;
result_americana = call_americana_cn(Smax_americana, T, K, N_americana, M_americana, r, q, sigma, 0.9, 0.0001, 100);

% Calcular el payoff de la opción americana
vector_S_americana = linspace(0, Smax_americana, N_americana + 1);
payoff_americana = max(vector_S_americana-K, 0);

% Datos de la discretización explícita para la opción europea
Smax_europea = 100;
N_europea = 500;
M_europea = 500;
result_europea = call_europea_cn(Smax_europea, T, K, N_europea, M_europea, r, q, sigma);

% Calcular el payoff de la opción europea
vector_S_europea = linspace(0, Smax_europea, N_europea + 1);
payoff_europea = max(vector_S_europea-K, 0);

% Graficar resultados
figure;
plot(vector_S_americana, result_americana, 'b', 'DisplayName', 'Precio opción americana Call');
hold on;
plot(vector_S_americana, payoff_americana, 'r--', 'DisplayName', 'Payoff');
plot(vector_S_europea, result_europea, 'g', 'DisplayName', 'Precio opción europea Call');
xlabel('S');
ylabel('Precio de la opción');
legend('show');
axis([0 max(Smax_americana, Smax_europea) 0 max(max(result_americana), max(result_europea))]);
hold off;
