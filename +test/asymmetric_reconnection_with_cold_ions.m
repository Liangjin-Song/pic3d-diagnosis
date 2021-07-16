clear;
%% from Dargent et al., 2017
%% glabal parameters
dir='E:\PIC\Asym\Asym_without_cold\param';
% the range
y=-100:0.01:100;
% the current sheet position
y0=0;
% the half width of the current sheet
L=1;

% Br =|Bsheath∕Bsphere|, the magnetic field ratio between both sides of the current sheet
Br=0.5;
% nr=nsheath∕nsphere the density ratio between both sides of the current sheet
nr=3;

% The electron to ion temperature ratio is constant and chosen equal to 𝜃
theta=0.2;

% the magnetospheric ion temperature
Nhoc=0.5;
Thoc=1;

betas=10;
c=0.5;

%% magnetic field of asymmetric reconnection
B=atanh((Br-1)/(Br+1));
B=tanh((y-y0)/L+B);
B=-B*(Br+1)/2-(Br-1)/2;
B=B/Br;
h1=figure;
plot(y,B,'k','LineWidth',1);
xlabel('Z');
ylabel('Bx');
set(gca,'FontSize',14);
cd(dir);
print(h1,'-r300','-dpng','Bx.png');

%% plasma density of asymmetric reconnection
N=tanh((y-y0)/L)+1;
N=N*(nr-1)/2+1;
N=N/nr;
h2=figure;
plot(y,N,'k','LineWidth',1);
xlabel('Z');
ylabel('N');
set(gca,'FontSize',14);
cd(dir);
print(h2,'-r300','-dpng','N.png');

%% temperature of asymmetric reconnection
% the normalized pressure balance
% K=1/(Br*Br);
K=betas*c*c/2;
B=B*c;
% the ions temperature
Ti=(K-B.*B/2)./(N*(1+theta));
% the electron temperature
Te=Ti*theta;
% figure
h3=figure;
plot(y,Ti,'k','LineWidth',1); hold on
plot(y,Te,'b','LineWidth',1); hold off
legend('Ti','Te');
xlabel('Z');
ylabel('Temperature');
set(gca,'FontSize',14);
cd(dir);
print(h3,'-r300','-dpng','T.png');

%% plasma density of asymmetric reconnection with cold ions
% the magnetosheath ion density profile
Nish=0.5*(1+tanh((y-y0)/L));
% the magnetosheath ion temperature
Tish=(K-0.5*c*c)/(1+theta);
Tic=(nr/(1+theta))*(K-1/(2*Br*Br))*((1+Nhoc)/(Nhoc*Thoc+1));
Tih=Tic*Thoc;
% the magnetosheath ion density profile
Nic=(K-B.*B/2)/(1+theta)-Nish*Tish;
Nic=N-Nic/Tih-Nish;
Nic=Nic*Thoc/(1+Thoc);
Nih=N-Nish-Nic;
% figure
h4=figure;
plot(y,Nish,'r','LineWidth',1); hold on
plot(y,Nic,'m','LineWidth',1);
plot(y,Nih,'b','LineWidth',1);
plot(y,N,'k','LineWidth',1); hold off
legend('sheat','cold','hot','total');
xlabel('Z');
ylabel('N');
set(gca,'FontSize',14);
cd(dir);
print(h4,'-r300','-dpng','Nihc.png');