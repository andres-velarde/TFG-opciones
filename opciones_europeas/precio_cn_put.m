% Este código proporciona la gráfica del precio de una opción Call
% americana usando el método de Crank-Nicolson
%----------------------------------------------------------------------

% Datos del derivado financiero
K = 40; % Precio de ejercicio de la opción
T = 8/12; % Tiempo de vencimiento (en años)
q = @(x) 0.2 + x - x; % Rentabilidad de los dividendos (en función del tiempo)
r = @(x) 0.1 + x - x; % Tasa de interés libre de riesgo (en función del tiempo)
sigma = @(x) 0.3 + x - x; % Volatilidad (en función del tiempo)

% Datos de la discretización
Smax = 100; % Valor máximo del precio del subyacente
N = 50; % Número de puntos en la partición en S
M = 200; % Número de puntos en la partición temporal

% Vector con los valores de c(S, 0) para cada S_i
result = put_europea_cn(Smax,T,K,N,M,r,q,sigma);

% Graficar resultados
figure();
subplot(1,1,1);
plot(0:1:N,result);
axis([0 N 0 60])