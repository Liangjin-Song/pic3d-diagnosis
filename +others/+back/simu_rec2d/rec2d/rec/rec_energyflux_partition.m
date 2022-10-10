%%
clear

%% calculate the energy flux partition from PIC simulation
%%
tt=80:80;
nx=2400;
ny=1200;
Lx=120;
Ly=60;
c=0.6;
imass=0.4667;
emass=imass/100;

%% plot options
pn=7; %the number of panels
left=0.2;
width=0.7;
gap=0.02;
height=(1-0.1)/pn-gap;
text_pos=[2,-3];

%%
norm=1*0.03*0.6^2;  %(EXB)/mu0
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
tmp=load(['Densi_t',it,'.mat']); tmp=struct2cell(tmp); ni=tmp{1};
tmp=load(['Dense_t',it,'.mat']); tmp=struct2cell(tmp); ne=tmp{1};
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

%% poynting flux, S=(EXB)/mu0
Sx=(ey.*bz-ez.*by)*c;
Sy=(ez.*bx-ex.*bz)*c;
Sz=(ex.*by-ey.*bx)*c;

%% kinetic energy
kti=0.5*imass*ni.*(vxi.^2+vyi.^2+vzi.^2);
kte=0.5*emass*ne.*(vxe.^2+vye.^2+vze.^2);
%% kinetic energy flux, K=mnv2V/2
Kix=kti.*vxi;
Kiy=kti.*vyi;
Kiz=kti.*vzi;
Kex=kte.*vxe;
Key=kte.*vye;
Kez=kte.*vze;

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
%%-------------------X component-------------------------------
set (gcf,...
    'PaperUnits','inches','PaperPosition',[0. 0. 10 12],...
    'PaperOrientation','portrait','PaperType','usletter');

%% poynting flux
h=subplot('position',[left,0.1+(pn-1)*(height+gap),width,height]);
plot_field(Sx,Lx,Ly,norm);
cr=caxis;
crmin=min(abs(cr));
crmax=max(abs(cr));
cr0=(crmin+crmax)/2;
hold on
plot_stream(ss,Lx,Ly,30);
xlim(xrange)
ylim(yrange)
caxis([-cr0 cr0])
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
xlabel('');
set(h,'xticklabel',{''})
text(text_pos(1),text_pos(2),'Sx','fontsize',12)
%% ion kinetic energy flux
h=subplot('position',[left,0.1+(pn-2)*(height+gap),width,height]);
plot_field(Kix,Lx,Ly,norm);
cr=caxis;
crmin=min(abs(cr));
crmax=max(abs(cr));
cr0=(crmin+crmax)/2;
hold on
plot_stream(ss,Lx,Ly,30);
xlim(xrange)
ylim(yrange)
caxis([-cr0 cr0])
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
xlabel('');
set(h,'xticklabel',{''})
text(text_pos(1),text_pos(2),'Kix','fontsize',12)
%% electron kinetic energy flux
h=subplot('position',[left,0.1+(pn-3)*(height+gap),width,height]);
plot_field(Kex,Lx,Ly,norm);
cr=caxis;
crmin=min(abs(cr));
crmax=max(abs(cr));
cr0=(crmin+crmax)/2;
hold on
plot_stream(ss,Lx,Ly,30);
xlim(xrange)
ylim(yrange)
caxis([-cr0 cr0])
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
xlabel('');
set(h,'xticklabel',{''})
text(text_pos(1),text_pos(2),'Kex','fontsize',12)
%% ion enthalpy flux
h=subplot('position',[left,0.1+(pn-4)*(height+gap),width,height]);
plot_field(Hix,Lx,Ly,norm);
cr=caxis;
crmin=min(abs(cr));
crmax=max(abs(cr));
cr0=(crmin+crmax)/2;
hold on
plot_stream(ss,Lx,Ly,30);
xlim(xrange)
ylim(yrange)
caxis([-cr0 cr0])
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
xlabel('');
set(h,'xticklabel',{''})
text(text_pos(1),text_pos(2),'Hix','fontsize',12)
%% electron enthalpy flux
h=subplot('position',[left,0.1+(pn-5)*(height+gap),width,height]);
plot_field(Hex,Lx,Ly,norm);
cr=caxis;
crmin=min(abs(cr));
crmax=max(abs(cr));
cr0=(crmin+crmax)/2;
hold on
plot_stream(ss,Lx,Ly,30);
xlim(xrange)
ylim(yrange)
caxis([-cr0 cr0])
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
xlabel('');
set(h,'xticklabel',{''})
text(text_pos(1),text_pos(2),'Hex','fontsize',12)
%% ion heat flux
h=subplot('position',[left,0.1+(pn-6)*(height+gap),width,height]);
plot_field(qix,Lx,Ly,norm);
cr=caxis;
crmin=min(abs(cr));
crmax=max(abs(cr));
cr0=(crmin+crmax)/2;
hold on
plot_stream(ss,Lx,Ly,30);
xlim(xrange)
ylim(yrange)
caxis([-cr0 cr0])
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
xlabel('');
set(h,'xticklabel',{''})
text(text_pos(1),text_pos(2),'Qix','fontsize',12)
%% electron heat flux
h=subplot('position',[left,0.1+(pn-7)*(height+gap),width,height]);
plot_field(qex,Lx,Ly,norm);
cr=caxis;
crmin=min(abs(cr));
crmax=max(abs(cr));
cr0=(crmin+crmax)/2;
hold on
plot_stream(ss,Lx,Ly,30);
xlim(xrange)
ylim(yrange)
caxis([-cr0 cr0])
set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
text(text_pos(1),text_pos(2),'Qex','fontsize',12)
%%
print('-r300','-dpng',[dirout,'energyfluxX_t',it,'.png']);
close(gcf)



end
