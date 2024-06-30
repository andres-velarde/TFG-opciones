% Datos del derivado financiero
K = 50;
T = 5/12;
q = @(x) 0.2 + x - x;
r = @(x) 0.1 + x - x;

% Datos de la discretización explícita
Smax = 100;
N = 100;
M = 100;

figure;
hold on;

% Vector de volatilidades a evaluar
sigma_values = 0.1:0.1:0.7;

% Calcular el precio de la opción Put para cada sigma y almacenar los resultados
subplot(1, 2, 1);
title('Opción Put Europea');
for i = 1:length(sigma_values)
    d = sigma_values(i);
    sigma = @(x) d + x - x;
    result = put_europea_cn(Smax, T, K, N, M, r, q, sigma);
    integra = integral(@(s) sigma(s), 0, T);

    plot(0:1:N, result, '-', 'DisplayName', sprintf('Volatilidad de %.0f%%', sigma_values(i) * 100));
    legend('show');
    hold on;
end
axis([0 100 0 50]);

% Calcular el precio de la opción Call para cada sigma y almacenar los resultados
subplot(1, 2, 2);
title('Opción Call Europea');
for i = 1:length(sigma_values)
    d = sigma_values(i);
    sigma = @(x) d + x - x;
    result = call_europea_cn(Smax, T, K, N, M, r, q, sigma);
    integra = integral(@(s) sigma(s), 0, T);

    plot(0:1:N, result, '-', 'DisplayName', sprintf('Volatilidad de %.0f%%', sigma_values(i) * 100));
    legend('show');
    hold on;
end
axis([0 100 0 50]);