%Archivo: Wiener.m
%Simula un proceso de Wiener W, donde dW=\sqrt(dt)*epsilon
clear
clc
%Todo está basado en cierta Unidad del tiempo (meses, bimestres, años,etc.)
T=60;                   %Numero de unidades del tiempo %ESTO ES T2
n=60;                   %Numero de incrementos de tiempo
dt=(T/n);               %Incremento del tiempo
raiz_dt=sqrt(dt);       %Raiz cuadrada del incremento del tiempo
N=1000;                 %Numero de trayectorias
trayImprimir = 50;
%Periodo de tiempo      %Tiempo total considerado [0,T]
t=0:dt:dt*(n);
ultimaCol = (length(t));
% for k=1:n
%     f1a(k)=sqrt(t(k));%Guardar en f la función raíz cuadrada
%     f2a(k)=-sqrt(t(k));
% end

W=zeros(N,(n+1));
s=zeros(N,(n+1));
sigma1=0.010217665;
m1=-.00097668;
s(:,1)=43.25;
fig1=figure(1);

for i=1:N
    for k=2:ultimaCol
        epsilon=randn;
        dW=raiz_dt*epsilon;
         W(i,k)=W(i,k-1)+dW;
        s(i,k)=s(i,k-1)+m1*s(i,k-1)*dt+sigma1*s(i,k-1)*dW;
    end
    if (i < min(N, trayImprimir))
        switch mod(i,6)
            case 0
                plot(t,s(i,:),'b','LineWidth',0.5);       
            case 1
                plot(t,s(i,:),'g','LineWidth',0.5);       
            case 2
                plot(t,s(i,:),'r','LineWidth',0.5);       
            case 3
                plot(t,s(i,:),'c','LineWidth',0.5);       
            case 4
                plot(t,s(i,:),'m','LineWidth',0.5);       
            case 5
                plot(t,s(i,:),'y','LineWidth',0.5);       
            case 6
                plot(t,s(i,:),'k','LineWidth',0.5);       
        end
        hold on
    end
end
% plot(t,f1a,'k','LineWidth',1.5);
% hold on
% 
% plot(t,f2a,'k','LineWidth',1.5);
% hold on
xlabel('tiempo t','FontSize',15); 
ylabel('Capital X(t)','FontSize',15);
xlim([0,T])
grid

dirpath=[pwd '\Wiener' '\']
    if dirpath(end) ~= '\', dirpath = [dirpath '\']; end
    if (exist(dirpath, 'dir') == 0), mkdir(dirpath); end
nombreFigura= sprintf('N_%d_Trayectorias_de_un_proceso_de_X',min(N,trayImprimir));
print (fig1,'-dpng', [dirpath nombreFigura]);
%hgsave (fig2,[dirpath nombreFigura]);
% close (fig2)

fig2=figure(2);
s_T = s(:,ultimaCol);
medias_T = mean(s_T)
varianzas_T = var(s_T)
std(s_T)
sqrt(varianzas_T)
hist(s_T,30)
dirpath=[pwd '\Wiener' '\']
    if dirpath(end) ~= '\', dirpath = [dirpath '\']; end
    if (exist(dirpath, 'dir') == 0), mkdir(dirpath); end
nombreFigura= sprintf('Histograma_del_proceso_de_X_en_el_tiempo_T%d',T);
print (fig2,'-dpng', [dirpath nombreFigura]);
%hgsave (fig2,[dirpath nombreFigura]);
% close (fig2)