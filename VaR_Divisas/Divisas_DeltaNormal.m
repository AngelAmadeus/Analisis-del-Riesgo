montos=[17189138.62,17189138.62,-16314423.43];
rendprom=[-0.00067;0.00000;0.00000];
matv=[5.73399E-05,-5.54807E-08,4.83799E-08;-5.54807E-08,3.35735E-09,4.17754E-09;4.83799E-08,4.17754E-09,2.44506E-08];
EDeltaP=montos*rendprom
VarDeltaP=montos*matv*montos'
sqrt(VarDeltaP)
x=[-400000:1000:400000];
plot(x,normpdf(x,EDeltaP,sqrt(VarDeltaP)))