%% asymmetric reconnection with cold ions initialization, asym-slj2
% writen by Liangjin Song
clear;
%% parameters
% directory
dir='E:\';
% the range
y=-15:0.1:15;
% the current sheet position
y0=0;
% the half width of the current sheet
L=0.5;

% Br =|Bsheath∕Bsphere|, the magnetic field ratio between both sides of the current sheet
Br=1/2;

% Tr=Tsheath∕Tsphere the temperature ratio between both sides of the current sheet
Tr=1/3;

% density ratio between cold ions and the hot ions density at the magnetosphere side
phi=6;

% the distance between cold ions and the current sheet
s=1;

% temperature ratio between hot ions and cold ions at the magnetosphere side
theta2=100;

% the temperature ratio between electron and hot ion
theta1=1/5;

% the beta value at the magnetosheath
betas=5;


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
% figure
f1=figure;
plot(y,B,'-k','LineWidth',lw);
xlabel('Z');
ylabel('Bx');
set(gca,'FontSize',fs);


%% the temperature
% the hot ion temperature profile
Tih=tanh((y-y0)/L)+1;
Tih=Tih*(Tr-1)/2+1;
Tih=Tih/Tr;
% the electron temperature profile
Te=Tih*theta1;
% the cold ion temperature
Tish=1;
Tic=Tish/Tr;
Tic=Tic/theta2;
% figure
f2=figure;
plot(y,Tih,'-k','LineWidth',lw);
xlabel('Z');
ylabel('Tih');
set(gca,'FontSize',fs);

%% density
% total pressure
Bsh=-1;
P=(1+betas)*Bsh*Bsh/(2*mu0);
% cold ion density
Bsp=-Bsh/Br;
PBsp=Bsp*Bsp/(2*mu0);
Tisp=Tish/Tr;
Tesp=Tisp*theta1;
k=(P-PBsp)/(Tisp/phi + Tic + (1 + 1/phi)*Tesp);
Nic=0.5*k*(1-tanh((y-y0+s)/L));
% hot ion density
Pb=B.*B/(2*mu0);
Nih=(P - Pb - Nic.*Tic - Nic.*Te)./(Tih + Te);
N=Nih+Nic;
% figure
f3=figure;
plot(y,N,'-k','LineWidth',lw); hold on
plot(y,Nic,'-r','LineWidth',lw);
plot(y,Nih,'-b','LineWidth',lw); hold off
legend('Nic+Nih','Nic','Nih','Location','Best');
xlabel('Z');
ylabel('N');
set(gca,'FontSize',fs);

%% pressure
Pih=Tih.*Nih;
Pe=Te.*N;
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

% cd(dir);
% print(f1,'-r300','-dpng','B.png');



Bsh=abs(Bsh);
Bsp=abs(Bsp);

rho_sh=N(end);
rho_sp=N(1);

vA_asym=sqrt((Bsh*Bsp*(Bsh+Bsp))/(mu0*(rho_sh*Bsp+rho_sp*Bsh)));
disp(['v_{A,asym} = ', num2str(vA_asym)]);

disp(['Nsh/Nsp = ', num2str(N(end)/N(1))]);

disp(['Nih_sh/Nih_sp = ', num2str(Nih(end)/Nih(1))]);
