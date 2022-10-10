clear all

%% calculate the variation of different type of energy in the entire system as a function of time

tt=20:100;
nx=2000;
ny=1000;
Lx=200;
Ly=100;
xmin=0;
xmax=200;
ymin=-40;
ymax=-10;
c=0.6;
imass=0.245457;
emass=imass/25;
%%
norm=0.6^2/2;   %normalized by B0^2/2mu0
%%
dirr='H:\island\island coalescence\mass=25\size_200_100\Bg=0.0\';
cd(dirr)
%%
iy1=floor((ymin+Ly/2)/(Ly/ny))+1;
iy2=floor((ymax+Ly/2)/(Ly/ny));
ix1=floor(xmin/(Lx/nx))+1;
ix2=floor(xmax/(Lx/nx));
%%
nt=length(tt);
Wbf=zeros(nt,1);
Wef=zeros(nt,1);
Wik=zeros(nt,1);
Wiu=zeros(nt,1);
Wek=zeros(nt,1);
Weu=zeros(nt,1);
for i=1:nt
it=num2str(tt(i),'%06.2f');
it=[it(1:3),'_',it(5:6)];
tmp=load(['Ex_t',it,'.mat']); tmp=struct2cell(tmp); ex=tmp{1};
tmp=load(['Ey_t',it,'.mat']); tmp=struct2cell(tmp); ey=tmp{1};
tmp=load(['Ez_t',it,'.mat']); tmp=struct2cell(tmp); ez=tmp{1};
tmp=load(['Bx_t',it,'.mat']); tmp=struct2cell(tmp); bx=tmp{1};
tmp=load(['By_t',it,'.mat']); tmp=struct2cell(tmp); by=tmp{1};
tmp=load(['Bz_t',it,'.mat']); tmp=struct2cell(tmp); bz=tmp{1};
tmp=load(['vxi_t',it,'.mat']); tmp=struct2cell(tmp); vxi=tmp{1};
tmp=load(['vyi_t',it,'.mat']); tmp=struct2cell(tmp); vyi=tmp{1};
tmp=load(['vzi_t',it,'.mat']); tmp=struct2cell(tmp); vzi=tmp{1};
tmp=load(['vxe_t',it,'.mat']); tmp=struct2cell(tmp); vxe=tmp{1};
tmp=load(['vye_t',it,'.mat']); tmp=struct2cell(tmp); vye=tmp{1};
tmp=load(['vze_t',it,'.mat']); tmp=struct2cell(tmp); vze=tmp{1};
tmp=load(['presi_t',it,'.mat']); tmp=struct2cell(tmp); presi=tmp{1};
tmp=load(['prese_t',it,'.mat']); tmp=struct2cell(tmp); prese=tmp{1};
tmp=load(['Densi_t',it,'.mat']); tmp=struct2cell(tmp); ni=tmp{1};
tmp=load(['Dense_t',it,'.mat']); tmp=struct2cell(tmp); ne=tmp{1};

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
%% magnetic field energy
Bt=0.5*(bx.^2+by.^2+bz.^2);  %total magentic energy B2/2mu0.
%% electric field energy
Et=(ex.^2+ey.^2+ez.^2);   %
%% thermal energy of particles
ui=(pxxi+pyyi+pzzi)/2.;  %thermal energy of ions
ue=(pxxe+pyye+pzze)/2.;
%% kinetic energy
kti=0.5*imass.*ni.*(vxi.^2+vyi.^2+vzi.^2);
kte=0.5*emass.*ne.*(vxe.^2+vye.^2+vze.^2);
%%
Wbf(i)=sum(sum(Bt(iy1:iy2,ix1:ix2)))/norm;
Wef(i)=sum(sum(Et(iy1:iy2,ix1:ix2)))/norm;
Wik(i)=sum(sum(kti(iy1:iy2,ix1:ix2)))/norm;
Wiu(i)=sum(sum(ui(iy1:iy2,ix1:ix2)))/norm;
Wek(i)=sum(sum(kte(iy1:iy2,ix1:ix2)))/norm;
Weu(i)=sum(sum(ue(iy1:iy2,ix1:ix2)))/norm;


clear bx by bz ex ey ez vx* vy* vz* pres* ni ne
%%
end
%%
%% -----------------------make plot------------------------
%%  calculate global reconnection rate
norm1=0.6*20;
norm2=0.6*0.04*0.1/0.002;
%%
load xpoint.dat
N=length(xpoint(:,1))-1;
tx=0:0.1:N*0.1;
flux=(xpoint(:,2)-xpoint(:,3))./norm1;
Er=diff(flux)/norm2*norm1;
%%
figure
[ax,h1,h2]=plotyy(tt,Wbf,tx(1:end-1),Er);
set(get(ax(1),'Ylabel'),'String','energy','color','k','fontsize',14)
set(get(ax(2),'Ylabel'),'String','Er/(V_{A}B_{0})','color','m','fontsize',14)
set(ax(1),'Ycolor','k','fontsize',14,'xminortick','on','yminortick','on')
set(ax(2),'Ycolor','m','fontsize',14)
set(h1,'color','k','linewidth',1.)
set(h2,'color','m','linewidth',0.5)
hold(ax(1))
plot(ax(1),tt,Wef,'g','linewidth',1.);
plot(ax(1),tt,Wik,'b','linewidth',1.);
plot(ax(1),tt,Wiu,'b--','linewidth',1.);
plot(ax(1),tt,Wek,'r','linewidth',1.);
plot(ax(1),tt,Weu,'r--','linewidth',1.);

