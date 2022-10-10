
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
pn=4; %% number of panels
%%
norm=0.6^2/2;   %B0^2/2mu0
% norm2=658;
% norm3=0.6;
% norm4=658*0.03;
xrange=[0 120];
yrange=[-30 0];
% cr=[-0.6 0.6];
%%
dirr='I:\DF\';
dirout='I:\DF\figures\';
cd(dirr)
%%
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
%% magnetic field energy
% Bt=0.5*(bx.^2+by.^2+bz.^2);  %total magentic energy B2/2mu0.
%% thermal energy of particles
ui=(pxxi+pyyi+pzzi)/2.;  %thermal energy of ions
ue=(pxxe+pyye+pzze)/2.;
%% kinetic energy
kti=0.5*imass.*ni.*(vxi.^2+vyi.^2+vzi.^2);
kte=0.5*emass.*ne.*(vxe.^2+vye.^2+vze.^2);

%%-----------------male field plot--------------------
gap=0.01;
height=(1-0.1)/pn-gap;

%% B energy
% h=subplot('position',[0.15,0.1+0.18*4,0.75,0.16]);
% plot_field(Bt,Lx,Ly,norm);
% cr=caxis;
% hold on
% plot_stream(ss,Lx,Ly,40);
% xlim(xrange)
% ylim(yrange)
% caxis(cr)
% % set(h,'fontsize',14,'ytick',[-24.5 -18.5 -12.5 -6.5 -0.5],'yticklabel',...
% %            [-12 -6 0 6 12],'Xminortick','on','Yminortick','on')
% set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
% xlabel('');
% set(h,'xticklabel',{''})
%% kti
h1=subplot('position',[0.15,0.1+(pn-1)*(height+gap),0.75,height]);
plot_field(kti,Lx,Ly,norm);
cr1=caxis;
cr1max=max(abs(cr1));
hold on
plot_stream(ss,Lx,Ly,30);
xlim(xrange)
ylim(yrange)
set(h1,'fontsize',14,'Xminortick','on','Yminortick','on','xticklabel',{''})
xlabel('');
text(2,-4,'Kti','fontsize',14,'color','w')
%% Ui
h2=subplot('position',[0.15,0.1+(height+gap)*(pn-2),0.75,height]);
plot_field(ui,Lx,Ly,norm);
cr2=caxis;
cr2max=max(abs(cr2));
hold on
plot_stream(ss,Lx,Ly,30);
xlim(xrange)
ylim(yrange)
cr=(cr1max+cr2max)/2;
caxis([0 cr])
caxis(h1,[0 cr])
set(h2,'fontsize',14,'Xminortick','on','Yminortick','on','xticklabel',{''})
xlabel('');
text(2,-4,'Ui','fontsize',14,'color','w')

%% Kte
h3=subplot('position',[0.15,0.1+(height+gap)*(pn-3),0.75,height]);
plot_field(kte,Lx,Ly,norm);
cr3=caxis;
cr3max=max(abs(cr3));
hold on
plot_stream(ss,Lx,Ly,30);
xlim(xrange)
ylim(yrange)
caxis([0 cr])
set(h3,'fontsize',14,'Xminortick','on','Yminortick','on','xticklabel',{''})
xlabel('');
text(2,-4,'Kte','fontsize',14,'color','w')
%% Ue
h4=subplot('position',[0.15,0.1,0.75,height]);
plot_field(ue,Lx,Ly,norm);
cr4=caxis;
cr4max=max(abs(cr4));
hold on
plot_stream(ss,Lx,Ly,30);
xlim(xrange)
ylim(yrange)
cr=(cr3max+cr4max)/2;
caxis([0 cr])
caxis(h3,[0 cr])
set(h4,'fontsize',14,'Xminortick','on','Yminortick','on')
text(2,-4,'Ue','fontsize',14,'color','w')
%%
print('-r300','-dpng',[dirout,'energy_partition_t',it,'.png']);
close(gcf)
end
