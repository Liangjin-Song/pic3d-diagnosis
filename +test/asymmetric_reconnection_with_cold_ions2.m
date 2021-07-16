%% asymmetric reconnection with cold ions initialization
% writen by Liangjin Song
clear;
%% parameters
% directory
dir='E:\Download';
% the range
y=-10:0.01:10;
% the current sheet position
y0=0;
% the half width of the current sheet
L=1;

% Br =|Bsheath∕Bsphere|, the magnetic field ratio between both sides of the current sheet
Br=0.5;
% nr=nsheath∕nsphere the density ratio between both sides of the current sheet
Nr=3;

% density ratio between hot ions and cold ions at the magnetosphere side
Nhoc=0.5;

% temperature ratio between hot ions and cold ions at the magnetosphere side
Thoc=500;

% the temperature ratio between electron and hot ion
theta=0.2;

% the beta value at the magnetosheat
betas=10;

% the light speed
c=0.5;
mu0=1/(c*c);

%% magnetic field profiles of asymmetric reconnection
B=atanh((Br-1)/(Br+1));
B=tanh((y-y0)/L+B);
B=-B*(Br+1)/2-(Br-1)/2;
B=B/Br;
h1=figure;
plot(y,B,'k','LineWidth',2);
xlabel('Z');
ylabel('Bx');
set(gca,'FontSize',14);
cd(dir);
print(h1,'-r300','-dpng','Bx.png');

%% plasma density of asymmetric reconnection
% the total plasma density profile
N=tanh((y-y0)/L)+1;
N=N*(Nr-1)/2+1;
N=N/Nr;
% the magnetosheath density profile
Nish=0.5*(1+tanh((y-y0)/L));
% the magnetosphere density profile
Nisp=N-Nish;
% the magnetosphere cold ions density profile
Nic=Nisp/(1+Nhoc);
% the magnetosphere cold ions density profile
Nih=Nic*Nhoc;
% figure
h2=figure;
plot(y,N,'k','LineWidth',2); hold on
plot(y,Nish,'r','LineWidth',2);
plot(y,Nic,'g','LineWidth',2);
plot(y,Nih,'b','LineWidth',2);
plot(y,Nih+Nic+Nish,'--k','LineWidth',2); hold off
legend('N','Nsh','Nic','Nih','Nsh+Nic+Nih','Location','Best');
xlabel('Z');
ylabel('N');
set(gca,'FontSize',14);
cd(dir);
print(h2,'-r300','-dpng','N.png');

%% the total pressure
Bsh=-1;
Bsp=abs(Bsh)/Br;
PBsh=Bsh*Bsh/(2*mu0);
PBsp=Bsp*Bsp/(2*mu0);
P=(1+betas)*PBsh;
Pb=B.*B/(2*mu0);
Pt=P-Pb;

%% magnetosheat plasma temperature
Tish=(Pt+PBsp-PBsh)./(2*(1+theta)*Nish);
Tesh=Tish*theta;

%% magnetosphere plasma temperature
Tic=(Pt+PBsh-PBsp)./(2*(Thoc*Nih+Nic+Thoc*theta*Nisp));
Tih=Tic*Thoc;
Tesp=Tih*theta;

%% plasma temperature
h3=figure;
plot(y, Tish, '-r','LineWidth',2); hold on
plot(y, Tic, '-g','LineWidth',2);
plot(y, Tih, '-b','LineWidth',2); hold off
xlim([y(1),y(end)]);
ylim([-1,10]);
legend('Tish', 'Tic', 'Tih','Location','Best');
xlabel('Z');
ylabel('T');
set(gca,'FontSize',14);
cd(dir);
print(h3,'-r300','-dpng','T.png');

%% pressure balance
Pish=Nish.*Tish;
Pesh=Nish.*Tesh;
Pih=Nih.*Tih;
Pic=Nic.*Tic;
Pesp=Nisp.*Tesp;
Pp=Pb+Pish+Pesh+Pih+Pic+Pesp;
% figure
h4=figure;
plot(y,Pp,'-k','LineWidth',2); hold on
plot(y,Pb,'--r','LineWidth',2);
plot(y,Pish,'-r','LineWidth',2);
plot(y,Pic,'-g','LineWidth',2);
plot(y,Pih,'-b','LineWidth',2);
plot(y,Pesp+Pesh,'-m','LineWidth',2); hold off
legend('P_{tot}','Pb','Pish','Pic','Pih','Pe','Location','Best');
xlabel('Z');
ylabel('Pressure');
set(gca,'FontSize',14);
cd(dir);
print(h4,'-r300','-dpng','P.png');