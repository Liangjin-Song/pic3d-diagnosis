%% asymmetric reconnection with cold ions initialization (slj_model)
% writen by Liangjin Song
clear;
%% parameters
% directory
dir='E:\Download';
% the range
y=-20:0.01:20;
% the current sheet position
y0=0;
% the half width of the current sheet
L=0.6;

% Br =|Bsheath∕Bsphere|, the magnetic field ratio between both sides of the current sheet
Br=1/3;
% nr=nsheath∕nsphere the density ratio between both sides of the current sheet
Nr=1.5;

% density ratio between cold ions and the total plasma density at the magnetosphere side
phi=0;

% the distance between cold ions and the current sheet
s=0;

% temperature ratio between hot ions and cold ions at the magnetosphere side
theta2=1;

% the temperature ratio between electron and hot ion
theta1=0.1;

% the beta value at the magnetosheat
betas=20;

% the light speed
c=0.5;
mu0=1/(c*c);

%% the figure properties
fs=15;
lw=2;

%% magnetic field profiles of asymmetric reconnection
B=atanh((Br-1)/(Br+1));
B=tanh((y-y0)/L+B);
B=-B*(Br+1)/2-(Br-1)/2;
B=B/Br;
f1=figure;
plot(y,B,'-k','LineWidth',lw);
xlabel('Z');
ylabel('Bx');
set(gca,'FontSize',fs);
cd(dir);
print(f1,'-r300','-dpng','B.png');

%% the density profiles
% the total plasma density profile
N=tanh((y-y0)/L)+1;
N=N*(Nr-1)/2+1;
N=N/Nr;
% the cold ions density profiles
Nic=0.5*phi*(1-tanh((y-y0+s)/L))/Nr;
% the hot ions density profiles
Nih=N-Nic;
% figure
f2=figure;
plot(y,N,'-k','LineWidth',lw); hold on
plot(y,Nic,'-r','LineWidth',lw);
plot(y,Nih,'-b','LineWidth',lw); hold off
legend('Nic+Nih','Nic','Nih','Location','Best');
xlabel('Z');
ylabel('N');
set(gca,'FontSize',fs);
cd(dir);
print(f2,'-r300','-dpng','N.png');

%% the cold ions temperature
Bsh=-1;
Bsp=abs(Bsh)/Br;
PBsh=Bsh*Bsh/(2*mu0);
PBsp=Bsp*Bsp/(2*mu0);
P=(1+betas)*PBsh;
Nsh=1;
Nsp=1/Nr;
Nicp=phi*Nsp;
Nisp=Nsp-Nicp;
Tic=(P-PBsp)/(Nisp*theta2+Nicp+Nsp*theta1*theta2);

%% the hot ions temperature profile
Pb=B.*B/(2*mu0);
Tih=(P-Pb-Nic*Tic)./(Nih+theta1*(Nic+Nih));
f3=figure;
plot(y,Tih,'-k','LineWidth',lw);
xlabel('Z');
ylabel('Tih');
set(gca,'FontSize',fs);
cd(dir);
print(f3,'-r300','-dpng','T.png');

%% the pressure
Pih=Tih.*Nih;
Pe=theta1*Tih.*(Nih+Nic);
Pic=Nic*Tic;
Pp=Pih+Pe+Pic+Pb;
f4=figure;
plot(y,Pp,'-k','LineWidth',lw); hold on
plot(y,Pb,'-r','LineWidth',lw);
plot(y,Pic,'-g','LineWidth',lw);
plot(y,Pih,'-b','LineWidth',lw);
plot(y,Pe,'-m','LineWidth',lw); hold off
legend('P_{tot}','Pb','Pic','Pih','Pe','Location','Best');
xlabel('Z');
ylabel('Pressure');
set(gca,'FontSize',fs);
cd(dir);
print(f4,'-r300','-dpng','P.png');