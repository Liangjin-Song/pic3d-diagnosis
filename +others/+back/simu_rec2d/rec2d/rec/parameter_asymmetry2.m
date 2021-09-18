function parameter_asymmetry2
%incorporate the effect of non uniform guide field
%calculate the parameter for the reconnection on the asymmetry magnetopause
%all the paramters are based on magnetosheath asympotic value
%the wci, de and debye length is smaller than magnetosphere
%the wpe is larger than mangetosphere
%the relation of rhoi is unknown
lx=1024; ly=512;
npt=50000000;
c=0.6;      
mass=64; 
tie=2; 
frs=5;
di=lx/32;
lamda=di*0.5;
nm=0.1; ns=1.;
tms=2;
betas=1.5;
b0s=0.5*c; b0m=-1.*c;
bgs=1.*b0s; b0y=0;
%
n0=ns*ly-0.5*lamda*(ns-nm)*log((exp(2*ly/lamda)+1)/2);
ens=npt*ns/n0/lx;
enm=npt*nm/n0/lx;
%
me=frs^2*b0s^2/c^2/ens;
mi=me*mass;
%
%tms=(1-((b0m/b0s)^2-1)/betas)*ens/enm
%Ts=(b0m^2-b0s^2)/2/(ens-enm*tms);
Ts=(b0s^2+bgs^2)*betas/2/ens;
Tm=tms*Ts;
vte=sqrt(2*Ts/(1+tie)/me);
vti=vte*sqrt(tie/mass);
%
de=di/sqrt(mass);
%
wpe=c/de ;
wce=wpe/frs; wpi=c/di; wci=wce/mass;
%
debye=vte/wpe/sqrt(2);
rhoi=vti/wci; rhoe=vte/wce;
%
vdrift=tie/(1+tie);
va=b0s/sqrt(ens*mi);
betam=2*enm*Tm/(b0s^2+bgs^2+2*ens*Ts-2*enm*Tm);
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
    en(i)=(enm+ens)/2+(ens-enm)/2*tanh(yy/lamda);
    bxr(i)=(b0m+b0s)/2+(b0s-b0m)/2*tanh(yy/lamda);
    Tpar(i)=(Ts+Tm)/2+(Ts-Tm)/2*tanh(yy/lamda);
    bg(i)=(b0s^2+bgs^2+2*ens*Ts-bxr(i)^2-2*en(i)*Tpar(i));
    bg(i)=sqrt(bg(i));
    Pp(i)=2*en(i)*Tpar(i);
end
if 1==1
plot(Pp)
figure
plot(bg)
figure
plot(en)
end