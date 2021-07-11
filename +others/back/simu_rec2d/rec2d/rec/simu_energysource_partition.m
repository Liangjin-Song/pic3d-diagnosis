
clear all

%% calculate the energy  partition from PIC simulation
%%
tt=41:100;
nx=2400;
ny=1200;
Lx=120;
Ly=60;
c=0.6;
% imass=0.244494;
% emass=imass/25;
%%
norm=857*0.03^2;   %normalized by n0*va*E0=n0*va*b0*va
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
tmp=load(['ohmx_t',it,'.mat']); tmp=struct2cell(tmp); ohmx=tmp{1};
tmp=load(['ohmy_t',it,'.mat']); tmp=struct2cell(tmp); ohmy=tmp{1};
tmp=load(['ohmz_t',it,'.mat']); tmp=struct2cell(tmp); ohmz=tmp{1};

%% re-arrange the data
efx=ohmx(:,1)-ohmx(:,2);
efy=ohmy(:,1)-ohmy(:,2);
efz=ohmz(:,1)-ohmz(:,2);
efx=reshape(efx,nx,ny); efx=efx';
efy=reshape(efy,nx,ny); efy=efy';
efz=reshape(efz,nx,ny); efz=efz';
%% Ji dot E
JiE=flwxi.*ex+flwyi.*ey+flwzi.*ez;

%% Je dot E
JeE=-(flwxe.*ex+flwye.*ey+flwze.*ez);
%%
%% J dot E+ViXB
JE1=(flwxi-flwxe).*efx+(flwyi-flwye).*efy+(flwzi-flwze).*efz;
%% source term of thermal energy
% Sui=
% Sue=

%%-----------------male field plot--------------------
set (gcf,...
    'PaperUnits','inches','PaperPosition',[0. 0. 11 8],...
    'PaperOrientation','portrait','PaperType','usletter');
%% Jtot dot E
% h=subplot('position',[0.15,0.7,0.75,0.29]);
% plot_field(JiE+JeE,Lx,Ly,norm);
% cr=caxis;
% crmin=min(abs(cr));
% crmax=max(abs(cr));
% cc=0.5*(crmax+crmin);
% hold on
% plot_stream(ss,Lx,Ly,20);
% xlim(xrange)
% ylim(yrange)
% caxis([-cc cc])
% set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
% xlabel('');
% set(h,'xticklabel',{''})
% text(1,-4,'J_{tot}E','fontsize',16,'color','w')
% 
% %% Ji dot E
% h=subplot('position',[0.15,0.4,0.75,0.29]);
% plot_field(JiE,Lx,Ly,norm);
% cr=caxis;
% crmin=min(abs(cr));
% crmax=max(abs(cr));
% cc=0.5*(crmax+crmin);
% hold on
% plot_stream(ss,Lx,Ly,20);
% xlim(xrange)
% ylim(yrange)
% caxis([-cc cc])
% set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
% xlabel('');
% set(h,'xticklabel',{''})
% text(1,-4,'J_{i}E','fontsize',16,'color','w')
% 
% %% Je dot E
% h=subplot('position',[0.15,0.1,0.75,0.29]);
% plot_field(JeE,Lx,Ly,norm);
% cr=caxis;
% crmin=min(abs(cr));
% crmax=max(abs(cr));
% cc=0.5*(crmax+crmin);
% hold on
% plot_stream(ss,Lx,Ly,20);
% xlim(xrange)
% ylim(yrange)
% caxis([-cc cc])
% set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
% text(1,-4,'J_{e}E','fontsize',16,'color','w')
% 
% print('-r300','-dpng',[dirout,'energysource_t',it,'.png']);
% close(gcf)
% %% Ji dot E+ViXB
% h=subplot('position',[0.15,1-0.08-0.23*1,0.75,0.2]);
% plot_field(JiE1,Lx,Ly,norm);
% % color_range=caxis;
% hold on
% plot_stream(ss,Lx,Ly,60);
% axis(range)
% caxis(cr)
% % set(h,'fontsize',14,'ytick',[-24.5 -18.5 -12.5 -6.5 -0.5],'yticklabel',...
% %            [-12 -6 0 6 12],'Xminortick','on','Yminortick','on')
% set(h,'fontsize',14,'Xminortick','on','Yminortick','on')
% xlabel('');
% set(h,'xticklabel',{''})
%% J dot E+ViXB
% h=subplot('position',[0.15,1-0.08,0.75,0.2]);
plot_field(JE1,Lx,Ly,norm);
cr=caxis;
crmin=min(abs(cr));
crmax=max(abs(cr));
cc=0.5*(crmax+crmin);
hold on
plot_stream(ss,Lx,Ly,30);
xlim(xrange)
ylim(yrange)
caxis([-cc,cc])
% set(h,'fontsize',14,'ytick',[-24.5 -18.5 -12.5 -6.5 -0.5],'yticklabel',...
%            [-12 -6 0 6 12],'Xminortick','on','Yminortick','on')
set(gca,'fontsize',14,'Xminortick','on','Yminortick','on')
text(2,-4,'J\cdotE\prime','fontsize',16,'color','w')

print('-r300','-dpng',[dirout,'ohmdissp_t',it,'.png']);
close(gcf)

%%
end
