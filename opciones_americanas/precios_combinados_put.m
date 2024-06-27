% Datos del derivado financiero
K = 40;
T = 8/12;
q = @(x) 0.1+x-x;
r = @(x) 0.2+x-x;
sigma = @(x) 0.3+x-x;

% Datos de la discretización explícita para la opción americana
Smax_americana = 100;
N_americana = 500;
M_americana = 500;
result_americana = put_americana_cn(Smax_americana, T, K, N_americana, M_americana, r, q, sigma, 1.6, 0.0001, 100);

% Calcular el payoff de la opción americana
vector_S_americana = linspace(0, Smax_americana, N_americana + 1);
payoff_americana = max(K - vector_S_americana, 0);

% Datos de la discretización explícita para la opción europea
Smax_europea = 100;
N_europea = 500;
M_europea = 500;
result_europea = put_europea_cn(Smax_europea, T, K, N_europea, M_europea, r, q, sigma);

% Calcular el payoff de la opción europea
vector_S_europea = linspace(0, Smax_europea, N_europea + 1);
payoff_europea = max(K - vector_S_europea, 0);

% Graficar resultados
figure;
plot(vector_S_americana, result_americana, 'b', 'DisplayName', 'Precio opción americana Put');
hold on;
plot(vector_S_americana, payoff_americana, 'r--', 'DisplayName', 'Payoff');
plot(vector_S_europea, result_europea, 'g', 'DisplayName', 'Precio opción europea Put');
xlabel('S');
ylabel('Precio de la opción');
legend('show');
axis([0 max(Smax_americana, Smax_europea) 0 max(max(result_americana), max(result_europea))]);
hold off;
