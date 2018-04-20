clear
clc

miu = -265;
desvest =137651 ;

x = linspace (miu-4*desvest,miu+4*desvest,10000);
y = normpdf(x,miu,desvest);
plot(x,y)