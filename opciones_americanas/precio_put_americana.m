% Este código proporciona la gráfica del precio de una opción Call americana
%----------------------------------------------------------------------

% Datos del derivado financiero
K = 40; % Precio de ejercicio de la opción
T = 8/12; % Tiempo de vencimiento (en años)
q = @(x) 0.2 + x - x; % Rentabilidad de los dividendos (en función del tiempo)
r = @(x) 0.1 + x - x; % Tasa de interés libre de riesgo (en función del tiempo)
sigma = @(x) 0.3 + x - x; % Volatilidad (en función del tiempo)

% Datos de la discretización
Smax = 100; % Valor máximo del precio del subyacente
N = 500; % Número de puntos en la partición en S
M = 200; % Número de puntos en la partición temporal

%Datos del método SOR con proyección
omega = 1.42; % Factor de sobrerrelajación
tol = 0.0001; % Error para determinar el fin de las iteraciones
it_max = 100; % Número máximo de iteraciones

% Vector con los valores de C(S, 0) para cada S_i
result = put_americana_cn(Smax, T, K, N, M, r, q, sigma, omega, tol, it_max);

% Payoff de la opción
vector_S = linspace(0, Smax, N + 1);
payoff = max(K - vector_S, 0);

% Graficar resultados
figure;
plot(vector_S, result, 'b', 'DisplayName', 'Precio opción americana put');
hold on;
plot(vector_S, payoff, 'r--', 'DisplayName', 'Payoff');
xlabel('S');
ylabel('C(S,0)');
legend('show');
axis([0 Smax 0 max(result)]);
hold off;
