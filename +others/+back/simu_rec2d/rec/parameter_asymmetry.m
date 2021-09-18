function parameter_asymmetry
%calculate the parameter for the reconnection on the asymmetry magnetopause
%all the paramters are based on magnetosheath data
%the wci, de and debye length is smaller than magnetosphere
%the wpe is larger than mangetosphere
%the relation of rhoi is unknown
lx=640; ly=640;
npt=50000000;
c=0.6;      
mass=100; 
tie=2; 
frs=8;
di=80/1.7125;
lamda=40;    %half width of current sheet
nm=0.1; ns=1.;
%Tm=1.2; Ts=1;
betas=4.4;
%bms=2;
b0s=0.5*c; b0m=-1.*c;
b0z=0; b0y=0;
%
n0=ns*ly-0.5*lamda*(ns-nm)*log((exp(2*ly/lamda)+1)/2);
ens=npt*ns/n0/lx;
enm=npt*nm/n0/lx;
%
me=frs^2*b0s^2/c^2/ens;
mi=me*mass;
%
tms=(1-((b0m/b0s)^2-1)/betas)*ens/enm;
Ts=(b0m^2-b0s^2)/2/(ens-enm*tms);
vte=sqrt(2*Ts/(1+tie)/me);
vti=vte*sqrt(tie/mass);
%
de=di/sqrt(mass);
%
wpe=c/de ;
wce=wpe/frs; wpi=c/di; wci=wce/mass;
%
debye=vte/wpe/sqrt(2);
rhoi=vti/wci
rhoe=vte/wce;
%
vdrift=tie/(1+tie);
va=b0s/sqrt(ens*mi);
betam=betas*nm/ns*tms/(b0m^2/b0s^2);
%
output=['the electron inertial length is: ',...
    num2str(de),', ',num2str(de*sqrt(ns/nm))];
disp(output);
output=['the electron cyclotron radius is: ',...
    num2str(rhoe),', ', num2str(rhoe*sqrt(tms)*b0s/abs(b0m))];
disp(output);
output=['the debey length is: ',num2str(debye),', ',...
    num2str(debye*sqrt(tms)*sqrt(ns/nm))];
disp(output);
output=['the peak density : ', num2str(ens),', ',num2str(enm)];
disp(output);
output=['the electron plasma frequency is: ',num2str(wpe)];
disp(output);
output=['the proton cyclotron frequency are: ',...
    num2str(wci),', ',num2str(wci*abs(b0m)/b0s)];
disp(output);
output=['the magnetospere beta value: ',num2str(betam)];
disp(output);
output=['the Alfven velocity are: ',num2str(va),', ',...
       num2str(va*abs(b0m)/b0s*sqrt(ns/nm))];
disp(output);
%
for i=1:ly
    yy=i-ly/2;
    en(i)=(nm+ns)/2+(ns-nm)/2*tanh(yy/lamda);
    en(i)=npt*en(i)/n0/lx;
    bxr(i)=(b0m+b0s)/2+(b0s-b0m)/2*tanh(yy/lamda);
    Tpar(i)=(b0s^2+2*ens*Ts-bxr(i)^2)/2/en(i);
    Pp(i)=2*en(i)*Tpar(i);
    deb(i)=sqrt(Tpar(i))/sqrt(en(i));
end
for j=1:ly-1
    grad(j)=Pp(j+1)-Pp(j);
end
if 1==1
plot(Tpar)
figure
plot(bxr)
figure
plot(en)
end