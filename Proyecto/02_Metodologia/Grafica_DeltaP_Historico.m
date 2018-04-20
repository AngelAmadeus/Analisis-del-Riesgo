clear
clc
%Grafica de la funcion de densidad de probabilidad normal (Para DeltaP)
miu = xlsread('MonHistDelta.xlsx','Delta P','E12');     %Media de los datos
desvest = xlsread('MonHistDelta.xlsx','Delta P','G8'); %desviaci�n estandar de los datos
x = linspace (miu-4*desvest,miu+4*desvest,10000); %espacio en x sobre el que se grafica
y = normpdf(x,miu,desvest); %Distribuci�n normal
fig1=figure(1);
plot(x,y);
%Grafixa de barras (Para simulaci�n Historica)
historico = xlsread('MonHistDelta.xlsx','Sim Historica','I2:I66'); %('Archivo','pesta�a','rango de celdas')
fig2=figure(2);
hist(historico,15) %Histograma de 15 barras
