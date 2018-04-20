%Archivo: Wiener.m
%Simula un proceso de Wiener W, donde dW=\sqrt(dt)*epsilon
clear
clc
%Todo está basado en cierta Unidad del tiempo (meses, bimestres, años,etc.)
T=17;                   %Numero de unidades del tiempo %ESTO ES T2
n=100;                  %Numero de incrementos de tiempo
dt=(T/n);               %Incremento del tiempo
raiz_dt=sqrt(dt);       %Raiz cuadrada del incremento del tiempo
N=1000;                 %Numero de trayectorias
trayImprimir = 20;
%Periodo de tiempo      %Tiempo total considerado [0,T]
t=0:dt:dt*(n);
ultimaCol = (length(t));

X0 = 14;               %valor inicial de capita o dinero
W=zeros(N,(n+1));      %matriz de zeros para meter dats desúes de tamaño N x n+1; para el proceso de wiener
X=zeros(N,(n+1));      %matriz de zeros para meter dats desúes de tamaño N x n+1; para os valores del capital
X(:,1) = X0;           %idica que la matriz X tiene el vlor de X0 para todos los alores en la columna 1

a1=0;
b1=2;
a2=-2;
b2=5;
T1=6;

fig1=figure(1);                      %se reserva un espacio para graficar
for i=1:N                            %va desde la tryectoria 1 a a N
    for k=2:ultimaCol                %va desde los valores de la segunda columna de la matriz
        deltaW=raiz_dt*randn;
        W(i,k)=W(i,k-1)+deltaW;
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
                plot(t,X(i,:),'b','LineWidth',0.5);       
            case 1
                plot(t,X(i,:),'g','LineWidth',0.5);       
            case 2
                plot(t,X(i,:),'r','LineWidth',0.5);       
            case 3
                plot(t,X(i,:),'c','LineWidth',0.5);       
            case 4
                plot(t,X(i,:),'m','LineWidth',0.5);       
            case 5
                plot(t,X(i,:),'y','LineWidth',0.5);       
            case 6
                plot(t,X(i,:),'k','LineWidth',0.5);       
        end
        hold on
    end
end

xlabel('tiempo t','FontSize',15); 
ylabel('Capital X(t)','FontSize',15);
xlim([0,T])
grid

dirpath=[pwd '\Wiener' '\']                              %guardar a gráfica
    if dirpath(end) ~= '\', dirpath = [dirpath '\']; end
    if (exist(dirpath, 'dir') == 0), mkdir(dirpath); end
nombreFigura= sprintf('N_%d_Trayectorias_de_un_proceso_de_X',min(N,trayImprimir));
print (fig1,'-dpng', [dirpath nombreFigura]);
%hgsave (fig2,[dirpath nombreFigura]);
%close (fig2)

fig2=figure(2);
X_T = X(:,ultimaCol);        %acceso a la ultima columna de X
mediaX_T = mean(X_T)
varianzaX_T = var(X_T)
std(X_T)
sqrt(varianzaX_T)
hist(X_T,30)                 %histograma de 30 barritas
dirpath=[pwd '\Wiener' '\']
    if dirpath(end) ~= '\', dirpath = [dirpath '\']; end
    if (exist(dirpath, 'dir') == 0), mkdir(dirpath); end
nombreFigura= sprintf('Histograma_del_proceso_de_X_en_el_tiempo_T%d',T);
print (fig2,'-dpng', [dirpath nombreFigura]);
%hgsave(fig2,[dirpath nombreFigura]);
%close (fig2)