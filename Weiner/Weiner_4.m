%Archivo: Wiener.m
%Simula un proceso de Wiener W, donde dW=\sqrt(dt)*epsilon
clear
clc
%Todo está basado en cierta Unidad del tiempo (meses, bimestres, años,etc.)
%pablo abrir
T=11;                   %Numero de unidades del tiempo, T2 del problema.
%pablo cerrar
n=10;                   %Numero de incrementos de tiempo
dt=(T/n);               %Incremento del tiempo
raiz_dt=sqrt(dt);       %Raiz cuadrada del incremento del tiempo
N=1000;                 %Numero de trayectorias
%pablo abrir
trayImprimir=20;        %Numero de trayectorias que se van a imprimir
%pablo cerrar
%Periodo de tiempo      %Tiempo total considerado [0,T]
t=0:dt:dt*(n);
ultimaCol = (length(t));
% for k=1:n
%     f1a(k)=sqrt(t(k));%Guardar en f la función raíz cuadrada
%     f2a(k)=-sqrt(t(k));
% end
W=zeros(N,(n+1));
%pablo abrir
X0=18;
X=zeros(N,(n+1));
X(:,1) = X0;
XFINAL=24;                      %no se utiliza
TO=0;                           %no se utiliza
T1=4;
a1=8;
a2=0;
b1=5;
b2=4;
%pablo cerrar
fig2=figure(2);
for i=1:N
    for k=2:ultimaCol
        deltaW=raiz_dt*randn;
        W(i,k)=W(i,k-1)+raiz_dt*randn;
        if (t(k) < T1)
            deltaX = a1*dt+b1*deltaW;
        else
            deltaX = a2*dt+b2*deltaW;
        end
        X(i,k) = X(i,k-1)+deltaX;
    end
    if (i < min(N, trayImprimir))
        switch mod(i,6)
            case 0
                plot(t,W(i,:),'b','LineWidth',0.5);       
            case 1
                plot(t,W(i,:),'g','LineWidth',0.5);       
            case 2
                plot(t,W(i,:),'r','LineWidth',0.5);       
            case 3
                plot(t,W(i,:),'c','LineWidth',0.5);       
            case 4
                plot(t,W(i,:),'m','LineWidth',0.5);       
            case 5
                plot(t,W(i,:),'y','LineWidth',0.5);       
            case 6
                plot(t,W(i,:),'k','LineWidth',0.5);       
        end
        hold on
    end
end
% plot(t,f1a,'k','LineWidth',1.5);
% hold on
% 
% plot(t,f2a,'k','LineWidth',1.5);
% hold on
xlabel('tiempo t ','FontSize',15); 
ylabel('Capital X(t) ','FontSize',15);
xlim([0,T])
grid
dirpath=[pwd '\Wiener' '\']
    if dirpath(end) ~= '\', dirpath = [dirpath '\']; end
    if (exist(dirpath, 'dir') == 0), mkdir(dirpath); end
nombreFigura= sprintf('N_%d_Trayectorias_de_un_proceso_de_Wiener',min(N,trayImprimir));
print (fig2,'-dpng', [dirpath nombreFigura]);
%hgsave (fig2,[dirpath nombreFigura]);
% close (fig2)
fig3=figure(3);
X_T = X(:,ultimaCol);              %Se cambia w por x para tener X(T2)
mediaX_T = mean(X_T);              %Se cambia w por x para tener X(T2)
varianzaX_T = var(X_T);            %Se cambia w por x para tener X(T2)
hist(X_T,30)                       %Se cambia w por x para tener X(T2)
dirpath=[pwd '\Wiener' '\']
    if dirpath(end) ~= '\', dirpath = [dirpath '\']; end
    if (exist(dirpath, 'dir') == 0), mkdir(dirpath); end
nombreFigura= sprintf('Histograma_del_proceso_de_Wiener_en_el_tiempo_T%d',T);
print (fig3,'-dpng', [dirpath nombreFigura]);
disp(mediaX_T)
disp(varianzaX_T)
%hgsave (fig2,[dirpath nombreFigura]);
% close (fig2)