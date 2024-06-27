% Este código proporciona la gráfica del precio de una opción Call americana
%----------------------------------------------------------------------

% Datos del derivado financiero
K = 40; % Precio de ejercicio de la opción
T = 8/12; % Tiempo de vencimiento (en años)
q = @(x) 0.2 + x - x; % Rentabilidad de los dividendos (en función del tiempo)
r = @(x) 0.1 + x - x; % Tasa de interés libre de riesgo (en función del tiempo)
sigma = @(x) 0.3 + x - x; % Volatilidad (en función del tiempo)

% Datos de la discretización
Smax_americana = 100; % Valor máximo del precio del subyacente
N_americana = 500; % Número de puntos en la partición en S
M_americana = 200; % Número de puntos en la partición temporal

%Datos del método SOR con proyección
omega = 1.42; % Factor de sobrerrelajación
tol = 0.0001; % Error para determinar el fin de las iteraciones
it_max = 100; % Número máximo de iteraciones

% Vector con los valores de C(S, 0) para cada S_i
result_americana = call_americana_cn(Smax_americana, T, K, N_americana, M_americana, r, q, sigma, omega, tol, it_max);

% Payoff de la opción
vector_S_americana = linspace(0, Smax_americana, N_americana + 1);
payoff_americana = max(vector_S_americana-K, 0);

% Datos de la discretización explícita para la opción europea
Smax_europea = 100;
N_europea = 500;
M_europea = 500;
result_europea = call_europea_cn(Smax_europea, T, K, N_europea, M_europea, r, q, sigma);

% Vector con los valores de c(S, 0) para cada S_i
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