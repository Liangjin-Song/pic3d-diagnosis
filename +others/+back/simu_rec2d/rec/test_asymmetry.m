%% test program for the initial set of asymmetry reconnection
bm=2;    
bs=-1;
tm=3;
ts=1;
nx=4800;
ny=2400;
npt=nx*ny*100;
di0=40;   % ion inertial length
w0=1/1.2*di0;  %half width of current sheet
c=0.6;   %speed of light
%%
betas=3;
alpha=100;
tie=2;
fr=2;
%%
z=3.5:ny+2.5;
zz1=3+ny/4;
zz2=3+ny*3/4;
% bx1=(b1+b2)/2*(tanh((z-0.25*Lz)/w0)-tanh((z-0.75*Lz)/w0)+...
%     tanh((z-1.25*Lz)/w0)-tanh((z+0.25*Lz)/w0)+1)+(b2-b1)/2;
%%-----------------the magnetic field-------------------------------
bx=(bm-bs)/2*tanh((z-zz2)/w0)+bm-(bm-bs)/2*tanh((z-zz1)/w0);
bcs=(bm+bs)/2;
bsym=(bm-bs)/2;

%%------------------the temperature------------------------------
temp=(tm-ts)/2*tanh((z-zz2)/w0)+tm-(tm-ts)/2*tanh((z-zz1)/w0);
tcs=(tm+ts)/2;
tsym=(tm+ts)/2;

%%-------------------the density profile------------------------
ns=bs^2*c^2/2*betas/ts/(1+tie);
pres_tot=bs^2*c^2/2+ns*ts*(1+tie);
nm=(pres_tot-bm^2*c^2/2)/tm/(1+tie);
ni=(pres_tot-bx.^2*c^2/2)./temp/(1+tie);
ncs=(pres_tot-bcs^2*c^2/2)/tcs/(1+tie);


%%
me=fr^2*bsym^2/ncs;
mi=me*alpha;
% vte=sqrt(tsym/me);
% vti=vte*sqrt(tie/alpha);
% de=di/sqrt(alpha);
% wpe=c/de;
% wce=wpe/fr;
% wpi=c/di;
% wci=wce/alpha;
% %%
% qi=wci*mi/c/bsym;
% qe=-qi;
% debye=vte/wpe;
% rhoi=vti/wci
% rhoe=vte/wce;

%%
coeff=npt/nx/sum(ni);
%%--------------------------calculate parameters--------------------------
vte=sqrt(2*temp./me);
vti=vte.*sqrt(tie/alpha);
va=c*abs(bx)./sqrt(ni*mi);
%%
di=di0*sqrt(ncs./ni);
de=di/sqrt(alpha);
wpe=c./de;
wce=wpe/fr.*abs(bx/bsym)./sqrt(ni/ncs);
wci=wce/alpha;
debye=vte./wpe;
rhoi=vti./wci;
rhoe=vte./wce;

%%
% output=['the electron inertial length is: ',...
%     num2str(de),', ',num2str(de)];
% disp(output);
% output=['the electron cyclotron radius is: ',...
%     num2str(rhoe),', ', num2str(rhoe)];
% disp(output);
% output=['the debey length is: ',num2str(debye),', ',...
%     num2str(debye)];
% disp(output);
% output=['the electron plasma frequency is: ',num2str(wpe)];
% disp(output);
% output=['the proton cyclotron frequency are: ',...
%     num2str(wci),', ',num2str(wci)];
% disp(output);
% output=['the Alfven speed are: ',num2str(va),', ',...
%        num2str(va)];
% disp(output);

%%----------------------------------------------
figure
% plot(z,bx,'r')
plot(z,ni,'k')
xlim([0 ny/2])
%%
figure
plot(z,rhoe,'k')
hold on
plot(z,de,'b')
plot(z,debye,'r')
xlim([0 ny/2])
ylim([0 10])

%%
figure
plot(z,wpe,'k')
hold on
plot(z,wce,'r')
xlim([0 ny/2])

figure
plot(z,c./va,'k')
xlim([0 ny/2])
ylim([0 100])







