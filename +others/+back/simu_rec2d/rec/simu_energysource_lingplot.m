clear all

%% calculate the energy  partition from PIC simulation
%%
tt=44:44;
nx=2000;
ny=1000;
Lx=200;
Ly=100;
c=0.6;
%%
norm=833*0.04^2;   %normalized by n0*va*E0=n0*va*b0*va
xrange=[0 200];
yrange=[-50 0];
ymax=-20;
ymin=-30;
xx=0:Lx/nx:Lx-Lx/nx;
% cr=[-0.6 0.6];
%%
dirr='H:\island\island coalescence\mass=25\size_200_100\Bg=0.0\';
dirout='H:\island\island coalescence\mass=25\size_200_100\Bg=0.0\figures\energy study\';
cd(dirr)
%%
iy1=floor((ymin+Ly/2)/(Ly/ny))+1;
iy2=floor((ymax+Ly/2)/(Ly/ny));
%%
nt=length(tt);
for i=1:nt
it=num2str(tt(i),'%06.2f');
it=[it(1:3),'_',it(5:6)];
tmp=load(['Bz_t',it,'.mat']); tmp=struct2cell(tmp); bz=tmp{1};
tmp=load(['Ex_t',it,'.mat']); tmp=struct2cell(tmp); ex=tmp{1};
tmp=load(['Ey_t',it,'.mat']); tmp=struct2cell(tmp); ey=tmp{1};
tmp=load(['Ez_t',it,'.mat']); tmp=struct2cell(tmp); ez=tmp{1};
tmp=load(['flwxi_t',it,'.mat']); tmp=struct2cell(tmp); flwxi=tmp{1};
tmp=load(['flwyi_t',it,'.mat']); tmp=struct2cell(tmp); flwyi=tmp{1};
tmp=load(['flwzi_t',it,'.mat']); tmp=struct2cell(tmp); flwzi=tmp{1};
tmp=load(['flwxe_t',it,'.mat']); tmp=struct2cell(tmp); flwxe=tmp{1};
tmp=load(['flwye_t',it,'.mat']); tmp=struct2cell(tmp); flwye=tmp{1};
tmp=load(['flwze_t',it,'.mat']); tmp=struct2cell(tmp); flwze=tmp{1};
tmp=load(['stream_t',it,'.mat']); tmp=struct2cell(tmp); ss=tmp{1};

%% re-arrange the data
%% Ji dot E
JiE=flwxi.*ex+flwyi.*ey+flwzi.*ez;

%% Je dot E
JeE=-(flwxe.*ex+flwye.*ey+flwze.*ez);
%%
JtotE=JiE+JeE;
%%
JiE1=mean(JiE(iy1:iy2,:),1)/norm;
JeE1=mean(JeE(iy1:iy2,:),1)/norm;
JtotE1=mean(JtotE(iy1:iy2,:),1)/norm;
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
h=subplot('position',[0.15,0.57,0.75,0.4]);
plot_line(bz,Lx,Ly,-25,0.6,0,'k');
hold on
xlim(xrange)
plot([xrange(1) xrange(2)],[0 0],'k--');
set(gca,'fontsize',14,'xminortick','on','yminortick','on','xticklabel',{''})
xlabel('')
%% 
h=subplot('position',[0.15,0.1,0.75,0.4]);
plot(xx,JtotE1,'k','linewidth',1);
hold on
plot(xx,JiE1,'b','linewidth',1);
plot(xx,JeE1,'r','linewidth',1);
xlim(xrange)
set(gca,'fontsize',14,'xminortick','on','yminortick','on')
xlabel('X [c/\omega_{pi}]','fontsize',14)
ylabel('J\cdotE','fontsize',14)

%%
% print('-r300','-dpng',[dirout,'energysource_lineplot_dy10_t',it,'.png']);
% close(gcf)
%%
end


