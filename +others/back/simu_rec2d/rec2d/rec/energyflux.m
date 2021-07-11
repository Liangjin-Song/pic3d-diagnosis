%%
clear

%% calculate the energy flux and energy partition from PIC simulation
%%
tt=56;
nx=2048;
ny=1024;
Lx=102.4;
Ly=51.2;
c=0.6;
imass=0.632097;
emass=imass/100;
%%
norm=1;
% norm2=658;
% norm3=0.6;
% norm4=658*0.03;
xrange=[0 102.4];
yrange=[-25.6 0];
% cr=[-0.6 0.6];
%%
it=num2str(tt,'%06.2f');
it=[it(1:3),'_',it(5:6)];
% bx=load(['Bx_t',it,'.txt']);
% by=load(['By_t',it,'.txt']);
% bz=load(['Bz_t',it,'.txt']);
% ex=load(['Ex_t',it,'.txt']);
% ey=load(['Ey_t',it,'.txt']);
% ez=load(['Ez_t',it,'.txt']);
% vxi=load(['vxi_t',it,'.txt']);
% vyi=load(['vyi_t',it,'.txt']);
% vzi=load(['vzi_t',it,'.txt']);
% vxe=load(['vxe_t',it,'.txt']);
% vye=load(['vye_t',it,'.txt']);
% vze=load(['vze_t',it,'.txt']);
% presi=load(['presi_t',it,'.txt']);
% prese=load(['prese_t',it,'.txt']);
% qfluxi=load(['qfluxi_t',it,'.txt']);
% qfluxe=load(['qfluxe_t',it,'.txt']);
% ni=load(['Densi_t',it,'.txt']);
% ne=load(['Dense_t',it,'.txt']);
% ss=load(['stream_t',it,'.txt']);
tmp=load(['Bx_t',it,'.mat']); tmp=struct2cell(tmp); bx=tmp{1};
tmp=load(['By_t',it,'.mat']); tmp=struct2cell(tmp); by=tmp{1};
tmp=load(['Bz_t',it,'.mat']); tmp=struct2cell(tmp); bz=tmp{1};
tmp=load(['Ex_t',it,'.mat']); tmp=struct2cell(tmp); ex=tmp{1};
tmp=load(['Ey_t',it,'.mat']); tmp=struct2cell(tmp); ey=tmp{1};
tmp=load(['Ez_t',it,'.mat']); tmp=struct2cell(tmp); ez=tmp{1};
tmp=load(['vxi_t',it,'.mat']); tmp=struct2cell(tmp); vxi=tmp{1};
tmp=load(['vyi_t',it,'.mat']); tmp=struct2cell(tmp); vyi=tmp{1};
tmp=load(['vzi_t',it,'.mat']); tmp=struct2cell(tmp); vzi=tmp{1};
tmp=load(['vxe_t',it,'.mat']); tmp=struct2cell(tmp); vxe=tmp{1};
tmp=load(['vye_t',it,'.mat']); tmp=struct2cell(tmp); vye=tmp{1};
tmp=load(['vze_t',it,'.mat']); tmp=struct2cell(tmp); vze=tmp{1};
tmp=load(['presi_t',it,'.mat']); tmp=struct2cell(tmp); presi=tmp{1};
tmp=load(['prese_t',it,'.mat']); tmp=struct2cell(tmp); prese=tmp{1};
% tmp=load(['qfluxi_t',it,'.mat']); tmp=struct2cell(tmp); qfluxi=tmp{1};
% tmp=load(['qfluxe_t',it,'.mat']); tmp=struct2cell(tmp); qfluxe=tmp{1};
tmp=load(['Densi_t',it,'.mat']); tmp=struct2cell(tmp); ni=tmp{1};
tmp=load(['Dense_t',it,'.mat']); tmp=struct2cell(tmp); ne=tmp{1};
tmp=load(['stream_t',it,'.mat']); tmp=struct2cell(tmp); ss=tmp{1};

