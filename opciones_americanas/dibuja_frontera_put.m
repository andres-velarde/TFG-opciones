% Este código proporciona una gráfica de la frontera libre de una opción de tipo Put americana
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

% Matriz con los valores de P(S, t) para todo (S_i, t_j)
result = cn_put_am(Smax, T, K, N, M, r, q, sigma, omega, tol, it_max);

% Payoff de la opción
vector_t = linspace(0, T, M);

% Frontera libre
boundary = frontera_put(result, K, Smax);

% Graficar resultados
figure;
hold on;

% Colorear la parte superior (rojo)
fill([vector_t, fliplr(vector_t)], [boundary, Smax*ones(size(boundary))], 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');

% Colorear la parte inferior (verde)
fill([vector_t, fliplr(vector_t)], [boundary, zeros(size(boundary))], 'g', 'FaceAlpha', 0.3, 'EdgeColor', 'none');

% Dibujar la frontera libre
plot(vector_t, boundary, 'b', 'LineWidth', 1.5);

xlabel('t');
ylabel('Precio de ejercicio óptimo');
legend('Región de continuación', 'Región de ejercicio', 'Frontera libre para una opción Put');
title('Frontera libre');
axis([0 T 0 Smax]);

hold off;