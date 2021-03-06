%INICIO
clear
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Montos = [100000 , 100000 , 300000];                            %matriz de montos
alpha1=Montos(1);                                               %Dinero a invertir en el activo 1
alpha2=Montos(2);                                               %Dinero a invertir en el activo 2
alpha3=Montos(3);                                               %Dinero a invertir en el activo 3
Sigma = [0.033007049 , 0.010217665 , 0.02008644];               %matriz de desviaci�n estandar
Rendprom = [-0.005340735 , -0.000976682 , -0.0007064];          %matriz de rendimientos promedio
matcorr = [1,0.6987531846,0.21962612328;
           0.6987531846,1,0.32254474919;
           0.21962612328,0.32254474919,1];                      %matriz de correlaci�n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=1;                                 %Timepo final
n=1;                                 %Numero de incrementos de tiempo
dt=(T/n);                            %incremento de tiempo 1/1 = 1 dia
raiz_dt=sqrt(dt);                    %Raiz cuadrada del incremento del tiempo
N=1000;                              %Numero de trayectorias
trayImprimir = 20;                   %Imprimir 250 trayectorias
t=0:dt:dt*(n);                       %forma en que se van dando los inrementos de tiempo
ultimaCol = (length(t));             %longitud del tiempo, es la ultima columna

S1=zeros(N,(n+1));                   %Matriz de tama�o N,n+1 con ceros para meter los resultados del activo 1
Xo1=.99;                             %Precio inicial del Activo 1
S1(:,1) = Xo1;                       %Se mete el valor inicial del activo 1 en la primera columna
Rend1=-0.005340735;                  %Promedio de Rendimientos del Activo 1
Desvest1=0.033007049;                %Desviaci�n estandar de los rendimientos del Activo 1

S2=zeros(N,(n+1));                   %Matriz de tama�o N,n+1 con ceros para meter los resultados del activo 2
Xo2=43.25;                           %Precio inicial del Activo 2
S2(:,1) = Xo2;                       %Se mete el valor inicial del activo 2 en la primera columna
Rend2=-0.000976682;                  %Promedio de Rendimientos del Activo 2
Desvest2=0.010217665;                %Desviaci�n estandar de los rendimientos del Activo 2

S3=zeros(N,(n+1));                   %Matriz de tama�o N,n+1 con ceros para meter los resultados del activo 3
Xo3=1.5;                             %Precio inicial del Activo 3
S3(:,1) = Xo3;                       %Se mete el valor inicial del activo 3 en la primera columna
Rend3=-0.0007064;                    %Promedio de Rendimientos del Activo 3
Desvest3=0.02008644;                 %Desviaci�n estandar de los rendimientos del Activo 3

matcorr = [1,0.69875318466701,0.219626123281827;
           0.69875318466701,1,0.322544749197685;
           0.219626123281827,0.322544749197685,1];        %Matriz de correlaciones de los Activos

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

delta_p=alpha1*R1+alpha2*R2+alpha3*R3;    %Estimacion del Valor del Portafolio

fig(4) = figure(4)                        %Grafica para los portafolios
hist(delta_p,24)                          %Grafica el histograma para los portfolios con 24 barras

delta_p_ordenado = sort(delta_p);         %Ordena los  rendimeintos de los portafolios de menor a mayor
VaR=delta_p_ordenado(51)                  %Da el valor del VaR con una significancia del 90 por ciento
Var2=VaR*sqrt(5)                          %Da el VaR para una semana despues