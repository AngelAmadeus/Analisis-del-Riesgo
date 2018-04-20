clear
clc
%Datos
S0 = 13;
MUanual = 0.22;
Sanual = 0.11;
Deltat = 1.8; %años
pmayorque = 24;
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



%Gráficas
%Distribución Normal Rendimientos en t = 1.8 años
x1 = linspace (miu1-4*des1,miu1+4*des1,10000);
y1 = normpdf(x1,miu1,des1);
%Distribuciones probabilisticas correspondentes a t = 1.8 años
x2 = linspace (miu2-4*des2,miu2+4*des2,10000);
y2 = normpdf(x2,miu2,des2);

subplot(2,1,1), plot(x1,y1)
title("Distribución Normal Rendimientos en t = 1.8 años")
subplot(2,1,2), plot(x2,y2)
title("Distribuciones probabilisticas correspondentes a t = 1.8 años")

