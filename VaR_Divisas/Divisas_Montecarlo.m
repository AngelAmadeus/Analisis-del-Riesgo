%Archivo: MonteCarlo.m
%Simula un proceso de Wiener W, donde dW=\sqrt(dt)*epsilon
clear
clc
%Todo está basado en cierta Unidad del tiempo (meses, bimestres, años,etc.)
T=1;                    %Numero de dias a pronosticar
n=1;                   %Numero de incrementos de tiempo
dt=(T/n);               %Incremento del tiempo
raiz_dt=sqrt(dt);       %Raiz cuadrada del incremento del tiempo
N=1000;                     %Numero de trayectorias
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
S1=zeros(N,(n+1));
So1=1.7456; %S
S1(:,1) = So1;
m1=-0.00067; %rendimiento promedio S
g1=0.00757; %desv std S

S2=zeros(N,(n+1));
So2=0.9847; %P*
S2(:,1) = So2;
m2=-0.0000039; %rendimiento promedio P*
g2=0.00006; %desv std P*

S3=zeros(N,(n+1));
So3=0.9889; %precio P
S3(:,1) = So3;
m3=0.00000161; %rendimiento promedio P
g3=0.00016; %desv std P

gama = [1,-0.126448935,0.040859454;-0.126448935,1,0.461081433;0.040859454,0.461081433,1]
eta = (chol(gama))'

for i=1:N
    %Aquí surge la correlación de los rendimientos simulados
    for k=2:ultimaCol
        z1=randn;
        z2=randn;
        z3=randn;
        zeta = [z1;z2;z3];
        epsilon = eta*zeta;
        epsilon1 = epsilon(1);
        epsilon2 = epsilon(2);
        epsilon3 = epsilon(3);
        deltaW1=raiz_dt*epsilon1;
        deltaW2=raiz_dt*epsilon2;
        deltaW3=raiz_dt*epsilon3;
       
        S1(i,k)=S1(i,k-1)+m1*S1(i,k-1)*dt+g1*S1(i,k-1)*deltaW1;
        
        S2(i,k)=S2(i,k-1)+m2*S2(i,k-1)*dt+g2*S2(i,k-1)*deltaW2;
        
        S3(i,k)=S3(i,k-1)+m3*S3(i,k-1)*dt+g3*S3(i,k-1)*deltaW3;

    end
    fig2=figure(2);
    if (i < min(N, trayImprimir))
        switch mod(i,6)
            case 0
                plot(t,S1(i,:),'b','LineWidth',0.5);       

            case 1
                plot(t,S1(i,:),'g','LineWidth',0.5);       

            case 2
                plot(t,S1(i,:),'r','LineWidth',0.5);       

            case 3
                plot(t,S1(i,:),'c','LineWidth',0.5);       

            case 4
                plot(t,S1(i,:),'m','LineWidth',0.5);       

            case 5
                plot(t,S1(i,:),'y','LineWidth',0.5);       

            case 6
                plot(t,S1(i,:),'k','LineWidth',0.5);       

        end
        hold on
        hold on
        xlabel('tiempo','FontSize',15); 
        xlim([0,T])
        grid
    end
    fig3=figure(3);
    if (i < min(N, trayImprimir))
        switch mod(i,6)
            case 0
                plot(t,S2(i,:),'b','LineWidth',0.5);       

            case 1
                plot(t,S2(i,:),'g','LineWidth',0.5);       

            case 2
                plot(t,S2(i,:),'r','LineWidth',0.5);       

            case 3
                plot(t,S2(i,:),'c','LineWidth',0.5);       

            case 4
                plot(t,S2(i,:),'m','LineWidth',0.5);       

            case 5
                plot(t,S2(i,:),'y','LineWidth',0.5);       

            case 6
                plot(t,S2(i,:),'k','LineWidth',0.5);       

        end
        hold on
        xlabel('tiempo','FontSize',15); 
        xlim([0,T])
        grid
    end
    fig4=figure(4);
    if (i < min(N, trayImprimir))
        switch mod(i,6)
            case 0
                plot(t,S3(i,:),'b','LineWidth',0.5);       

            case 1
                plot(t,S3(i,:),'g','LineWidth',0.5);       

            case 2
                plot(t,S3(i,:),'r','LineWidth',0.5);       

            case 3
                plot(t,S3(i,:),'c','LineWidth',0.5);       

            case 4
                plot(t,S3(i,:),'m','LineWidth',0.5);       

            case 5
                plot(t,S3(i,:),'y','LineWidth',0.5);       

            case 6
                plot(t,S3(i,:),'k','LineWidth',0.5);       

        end
        hold on
        xlabel('tiempo','FontSize',15); 
        xlim([0,T])
        grid
    end
end
fig5=figure(5);
S1_T = S1(:,ultimaCol);
mediaS1_T = mean(S1_T)
varianzaS1_T = var(S1_T)
std(S1_T);
sqrt(varianzaS1_T)
hist(S1_T,30)

fig6=figure(6);
S2_T = S2(:,ultimaCol);
mediaS2_T = mean(S2_T)
varianzaS2_T = var(S2_T)
std(S2_T);
sqrt(varianzaS2_T)
hist(S2_T,30)

fig7=figure(7);
S3_T = S3(:,ultimaCol);
mediaS3_T = mean(S3_T)
varianzaS3_T = var(S3_T)
std(S3_T);
sqrt(varianzaS3_T)
hist(S3_T,30)

R1= (S1(:,T+1)-S1(:,1))./S1(:,1);
R2= (S2(:,T+1)-S2(:,1))./S2(:,1);
R3= (S3(:,T+1)-S3(:,1))./S3(:,1);

alpha1=17189138.62;
alpha2=17189138.62;
alpha3=-16314423.43;

delta_p=alpha1*R1+alpha2*R2+alpha3*R3;
fig(8) = figure(8)
hist(delta_p)
delta_p_ordenado = sort(delta_p);
VaR=delta_p_ordenado(51)