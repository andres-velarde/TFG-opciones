% Definir parámetros
S_1 = 55;          % Precio del activo subyacente
K = 52;      % Precio de ejercicio
Time = 6/12;      % Tiempo hasta la madurez en años
q = 0.15;          % Tasa de dividendos
r = 0.08;       % Tasa de interés sin riesgo
sigma = 0.44;      % Volatilidad
Steps = 5000;     % Número de pasos en el árbol binomial

% Fechas
Settle = datetime('today');           % Fecha de liquidación
Maturity = Settle + calmonths(8);     % Fecha de vencimiento (8 meses)

% Crear el árbol de precios binomial usando el modelo CRR
StockSpec = stockspec(sigma, S_1, 'Continuous', q);
RateSpec = intenvset('ValuationDate', Settle, 'StartDates', Settle, 'EndDates', Maturity, 'Rates', r);
TimeSpec = crrtimespec(Settle, Maturity, Steps);

% Crear el modelo de árbol binomial CRR
CRRTree = crrtree(StockSpec, RateSpec, TimeSpec);

% Especificar los parámetros de la opción
OptSpec = 'call';  % Tipo de opción (call o put)

% Valorar la opción americana utilizando el árbol CRR
[AmericanPutPrice, AmericanPutPriceTree] = optstockbycrr(CRRTree, OptSpec, K, Settle, Maturity);

% Mostrar el resultado
disp(['El precio de la opción de venta americana es: ', num2str(AmericanPutPrice)]);