function[z,error]=montecarlo(a,b)
    exact=(sin(b)-sin(a));
    rango=[0,0]; 
    
    num_ciclos = 1000;
    z = zeros(1,num_ciclos)
    for N=1:100
        x=a+(b-a)*(rand(1000,1));
        term= sum((cos(x)).^2)/1000;
        rango=((N-1)*rango+term)/N;
        error(N)=(b-a)*sqrt((rango(2)-rango(1).^2)/1000/N);
        z(N)=(b-a)*rango(1);
    end
    N=1000*(1:1000);
    V=[z'*exact+error'*exact-error'*exact*ones(1000,1)];
    plot(N,V);
    xlabel('N')
end