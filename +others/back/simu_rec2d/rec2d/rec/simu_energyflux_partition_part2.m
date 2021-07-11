
clear

%% calculate the energy  partition from PIC simulation
%%
tt=30.5:0.5:60;
nx=1280;
ny=1280;
Lx=102.4;
Ly=102.4;
c=0.6;
imass=0.244494;
emass=imass/25;
%%
norm=1*0.04*0.6^2;
% norm2=658;
% norm3=0.6;
% norm4=658*0.03;
xrange=[0 102.4];
yrange=[10 41.2];
% cr=[-0.6 0.6];
%%
dirr='J:\island\island coalescence\mass=25\size_1024_1024\Bg=0.5energy\';
dirout='J:\island\island coalescence\mass=25\size_1024_1024\Bg=0.5energy\figures\';
cd(dirr)
%%
nt=length(tt);
for i=1:nt
it=num2str(tt(i),'%06.2f');
it=[it(1:3),'_',it(5:6)];
tmp=load(['vxi_t',it,'.mat']); tmp=struct2cell(tmp); vxi=tmp{1};
tmp=load(['vyi_t',it,'.mat']); tmp=struct2cell(tmp); vyi=tmp{1};
tmp=load(['vzi_t',it,'.mat']); tmp=struct2cell(tmp); vzi=tmp{1};
tmp=load(['vxe_t',it,'.mat']); tmp=struct2cell(tmp); vxe=tmp{1};
tmp=load(['vye_t',it,'.mat']); tmp=struct2cell(tmp); vye=tmp{1};
tmp=load(['vze_t',it,'.mat']); tmp=struct2cell(tmp); vze=tmp{1};
tmp=load(['presi_t',it,'.mat']); tmp=struct2cell(tmp); presi=tmp{1};
tmp=load(['prese_t',it,'.mat']); tmp=struct2cell(tmp); prese=tmp{1};
tmp=load(['qfluxi_t',it,'.mat']); tmp=struct2cell(tmp); qfluxi=tmp{1};
tmp=load(['qfluxe_t',it,'.mat']); tmp=struct2cell(tmp); qfluxe=tmp{1};
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
%%
%% enthalpy flux, H=(P.V+uV)
Hix=ui.*vxi+pxxi.*vxi+pxyi.*vyi+pxzi.*vzi;
Hiy=ui.*vyi+pxyi.*vxi+pyyi.*vyi+pyzi.*vzi;
Hiz=ui.*vzi+pxzi.*vxi+pyzi.*vyi+pzzi.*vzi;
Hex=ue.*vxe+pxxe.*vxe+pxye.*vye+pxze.*vze;
Hey=ue.*vye+pxye.*vxe+pyye.*vye+pyze.*vze;
Hez=ue.*vze+pxze.*vxe+pyze.*vye+pzze.*vze;
%%
%% heatflux
qix=qfluxi(:,1); qix=reshape(qix,nx,ny); qix=qix';
qiy=qfluxi(:,2); qiy=reshape(qiy,nx,ny); qiy=qiy';
qiz=qfluxi(:,3); qiz=reshape(qiz,nx,ny); qiz=qiz';
qex=qfluxe(:,1); qex=reshape(qex,nx,ny); qex=qex';
qey=qfluxe(:,2); qey=reshape(qey,nx,ny); qey=qey';
qez=qfluxe(:,3); qez=reshape(qez,nx,ny); qez=qez';

%%-----------------male field plot--------------------
%% -------------X component--------------
%% ion enthalpy flux
h=subplot('position',[0.15,0.08+0.23*3,0.75,0.2]);
plot_field(Hix,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,40);
xlim(xrange)
ylim(yrange)
caxis(cr)
% set(h,'fontsize',14,'ytick',[-24.5 -18.5 -12.5 -6.5 -0.5],'yticklabel',...
%            [-12 -6 0 6 12],'Xminortick','on','Yminortick','on')
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
xlabel('');
set(h,'xticklabel',{''})
%% electron enthalpy flux
h=subplot('position',[0.15,0.08+0.23*2,0.75,0.2]);
plot_field(Hex,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,40);
xlim(xrange)
ylim(yrange)
caxis(cr)
% set(h,'fontsize',14,'ytick',[-24.5 -18.5 -12.5 -6.5 -0.5],'yticklabel',...
%            [-12 -6 0 6 12],'Xminortick','on','Yminortick','on')
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
xlabel('');
set(h,'xticklabel',{''})
%% ion heat flux
h=subplot('position',[0.15,0.08+0.23*1,0.75,0.2]);
plot_field(qix,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,40);
xlim(xrange)
ylim(yrange)
caxis(cr)
% set(h,'fontsize',14,'ytick',[-24.5 -18.5 -12.5 -6.5 -0.5],'yticklabel',...
%            [-12 -6 0 6 12],'Xminortick','on','Yminortick','on')
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
xlabel('');
set(h,'xticklabel',{''})
%% electron heat flux
h=subplot('position',[0.15,0.08,0.75,0.2]);
plot_field(qex,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,40);
xlim(xrange)
ylim(yrange)
caxis(cr)
% set(h,'fontsize',14,'ytick',[-24.5 -18.5 -12.5 -6.5 -0.5],'yticklabel',...
%            [-12 -6 0 6 12],'Xminortick','on','Yminortick','on')
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')