%% re-arrange data
pxxi=presi(:,1);  pxxi=reshape(pxxi,nx,ny); pxxi=pxxi';
pxyi=presi(:,2);  pxyi=reshape(pxyi,nx,ny); pxyi=pxyi';
pxzi=presi(:,3);  pxzi=reshape(pxzi,nx,ny); pxzi=pxzi';
pyyi=presi(:,4);  pyyi=reshape(pyyi,nx,ny); pyyi=pyyi';
pyzi=presi(:,5);  pyzi=reshape(pyzi,nx,ny); pyzi=pyzi';
pzzi=presi(:,6);  pzzi=reshape(pzzi,nx,ny); pzzi=pzzi';
pxxe=prese(:,1);  pxxe=reshape(pxxe,nx,ny); pxxe=pxxe';
pxye=prese(:,2);  pxye=reshape(pxye,nx,ny); pxye=pxye';
pxze=prese(:,3);  pxze=reshape(pxze,nx,ny); pxze=pxze';
pyye=prese(:,4);  pyye=reshape(pyye,nx,ny); pyye=pyye';
pyze=prese(:,5);  pyze=reshape(pyze,nx,ny); pyze=pyze';
pzze=prese(:,6);  pzze=reshape(pzze,nx,ny); pzze=pzze';
%%
%% thermal energy of particles
ui=(pxxi+pyyi+pzzi)/2;  %thermal energy of ions
ue=(pxxe+pyye+pzze)/2;
%% kinetic energy
kit=0.5*imass*ni.*(vxi.^2+vyi.^2+vzi.^2);
ket=0.5*emass*ne.*(vxe.^2+vye.^2+vze.^2);

%% poynting flux, S=(EXB)/mu0
Sx=(ey.*bz-ez.*by)*c;
Sy=(ez.*bx-ex.*bz)*c;
Sz=(ex.*by-ey.*bx)*c;
%%
%% kinetic energy flux, K=mnv2V/2
Kxi=kit.*vxi;
Kyi=kit.*vyi;
Kzi=kit.*vzi;
Kxe=ket.*vxe;
Kye=ket.*vye;
Kze=ket.*vze;
%%
%% enthalpy flux, H=(P.V+uV)
Hxi=ui.*vxi+pxxi.*vxi+pxyi.*vyi+pxzi.*vzi;
Hyi=ui.*vyi+pxyi.*vxi+pyyi.*vyi+pyzi.*vzi;
Hzi=ui.*vzi+pxzi.*vxi+pyzi.*vyi+pzzi.*vzi;
Hxe=ue.*vxe+pxxe.*vxe+pxye.*vye+pxze.*vze;
Hye=ue.*vye+pxye.*vxe+pyye.*vye+pyze.*vze;
Hze=ue.*vze+pxze.*vxe+pyze.*vye+pzze.*vze;
%%
% %% heatflux
% qxi=qfluxi(:,1); qxi=reshape(qxi,nx,ny); qxi=qxi';
% qyi=qfluxi(:,2); qyi=reshape(qyi,nx,ny); qyi=qyi';
% qzi=qfluxi(:,3); qzi=reshape(qzi,nx,ny); qzi=qzi';
% qxe=qfluxe(:,1); qxe=reshape(qxe,nx,ny); qxe=qxe';
% qye=qfluxe(:,2); qye=reshape(qye,nx,ny); qye=qye';
% qze=qfluxe(:,3); qze=reshape(qze,nx,ny); qze=qze';

%%-----------------male field plot--------------------
figure
h1=subplot(3,1,1);
plot_field(Sx,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,60);
xlim(xrange)
ylim(yrange)
caxis(cr)
%%
h2=subplot(3,1,2);
plot_field(ue,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,60);
xlim(xrange)
ylim(yrange)
caxis(cr)
%%
h3=subplot(3,1,3);
plot_field(ket,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,60);
xlim(xrange)
ylim(yrange)
caxis(cr)
