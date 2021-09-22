z=-10:0.01:10;
Ay=log(cosh(z));
Fai=Ay;
tau=1;delta=0.8;U=0.5;
mu=2*(1+tau)*U/(1+U);
nu=2*(1+tau)/((1+U)*tau);
Psi=(tau/(1+tau))*log((delta+(1-delta)*exp(-mu*Fai))./(delta+(1-delta)*exp(-nu*Fai)));
N=delta*exp(-Psi)+(1-delta)*exp(-Psi-mu*Fai);

%% calculate the electric field
Ez=zeros(1,length(z));
for i=1:length(z)
    Ez(i)=calc_Psi(z(i))-calc_Psi(z(i)+0.01);
end

f1=figure;
plot(z,Psi);
ylabel('\Psi');

f2=figure;
plot(z,Ez);
ylabel('Ez');

pet=zeros(length(z),1);
pet(1)=Ez(1);
for i=2:length(z)
    pet(i)=pet(i-1)+Ez(i);
end
pet=pet;

f3=figure;
plot(z,pet);
ylabel('\Psi0')


function Psi=calc_Psi(n)
Ay=log(cosh(n));
Fai=Ay;
tau=1;delta=0.1;U=5;
mu=2*(1+tau)*U/(1+U);
nu=2*(1+tau)/((1+U)*tau);
Psi=(tau/(1+tau))*log((delta+(1-delta)*exp(-mu*Fai))./(delta+(1-delta)*exp(-nu*Fai)));
end