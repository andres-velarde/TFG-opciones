% Datos del derivado financiero
K = 50;
T = 5/12;
q = @(x) 0.3+x-x;
r = @(x) 0.1+x-x;
sigma = @(x) 0.2+x-x;


% Datos de la discretización explícita
Smax = 100;
N = 1000;
M = 500;
result = call_europea_cn(Smax,T,K,N,M,r,q,sigma);

subplot(1,1,1);
plot(0:1:N,result);
axis([0 N 0 60])