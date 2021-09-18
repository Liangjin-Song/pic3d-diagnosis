clear all

%% calculate the total energy release in the entire system as a function of time

tt=41:100;
nx=2400;
ny=1200;
Lx=120;
Ly=60;
xmin=0;
xmax=120;
ymin=-29.9;
ymax=-0.1;
c=0.6;
%%
norm=857*0.03^2;   %normalized by n0*va*E0=n0*va*b0*va
dt=1;     %1/wci.
dV=(xmax-xmin)*(ymax-ymin);  %the volume, di^3
%%
dirr='I:\DF\';
cd(dirr)
%%
iy1=floor((ymin+Ly/2)/(Ly/ny))+1;
iy2=floor((ymax+Ly/2)/(Ly/ny));
ix1=floor(xmin/(Lx/nx))+1;
ix2=floor(xmax/(Lx/nx));
%%
nt=length(tt);
JiE=zeros(nt,1);
JeE=zeros(nt,1);
JtotE=zeros(nt,1);
JE1=zeros(nt,1);
for i=1:nt
it=num2str(tt(i),'%06.2f');
it=[it(1:3),'_',it(5:6)];
tmp=load(['Ex_t',it,'.mat']); tmp=struct2cell(tmp); ex=tmp{1};
tmp=load(['Ey_t',it,'.mat']); tmp=struct2cell(tmp); ey=tmp{1};
tmp=load(['Ez_t',it,'.mat']); tmp=struct2cell(tmp); ez=tmp{1};
tmp=load(['flwxi_t',it,'.mat']); tmp=struct2cell(tmp); flwxi=tmp{1};
tmp=load(['flwyi_t',it,'.mat']); tmp=struct2cell(tmp); flwyi=tmp{1};
tmp=load(['flwzi_t',it,'.mat']); tmp=struct2cell(tmp); flwzi=tmp{1};
tmp=load(['flwxe_t',it,'.mat']); tmp=struct2cell(tmp); flwxe=tmp{1};
tmp=load(['flwye_t',it,'.mat']); tmp=struct2cell(tmp); flwye=tmp{1};
tmp=load(['flwze_t',it,'.mat']); tmp=struct2cell(tmp); flwze=tmp{1};
tmp=load(['ohmx_t',it,'.mat']);  tmp=struct2cell(tmp); ohmx=tmp{1};
tmp=load(['ohmy_t',it,'.mat']);  tmp=struct2cell(tmp); ohmy=tmp{1};
tmp=load(['ohmz_t',it,'.mat']);  tmp=struct2cell(tmp); ohmz=tmp{1};
% tmp=load(['Ex_t',it,'.txt']);ex=tmp;
% tmp=load(['Ey_t',it,'.txt']); ey=tmp;
% tmp=load(['Ez_t',it,'.txt']);  ez=tmp;
% tmp=load(['flwxi_t',it,'.txt']);  flwxi=tmp;
% tmp=load(['flwyi_t',it,'.txt']);  flwyi=tmp;
% tmp=load(['flwzi_t',it,'.txt']);  flwzi=tmp;
% tmp=load(['flwxe_t',it,'.txt']);  flwxe=tmp;
% tmp=load(['flwye_t',it,'.txt']);  flwye=tmp;
% tmp=load(['flwze_t',it,'.txt']);  flwze=tmp;

%% re-arrange the data
efx=ohmx(:,1)-ohmx(:,2);  %E+ViXB
efy=ohmy(:,1)-ohmy(:,2);
efz=ohmz(:,1)-ohmz(:,2);
efx=reshape(efx,nx,ny);
efx=efx';
efy=reshape(efy,nx,ny);
efy=efy';
efz=reshape(efz,nx,ny);
efz=efz';
%% Ji dot E
var1=flwxi.*ex+flwyi.*ey+flwzi.*ez;
%% Je dot E
var2=-(flwxe.*ex+flwye.*ey+flwze.*ez);
%% Jtot dot E
var=var1+var2;
%% Jdot(E+ViXB)
var3=(flwxi-flwxe).*efx+(flwyi-flwye).*efy+(flwzi-flwze).*efz;
%%
JiE(i)=sum(sum(var1(iy1:iy2,ix1:ix2)))/norm*dt*dV;
JeE(i)=sum(sum(var2(iy1:iy2,ix1:ix2)))/norm*dt*dV;
JtotE(i)=sum(sum(var(iy1:iy2,ix1:ix2)))/norm*dt*dV;
JE1(i)=sum(sum(var3(iy1:iy2,ix1:ix2)))/norm*dt*dV;

clear ex ey ez flwxi flwyi flwzi flwxe flwye flwze ohmx ohmy ohmz
%%
end
%%
%% -----------------------make plot------------------------
%%  calculate global reconnection rate
norm1=40;
norm2=0.03*0.1/0.00075;
%%
load xpoint.dat
N=length(xpoint(:,1))-1;
tx=0:0.1:N*0.1;
flux=(xpoint(:,2)-xpoint(:,3))./norm1;
Er=diff(flux)/norm2*norm1;
%%
figure
[ax,h1,h2]=plotyy(tt,JtotE,tx(1:end-1),Er);
set(get(ax(1),'Ylabel'),'String','J\cdotE','color','k','fontsize',14)
set(get(ax(2),'Ylabel'),'String','Er/(V_{A}B_{0})','color','m','fontsize',14)
set(get(ax(2),'Ylabel'),'String','Er/(V_{A}B_{0})','color','m','fontsize',14)
set(get(ax(1),'Xlabel'),'String','t\omega_{ci}','color','k','fontsize',14)
set(ax(1),'Ycolor','k','fontsize',14,'xminortick','on','yminortick','on')
set(ax(2),'Ycolor','m','fontsize',14)
set(h1,'color','k','linewidth',1.)
set(h2,'color','m','linewidth',0.5)
hold(ax(1))
plot(ax(1),tt,JiE,'b','linewidth',1.);
plot(ax(1),tt,JeE,'r','linewidth',1.);
plot(ax(1),tt,JE1,'g','linewidth',1.);
xlim(ax(1),[0 105])
xlim(ax(2),[0 105])
% plot(ax(1),tt,JtotE(2:end),'b','linewidth',1.5);

