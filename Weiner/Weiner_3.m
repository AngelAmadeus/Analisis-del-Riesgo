%Archivo: Wiener.m
%Simula un proceso de Wiener W, donde dW=\sqrt(dt)*epsilon
clear
clc
%Todo está basado en cierta Unidad del tiempo (meses, bimestres, años,etc.)
T=12;                   %Numero de unidades del tiempo %ESTO ES T2
n=1000;                 %Numero de incrementos de tiempo
dt=(T/n);               %Incremento del tiempo
raiz_dt=sqrt(dt);       %Raiz cuadrada del incremento del tiempo
N=1000;                 %Numero de trayectorias
trayImprimir = 20;
%Periodo de tiempo      %Tiempo total considerado [0,T]
t=0:dt:dt*(n);
ultimaCol = (length(t));
% for k=1:n
%     f1a(k)=sqrt(t(k));%Guardar en f la función raíz cuadrada
%     f2a(k)=-sqrt(t(k));
% end
%X0 = 14;
W=zeros(N,(n+1));
%X=zeros(N,(n+1));
%X(:,1) = X0;
S=zeros(N,(n+1));
S0=10;
S(:,1) = S0;
m1=0.2; %rendimiento promedio de la accion
g1=0.13; %desv std promedio de la accion

fig1=figure(1);
for i=1:N
    for k=2:ultimaCol
        deltaW=raiz_dt*randn;
        W(i,k)=W(i,k-1)+deltaW;
        S(i,k)=S(i,k-1)+m1*S(i,k-1)*dt+g1*S(i,k-1)*deltaW;
    end
    if (i < min(N, trayImprimir))
        switch mod(i,6)
            case 0
                plot(t,S(i,:),'b','LineWidth',0.5);       
            case 1
                plot(t,S(i,:),'g','LineWidth',0.5);       
            case 2
                plot(t,S(i,:),'r','LineWidth',0.5);       
            case 3
                plot(t,S(i,:),'c','LineWidth',0.5);       
            case 4
                plot(t,S(i,:),'m','LineWidth',0.5);       
            case 5
                plot(t,S(i,:),'y','LineWidth',0.5);       
            case 6
                plot(t,S(i,:),'k','LineWidth',0.5);       
        end
        hold on
    end
end
% plot(t,f1a,'k','LineWidth',1.5);
% hold on
% 
% plot(t,f2a,'k','LineWidth',1.5);
% hold on
xlabel('tiempo 60 dias','FontSize',15); 
ylabel('Precio S(t)','FontSize',15);
xlim([0,T])
grid
dirpath=[pwd '\Wiener' '\']
    if dirpath(end) ~= '\', dirpath = [dirpath '\']; end
    if (exist(dirpath, 'dir') == 0), mkdir(dirpath); end
nombreFigura= sprintf('N_%d_Trayectorias_de_GCARSOA1.MX',min(N,trayImprimir));
print (fig1,'-dpng', [dirpath nombreFigura]);
%hgsave (fig2,[dirpath nombreFigura]);
% close (fig2)
fig2=figure(2);
S_T = S(:,ultimaCol);
mediaS_T = mean(S_T)
varianzaS_T = var(S_T)
std(S_T);
sqrt(varianzaS_T)
hist(S_T,30)
dirpath=[pwd '\Wiener' '\']
    if dirpath(end) ~= '\', dirpath = [dirpath '\']; end
    if (exist(dirpath, 'dir') == 0), mkdir(dirpath); end
nombreFigura= sprintf('Histograma_del_precio_de_GCARSOA1.MX_en_el_tiempo_T%d',T);
print (fig2,'-dpng', [dirpath nombreFigura]);
%hgsave (fig2,[dirpath nombreFigura]);
% close (fig2)