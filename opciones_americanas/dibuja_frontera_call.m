% Datos del derivado financiero
K = 40;
T = 8/12;
q = @(x) 0.2 + x - x;
r = @(x) 0.1 + x - x;
sigma = @(x) 0.3 + x - x;

% Datos de la discretización explícita
Smax = 100;
N = 500;
M = 200;
result = cn_call_am(Smax, T, K, N, M, r, q, sigma, 1.42, 0.0001, 100);

% Calcular el payoff
vector_t = linspace(0, T, M);
boundary = frontera_call(result, K, Smax);

% Graficar resultados
figure;
hold on;

% Colorear la parte superior (verde)
fill([vector_t, fliplr(vector_t)], [boundary, Smax*ones(size(boundary))], 'g', 'FaceAlpha', 0.3, 'EdgeColor', 'none');

% Colorear la parte inferior (rojo)
fill([vector_t, fliplr(vector_t)], [boundary, zeros(size(boundary))], 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');

% Dibujar la frontera libre
plot(vector_t, boundary, 'b', 'LineWidth', 1.5);

xlabel('t');
ylabel('Precio de ejercicio óptimo');
legend('Región de ejercicio', 'Región de continuación', 'Frontera libre para una opción Call');
title('Frontera libre');
axis([0 T 0 Smax]);

hold off;
