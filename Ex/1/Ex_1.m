%INICIO
clear
clc
rng(1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TSX = xlsread('Datos_Ex_1','Data','D3:D31');
EN = xlsread('Datos_Ex_1','Data','F3:F31');
EURCAD = xlsread('Datos_Ex_1','Data','H3:H31');
Montos = [50000 , 50000 , 50000];                                        %matriz de montos
Sigma = [std(TSX) , std(EN) , std(EURCAD)];                              %matriz de desviaci�n estandar
Rendprom = [mean(TSX) , mean(EN) , mean(EURCAD)];                        %matriz de rendimientos promedio
matcorr = xlsread('Datos_Ex_1','Data','L4:N6');     %matriz de correlaci�n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=250;                               %Timepo final
n=250;                               %Numero de incrementos de tiempo
dt=(T/n);                            %incremento de tiempo 1/1 = 1 dia
raiz_dt=sqrt(dt);                    %Raiz cuadrada del incremento del tiempo
N=1000;                              %Numero de trayectorias
trayImprimir = 20;                   %Imprimir 250 trayectorias
t=0:dt:dt*(n);                       %forma en que se van dando los inrementos de tiempo
ultimaCol = (length(t));             %longitud del tiempo, es la ultima columna

S1=zeros(N,(n+1));                   %Matriz de tama�o N,n+1 con ceros para meter los resultados del activo 1
Xo1= xlsread('Datos_Ex_1','Data','C3');   %Precio inicial del Activo 1
S1(:,1) = Xo1;                       %Se mete el valor inicial del activo 1 en la primera columna
Rend1=Rendprom(1);                   %Promedio de Rendimientos del Activo 1
Desvest1=Sigma(1);                   %Desviaci�n estandar de los rendimientos del Activo 1

S2=zeros(N,(n+1));                   %Matriz de tama�o N,n+1 con ceros para meter los resultados del activo 2
Xo2=xlsread('Datos_Ex_1','Data','D3');;   %Precio inicial del Activo 2
S2(:,1) = Xo2;                       %Se mete el valor inicial del activo 2 en la primera columna
Rend2=Rendprom(2);                   %Promedio de Rendimientos del Activo 2
Desvest2=Sigma(2);                   %Desviaci�n estandar de los rendimientos del Activo 2

S3=zeros(N,(n+1));                   %Matriz de tama�o N,n+1 con ceros para meter los resultados del activo 3
Xo3=xlsread('Datos_Ex_1','Data','E3');     %Precio inicial del Activo 3
S3(:,1) = Xo3;                       %Se mete el valor inicial del activo 3 en la primera columna
Rend3=Rendprom(3);                   %Promedio de Rendimientos del Activo 3
Desvest3=Sigma(3);                   %Desviaci�n estandar de los rendimientos del Activo 3

eta = (chol(matcorr))';              %Cholesky de la matriz de correlaciones de los activos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:N                %primer ciclo, se hace 1000 veces para hacer las 1000 simulaciones
    for k=2:ultimaCol    %ciclo para determinar el valor de los activos
        zeta = [randn;randn;randn];             %matriz con los valores aleatorios normales
        epsilon = eta*zeta;                     %factor aleaorio que incluye as correlaciones
        deltaW1=raiz_dt*epsilon(1);             %delta w para el activo 1
        deltaW2=raiz_dt*epsilon(2);             %delta w para el activo 2
        deltaW3=raiz_dt*epsilon(3);             %delta w para el activo 3
       
        S1(i,k)=S1(i,k-1)+Rend1*S1(i,k-1)*dt+Desvest1*S1(i,k-1)*deltaW1;     %Precio Activo 1
        S2(i,k)=S2(i,k-1)+Rend2*S2(i,k-1)*dt+Desvest2*S2(i,k-1)*deltaW2;     %Precio Activo 2
        S3(i,k)=S3(i,k-1)+Rend3*S3(i,k-1)*dt+Desvest3*S3(i,k-1)*deltaW3;     %Precio Activo 3
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1=figure(1);                           %Grafica para el activo 1
S1_T = S1(:,ultimaCol);                   %Guarda el ultimo valor del activo 1
mediaS1_T = mean(S1_T)                    %Promedio de los valores simulados del activo 1
varianzaS1_T = var(S1_T)                  %Varianza de los valores simulados del activo 1
sqrt(varianzaS1_T)                        %Desviacion estandar de los valores simulados del activo 1
hist(S1_T,24)                             %Grafica el histograma para el activo 1 con 24 barras

fig2=figure(2);                           %Grafica para el activo 2
S2_T = S2(:,ultimaCol);                   %Guarda el ultimo valor del activo 2 
mediaS2_T = mean(S2_T)                    %Promedio de los valores simulados del activo 2
varianzaS2_T = var(S2_T)                  %Varianza de los valores simulados del activo 2
sqrt(varianzaS2_T)                        %Desviacion estandar de los valores simulados del activo 2
hist(S2_T,24)                             %Grafica el histograma para el activo 2 con 24 barras

fig3=figure(3);                           %Grafica para el activo 3
S3_T = S3(:,ultimaCol);                   %Guarda el ultimo valor del activo 3
mediaS3_T = mean(S3_T)                    %Promedio de los valores simulados del activo 3
varianzaS3_T = var(S3_T)                  %Varianza de los valores simulados del activo 3
sqrt(varianzaS3_T)                        %Desviacion estandar de los valores simulados del activo 3
hist(S3_T,24)                             %Grafica el histograma para el activo 3 con 24 barras

R1= (S1(:,T+1)-S1(:,1))./S1(:,1);         %Rendimintos del activo 1
R2= (S2(:,T+1)-S2(:,1))./S2(:,1);         %Rendimintos del activo 2
R3= (S3(:,T+1)-S3(:,1))./S3(:,1);         %Rendimintos del activo 3

delta_p=Montos(1)*R1+Montos(2)*R2+Montos(3)*R3;       %Estimacion del Valor del Portafolio

fig(4) = figure(4)                        %Grafica para los portafolios
hist(delta_p,24)                          %Grafica el histograma para los portfolios con 24 barras

delta_p_ordenado = sort(delta_p);         %Ordena los  rendimeintos de los portafolios de menor a mayor
VaR=delta_p_ordenado(10)                  %Da el valor del VaR con una significancia del 99 por ciento

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pt =(Montos(1)/Xo1)*S1_T + (Montos(2)/(Xo2 * Xo3))*(S2_T.*S3_T);
DeltaP2 = pt-(Montos(1)+Montos(2));
delta_p_ordenado2 = sort(DeltaP2);         %Ordena los  rendimeintos de los portafolios de menor a mayor
VaR2=delta_p_ordenado2(10)                 %Da el valor del VaR con una significancia del 99 por ciento