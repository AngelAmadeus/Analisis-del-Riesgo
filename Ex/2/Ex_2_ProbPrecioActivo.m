clear
clc
%Objetivo
%Cual es la probabilidad de que el precio del activo sea mayor que 24 en 1.80 años?

%Datos
S0 = 13;           %Precio Inicial
MUanual = 0.22;    %Media Anual
Sanual = 0.11;     %Sigma Anual(Desviacion Estandar)
Deltat = 1.8;      %Incremento del tiempo en años
pmayorque = 24;    %Entrada

%Resultados Intermedios
miu1 = ((MUanual)*(Deltat));
disp("La media del rendimiento en el timepo final es:")
disp(miu1)
des1 = MUanual - .5*sqrt(Sanual^2 * Deltat);
disp("La desviavion estandar del del rendimineto en el tiempo final es:")
disp(des1)
miu2 = log(S0) + (MUanual - (.5*(Sanual^2)))*Deltat;
disp("La media del logarito natural del precio fina es:")
disp(miu2)
des2 = sqrt(Sanual^2 * Deltat);
disp("La desviavion estandar del logarito natural del precio fina es:")
disp(des2)
miu3 = exp(miu2 + .5*(des2^2));
disp("La media del precio final es:")
disp(miu3)
des3 = sqrt(exp(2*miu2 + 2*(des2^2)) - exp(2*miu2 + des2^2));
disp("La desviación estandar del precio final es:")
disp(des3)

%Gráficas
%Distribución Normal Rendimientos en t = 1.8 años
x1 = linspace (miu1-4*des1,miu1+4*des1,10000);
y1 = normpdf(x1,miu1,des1);
%Rango de Valores para el Logaritmo Natural de los Precios
x2 = linspace (miu2-4*des2,miu2+4*des2,10000);
y2 = normpdf(x2,miu2,des2);
%Rango de valores para los precios
x3 = linspace (0,miu3+7*des3,10000);
y3 = lognpdf(x3,miu2,des2);

subplot(3,1,1), plot(x1,y1)
title("Distribución Normal Rendimientos en t = 1.8 años")
subplot(3,1,2), plot(x2,y2)
title("Rango de Valores para el Logaritmo Natural de los Precios")
subplot(3,1,3), plot(x3,y3)
title("Rango de Valores para los Precios")