clear all

%% calculate the J.E terms from PIC simulation
%%
tt=88:88;
nx=2400;
ny=1200;
Lx=120;
Ly=60;
c=0.6;
qe=0.00035;
%%
norm=qe*857*0.03^2;   %normalized by n0*va*E0=n0*va*b0*va
xrange=[0 120];
yrange=[-30 0];
ymax=-14.5;
ymin=-15.5;
xx=0:Lx/nx:Lx-Lx/nx;
% cr=[-0.6 0.6];
%%
dirr='I:\DF\';
dirout='I:\DF\figures\';
cd(dirr)
%%
iy1=floor((ymin+Ly/2)/(Ly/ny))+1;
iy2=floor((ymax+Ly/2)/(Ly/ny));
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
% tmp=load(['vxi_t',it,'.mat']); tmp=struct2cell(tmp); vxi=tmp{1};
% tmp=load(['vyi_t',it,'.mat']); tmp=struct2cell(tmp); vyi=tmp{1};
% tmp=load(['vzi_t',it,'.mat']); tmp=struct2cell(tmp); vzi=tmp{1};
tmp=load(['vxe_t',it,'.mat']); tmp=struct2cell(tmp); vxe=tmp{1};
tmp=load(['vye_t',it,'.mat']); tmp=struct2cell(tmp); vye=tmp{1};
tmp=load(['vze_t',it,'.mat']); tmp=struct2cell(tmp); vze=tmp{1};
tmp=load(['ohmx_t',it,'.mat']); tmp=struct2cell(tmp); ohmx=tmp{1};
tmp=load(['ohmy_t',it,'.mat']); tmp=struct2cell(tmp); ohmy=tmp{1};
tmp=load(['ohmz_t',it,'.mat']); tmp=struct2cell(tmp); ohmz=tmp{1};
tmp=load(['Densi_t',it,'.mat']); tmp=struct2cell(tmp); ni=tmp{1};
tmp=load(['Dense_t',it,'.mat']); tmp=struct2cell(tmp); ne=tmp{1};

%% re-arrange the data
% efxi=ohmx(:,1)-ohmx(:,2);
% efxi=reshape(efxi,nx,ny);
% efxi=efxi';
% efyi=ohmy(:,1)-ohmy(:,2);
% efyi=reshape(efyi,nx,ny);
% efyi=efyi';
% efzi=ohmz(:,1)-ohmz(:,2);
% efzi=reshape(efzi,nx,ny);
% efzi=efzi';
%%
efxe=ohmx(:,1)-ohmx(:,3);
efxe=reshape(efxe,nx,ny);
efxe=efxe';
efye=ohmy(:,1)-ohmy(:,3);
efye=reshape(efye,nx,ny);
efye=efye';
efze=ohmz(:,1)-ohmz(:,3);
efze=reshape(efze,nx,ny);
efze=efze';
%% calculation
[jx,jy,jz]=simu_curlB(bx,by,bz,2,0.6);
rho=qe*(ni-ne);
%%
JtotE=jx.*ex+jy.*ey+jz.*ez;
JeE=-qe*ne.*(vxe.*ex+vye.*ey+vze.*ez);
JiE=JtotE-JeE;
%%
gamma=1./sqrt(1-(vxe.^2+vye.^2+vze.^2)/0.6^2);
Dex=jx.*efxe-rho.*vxe.*ex;
Dey=jy.*efye-rho.*vye.*ey;
Dez=jz.*efze-rho.*vze.*ez;
De=Dex+Dey+Dez;
De=gamma.*De;
% gamma=1./sqrt(1-(vxi.^2+vyi.^2+vzi.^2)/0.6^2);
% Di=jx.*efxi+jy.*efyi+jz.*efzi-rho.*(vxi.*ex+vyi.*ey+vzi.*ez);
% Di=gamma.*Di;
%%
% Di1=sum(Di(iy1:iy2,:),1)/norm;
JtotE1=sum(JtotE(iy1:iy2,:),1)/norm;
JiE1=sum(JiE(iy1:iy2,:),1)/norm;
JeE1=sum(JeE(iy1:iy2,:),1)/norm;
De1=sum(De(iy1:iy2,:),1)/norm;
Dex1=sum(Dex(iy1:iy2,:),1)/norm;
Dey1=sum(Dey(iy1:iy2,:),1)/norm;
Dez1=sum(Dez(iy1:iy2,:),1)/norm;
%%-----------------male field plot--------------------
% h=subplot('position',[0.15,0.55,0.75,0.4]);
% plot_field(flwyi-flwye,Lx,Ly,833*0.04);
% cr=caxis;
% crmin=min(abs(cr));
% hold on
% plot_stream(ss,Lx,Ly,30);
% caxis([-crmin crmin]);
% xlim(xrange)
% ylim(yrange)
% colorbar('hide')
% set(gca,'fontsize',14,'xminortick','on','yminortick','on','xticklabel',{''})
% xlabel('')
h=subplot('position',[0.2,0.7,0.7,0.28]);
plot_line(bz,Lx,Ly,-15,0.6,0,'k');
hold on
xlim(xrange)
plot([xrange(1) xrange(2)],[0 0],'k--');
set(gca,'fontsize',14,'xminortick','on','yminortick','on','xticklabel',{''})
xlabel('')
%%
%% J.E and Je.E
h=subplot('position',[0.2,0.4,0.7,0.28]);
plot(xx,JtotE1,'k','linewidth',1.);
hold on
plot(xx,JiE1,'b','linewidth',1);
plot(xx,JeE1,'r','linewidth',1);
xlim(xrange)
plot([xrange(1) xrange(2)],[0 0],'k--');
set(gca,'fontsize',14,'xminortick','on','yminortick','on','xticklabel',{''})
xlabel('')
ylabel('J\cdotE','fontsize',14)
%% 
%% De
h=subplot('position',[0.2,0.1,0.7,0.28]);
plot(xx,De1,'k--','linewidth',1);
hold on
plot(xx,Dex1,'b','linewidth',1);
plot(xx,Dey1,'r','linewidth',1);
plot(xx,Dez1,'g','linewidth',1);
xlim(xrange)
plot([xrange(1) xrange(2)],[0 0],'k--');
set(gca,'fontsize',14,'xminortick','on','yminortick','on')
xlabel('X [c/\omega_{pi}]','fontsize',14)
ylabel('De','fontsize',14)

%%
% print('-r300','-dpng',[dirout,'energysource_line_dy1_t',it,'.png']);
% close(gcf)
%%
end


