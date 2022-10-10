%%
clear

%% calculate the energy  partition from PIC simulation
%%
tt=42:100;
nx=2400;
ny=1200;
Lx=120;
Ly=60;
c=0.6;
imass=0.4667;
emass=imass/100;
%%
norm=0.6^2/2;   %B0^2/2mu0
xrange=[0 200];
yrange=[-50 50];
ymax=-12;
ymin=-18;
xx=0:Lx/nx:Lx-Lx/nx;
% cr=[-0.6 0.6];
%%
dirr='I:\PIC simulation\island\island coalescence\mass=25\size_200_100\Bg=0.0\';
dirout='I:\DF\figures\';
cd(dirr)
%%
iy1=floor((ymin+Ly/2)/(Ly/ny))+1;
iy2=floor((ymax+Ly/2)/(Ly/ny))+1;
nt=length(tt);
for i=1:nt
it=num2str(tt(i),'%06.2f');
it=[it(1:3),'_',it(5:6)];
% tmp=load(['Bx_t',it,'.mat']); tmp=struct2cell(tmp); bx=tmp{1};
% tmp=load(['By_t',it,'.mat']); tmp=struct2cell(tmp); by=tmp{1};
% tmp=load(['Bz_t',it,'.mat']); tmp=struct2cell(tmp); bz=tmp{1};
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
% tmp=load(['stream_t',it,'.mat']); tmp=struct2cell(tmp); ss=tmp{1};

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
% Bt=0.5*(bx.^2+by.^2+bz.^2);  %total magentic energy B2/2mu0.
%% thermal energy of particles
ui=(pxxi+pyyi+pzzi)/2.;  %thermal energy of ions
ue=(pxxe+pyye+pzze)/2.;
%% kinetic energy
kti=0.5*imass.*ni.*(vxi.^2+vyi.^2+vzi.^2);
kte=0.5*emass.*ne.*(vxe.^2+vye.^2+vze.^2);
%%
% ui1=sum(ui(iy1:iy2,:),1)./sum(ni(iy1:iy2,:),1)/norm;
% ue1=sum(ue(iy1:iy2,:),1)./sum(ne(iy1:iy2,:),1)/norm;
% kti1=sum(kti(iy1:iy2,:),1)./sum(ni(iy1:iy2,:),1)/norm;
% kte1=sum(kte(iy1:iy2,:),1)./sum(ne(iy1:iy2,:),1)/norm;
ui1=sum(ui(iy1:iy2,:),1)/norm;
ue1=sum(ue(iy1:iy2,:),1)/norm;
kti1=sum(kti(iy1:iy2,:),1)/norm;
kte1=sum(kte(iy1:iy2,:),1)/norm;
%%
rri=ui1./kti1;
rre=ue1./kte1;
%%
% wi=ui+kti;
% we=ue+kte;
% wi1=sum(wi(iy1:iy2,:),1);
% we1=sum(we(iy1:iy2,:),1);
% rr=wi1./we1;
%%-----------------make field plot--------------------
h=subplot('position',[0.15,0.68,0.75,0.27]);
plot_field(vxi,Lx,Ly,0.04);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,30);
caxis(cr);
xlim(xrange)
ylim(yrange)
colorbar('hide')
set(gca,'fontsize',14,'xminortick','on','yminortick','on','xticklabel',{''})
xlabel('')
text(2,-4,'vxi','fontsize',15,'color','w')
%%  ions 
% h=subplot('position',[0.15,0.4,0.75,0.27]);
% plot(xx,kti1,'k','linewidth',1);
% hold on
% plot(xx,ui1,'k--','linewidth',1);
% xlim(xrange)
% ylabel('Ions','fontsize',14)
% set(gca,'fontsize',14,'xminortick','on','yminortick','on','xticklabel',{''})
% xlabel('')

h=subplot('position',[0.15,0.4,0.75,0.27]);
plot(xx,rri,'k','linewidth',1);
hold on
% plot([xx(1),xx(end)],[1.333,1.333],'k--','linewidth',1);
xlim(xrange)
ylabel('Ui/Kti','fontsize',14)
set(gca,'fontsize',14,'xminortick','on','yminortick','on','xticklabel',{''})
%% electrons
% h=subplot('position',[0.15,0.1,0.75,0.27]);
% plot(xx,5*kte1,'r','linewidth',1);
% hold on
% plot(xx,ue1,'r--','linewidth',1);
% xlim(xrange)
% xlabel('X [c/\omega_{pi}]','fontsize',14)
% ylabel('Electrons','fontsize',14)
% set(gca,'fontsize',14,'xminortick','on','yminortick','on')

h=subplot('position',[0.15,0.1,0.75,0.27]);
plot(xx,rre,'r','linewidth',1);
hold on
% plot([xx(1),xx(end)],[68,68],'r--','linewidth',1);
xlim(xrange)
xlabel('X [c/\omega_{pi}]','fontsize',14)
ylabel('Ue/Kte','fontsize',14)
set(gca,'fontsize',14,'xminortick','on','yminortick','on')
%%

print('-r300','-dpng',[dirout,'energyratio_lineplot_dy6_t',it,'.png']);
close(gcf)

%% -------------------------------------------
% h=subplot('position',[0.15,0.53,0.75,0.43]);
% plot_field(vxi,Lx,Ly,0.04);
% cr=caxis;
% hold on
% plot_stream(ss,Lx,Ly,30);
% caxis(cr);
% xlim(xrange)
% ylim(yrange)
% colorbar('hide')
% set(gca,'fontsize',14,'xminortick','on','yminortick','on','xticklabel',{''})
% xlabel('')
% %% ratio between ion and electron energy
% h=subplot('position',[0.15,0.1,0.75,0.43]);
% plot(xx,rr,'k','linewidth',1);
% hold on
% plot([xx(1),xx(end)],[6.5,6.5],'k--','linewidth',0.5)
% xlim(xrange)
% ylabel('W_{i}/W_{e}','fontsize',14)
% set(gca,'fontsize',14,'xminortick','on','yminortick','on')
% 
% print('-r300','-dpng',[dirout,'energy_WiWe_lineplot_dy10_t',it,'.png']);
% close(gcf)
end
