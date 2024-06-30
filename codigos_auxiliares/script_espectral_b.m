% Definir funciones r, q y sigma
T = 5/12;
q = @(x) exp(-2*x-1.5);
r = @(x) log(2*x+2)/8;
sigma = @(x) sin(20*x)/10+0.3;
T = 8/12;

% Graficar los autovalores
figure;

% Llamar a la función con los parámetros
N = 10;
M = 100;
[v_a, v_b] = autovalores(T, N, M, r, q, sigma);

subplot(1,1,1);
display_name = sprintf('N=%d y M=%d', N, M);
plot(0:M, v_b, '-', 'DisplayName', display_name);
hold on;
disp(['Valor máximo de los autovalores (B-1) ', display_name, ': ', num2str(max(v_b))]);

% Llamar a la función con los parámetros
N = 50;
M = 100;
[v_a, v_b] = autovalores(T, N, M, r, q, sigma);

subplot(1,1,1);
display_name = sprintf('N=%d y M=%d', N, M);
plot(0:M, v_b, '-', 'DisplayName', display_name);
hold on;
disp(['Valor máximo de los autovalores (B-1) ', display_name, ': ', num2str(max(v_b))]);

% Llamar a la función con los parámetros
N = 80;
M = 100;
[v_a, v_b] = autovalores(T, N, M, r, q, sigma);

subplot(1,1,1);
display_name = sprintf('N=%d y M=%d', N, M);
plot(0:M, v_b, '-', 'DisplayName', display_name);
hold on;
disp(['Valor máximo de los autovalores (B-1) ', display_name, ': ', num2str(max(v_b))]);

% Llamar a la función con los parámetros
N = 120;
M = 100;
[v_a, v_b] = autovalores(T, N, M, r, q, sigma);

subplot(1,1,1);
display_name = sprintf('N=%d y M=%d', N, M);
plot(0:M, v_b, '-', 'DisplayName', display_name);
hold on;
disp(['Valor máximo de los autovalores (B-1) ', display_name, ': ', num2str(max(v_b))]);

% Llamar a la función con los parámetros
N = 200;
M = 100;
[v_a, v_b] = autovalores(T, N, M, r, q, sigma);

subplot(1,1,1);
display_name = sprintf('N=%d y M=%d', N, M);
plot(0:M, v_b, '-', 'DisplayName', display_name);
hold on;
disp(['Valor máximo de los autovalores (B-1) ', display_name, ': ', num2str(max(v_b))]);

% Final
xlabel('Tiempo');
ylabel('Autovalores');
title('Autovalores máximos en función del tiempo');
legend;
