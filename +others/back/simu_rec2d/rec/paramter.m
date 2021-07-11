%calculate some paramters for reconnection simulation
function paramter
%the paramters needed to be input
lx=1280; ly=1280;
npt=100000000;
c=0.6;      
mass=25;   omass=16;
tie=5; tio=1; 
fr=3;
di=25;
lamda=di*0.5;
n0=1; nb=0.2;
%
vte=c/fr/sqrt(1+tie)/sqrt(2.);   %thermal velocity defined by Baumjohann
vti=vte*sqrt(tie/mass);
vto=1/sqrt(tio*omass);
%
de=di/sqrt(mass);
%
nratio=nb*ly/(nb*ly+4*lamda*n0);
den0=npt*(1-nratio)/lx/4/lamda;
denb=den0*nb/n0;
%
wpe=c/de ;
wce=wpe/fr; wpi=c/di; wci=wce/mass;
%
b0x=1*c; b0z=b0x; b0y=0;
%
me=fr^2*b0x^2/c^2/den0;
mi=me*mass;
qi=wci*mi*c/b0x;
qe=-qi;
%
debye=vte/wpe;
rhoi=vti/wci
rhoe=vte/wce;
%
vdrift=tie/(1+tie);
va=b0x/sqrt(den0*mi);
beta=den0*me*vte^2*(1+tie)/b0x^2;
%
output=['the electron inertial length is: ',num2str(de)];
disp(output);
output=['the electron cyclotron radius is: ',num2str(rhoe)];
disp(output);
output=['the debey length is: ',num2str(debye)];
disp(output);
output=['the peak density in the current sheet is: ', num2str(den0)];
disp(output);
output=['the background density is: ',num2str(denb)];
disp(output);
output=['the electron plasma frequency is: ',num2str(wpe)];
disp(output);
output=['the proton cyclotron frequency is: ',num2str(wci)];
disp(output);
output=['the Alfven velocity is: ',num2str(va)];
disp(output);
output=['the beta value is: ',num2str(beta)];
disp(output);
%
for i=1:ly
    yy=i-ly/2;
    en(i)=den0*sech(yy/lamda).^2;
end
if 1==1
plot(en)
end