print('-r300','-dpng',[dirout,'energyfluxX_part2_t',it,'.png']);
close(gcf)
%% -------------Y component--------------
%% ion enthalpy flux
h=subplot('position',[0.15,0.08+0.23*3,0.75,0.2]);
plot_field(Hiy,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,40);
xlim(xrange)
ylim(yrange)
caxis(cr)
% set(h,'fontsize',14,'ytick',[-24.5 -18.5 -12.5 -6.5 -0.5],'yticklabel',...
%            [-12 -6 0 6 12],'Xminortick','on','Yminortick','on')
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
xlabel('');
set(h,'xticklabel',{''})
%% electron enthalpy flux
h=subplot('position',[0.15,0.08+0.23*2,0.75,0.2]);
plot_field(Hey,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,40);
xlim(xrange)
ylim(yrange)
caxis(cr)
% set(h,'fontsize',14,'ytick',[-24.5 -18.5 -12.5 -6.5 -0.5],'yticklabel',...
%            [-12 -6 0 6 12],'Xminortick','on','Yminortick','on')
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
xlabel('');
set(h,'xticklabel',{''})
%% ion heat flux
h=subplot('position',[0.15,0.08+0.23*1,0.75,0.2]);
plot_field(qiy,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,40);
xlim(xrange)
ylim(yrange)
caxis(cr)
% set(h,'fontsize',14,'ytick',[-24.5 -18.5 -12.5 -6.5 -0.5],'yticklabel',...
%            [-12 -6 0 6 12],'Xminortick','on','Yminortick','on')
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
xlabel('');
set(h,'xticklabel',{''})
%% electron heat flux
h=subplot('position',[0.15,0.08,0.75,0.2]);
plot_field(qey,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,40);
xlim(xrange)
ylim(yrange)
caxis(cr)
% set(h,'fontsize',14,'ytick',[-24.5 -18.5 -12.5 -6.5 -0.5],'yticklabel',...
%            [-12 -6 0 6 12],'Xminortick','on','Yminortick','on')
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')

print('-r300','-dpng',[dirout,'energyfluxY_part2_t',it,'.png']);
close(gcf)
%% -------------Z component--------------
%% ion enthalpy flux
h=subplot('position',[0.15,0.08+0.23*3,0.75,0.2]);
plot_field(Hiz,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,40);
xlim(xrange)
ylim(yrange)
caxis(cr)
% set(h,'fontsize',14,'ytick',[-24.5 -18.5 -12.5 -6.5 -0.5],'yticklabel',...
%            [-12 -6 0 6 12],'Xminortick','on','Yminortick','on')
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
xlabel('');
set(h,'xticklabel',{''})
%% electron enthalpy flux
h=subplot('position',[0.15,0.08+0.23*2,0.75,0.2]);
plot_field(Hez,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,40);
xlim(xrange)
ylim(yrange)
caxis(cr)
% set(h,'fontsize',14,'ytick',[-24.5 -18.5 -12.5 -6.5 -0.5],'yticklabel',...
%            [-12 -6 0 6 12],'Xminortick','on','Yminortick','on')
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
xlabel('');
set(h,'xticklabel',{''})
%% ion heat flux
h=subplot('position',[0.15,0.08+0.23*1,0.75,0.2]);
plot_field(qiz,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,40);
xlim(xrange)
ylim(yrange)
caxis(cr)
% set(h,'fontsize',14,'ytick',[-24.5 -18.5 -12.5 -6.5 -0.5],'yticklabel',...
%            [-12 -6 0 6 12],'Xminortick','on','Yminortick','on')
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
xlabel('');
set(h,'xticklabel',{''})
%% electron heat flux
h=subplot('position',[0.15,0.08,0.75,0.2]);
plot_field(qez,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,40);
xlim(xrange)
ylim(yrange)
caxis(cr)
% set(h,'fontsize',14,'ytick',[-24.5 -18.5 -12.5 -6.5 -0.5],'yticklabel',...
%            [-12 -6 0 6 12],'Xminortick','on','Yminortick','on')
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')

print('-r300','-dpng',[dirout,'energyfluxZ_part2_t',it,'.png']);
close(gcf)
%%
end
