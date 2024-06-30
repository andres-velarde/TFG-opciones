% Datos del derivado financiero
K = 50;
T = 5/12;
r = @(x) 0.1 + x - x;
sigma = @(x) 0.3 + x - x;

% Datos de la discretización explícita
Smax = 100;
N = 100;
M = 100;

figure;
hold on;

% Vector de volatilidades a evaluar
q_values = 0:0.1:0.5;

% Calcular el precio de la opción Put para cada sigma y almacenar los resultados
subplot(1, 2, 1);
title('Opción Put Europea');
for i = 1:length(q_values)
    d = q_values(i);
    q = @(x) d + x - x;
    result = put_europea_cn(Smax, T, K, N, M, r, q, sigma);

    plot(0:1:N, result, '-', 'DisplayName', sprintf('Dividend yield de %.0f%%', q_values(i) * 100));
    legend('show');
    hold on;
end
axis([0 100 0 50]);

% Calcular el precio de la opción Call para cada sigma y almacenar los resultados
subplot(1, 2, 2);
title('Opción Call Europea');
for i = 1:length(q_values)
    d = q_values(i);
    q = @(x) d + x - x;
    result = call_europea_cn(Smax, T, K, N, M, r, q, sigma);

    plot(0:1:N, result, '-', 'DisplayName', sprintf('Dividend yield de %.0f%%', q_values(i) * 100));
    legend('show');
    hold on;
end
axis([0 100 0 50]);
