%%to plot the Reconnection simulation results
clear all

Lx=96;
Ly=64;
nx=2400;
ny=1600;
Va=0.04;
n0=571;
b0=1.;
di=25;
norm=Va*b0;
%%
tt=56:2:62;  % time points
% xcut=[21,22,23,24,25,26,27,48,49,50,51,1];  %cut lines
xupper_cut=25:32;
xlower_cut=26:34;
zupper_cut=12.5;
zlower_cut=-12.5;
outdir='F:\Space Physics\Simu\island coalesence\figures\';
%%=====================the loop===========================
nt=length(tt);
nl1=length(zupper_cut);
nl2=length(zlower_cut);
%%
for i=1:nt
it=num2str(tt(i),'%3.3d');
%%--------------------load data-------------------------- 
% bx=load(['Bx_t',it,'.00.txt']);
 by=load(['By_t',it,'.00.txt']);
%  bz=load(['Bz_t',it,'.00.txt']);
%  ex=load(['Ex_t',it,'.00.txt']);
%  ey=load(['Ey_t',it,'.00.txt']);
%  ez=load(['Ez_t',it,'.00.txt']);
%  vxe=load(['vxe_t',it,'.00.txt']);
%  vye=load(['vye_t',it,'.00.txt']);
%  vze=load(['vze_t',it,'.00.txt']);
%  ne=load(['Dense_t',it,'.00.txt']);
% flwxe=load(['flwxe_t',it,'.00.txt']);
%  flwye=load(['flwye_t',it,'.00.txt']);
% flwze=load(['flwze_t',it,'.00.txt']);
% flwxi=load(['flwxi_t',it,'.00.txt']);
% flwyi=load(['flwyi_t',it,'.00.txt']);
% flwzi=load(['flwzi_t',it,'.00.txt']);
%   ohm=load(['ohmz_t',it,'.00.txt']);
% eleaven=load(['eleaven_t',it,'.00.txt']);
ss=load(['stream_t',it,'.00.txt']);
%%======================calculation========================
%  bx=simu_filter2d(bx);
%  by=simu_filter2d(by);
% %  bz=simu_filter2d(bz);
%  ne=simu_filter2d(ne);
%  ve_para=plot_Epara(bx,by,bz,vxe,vye,vze,Lx,Ly,Va);
%  ve_para=simu_filter2d(ve_para);
%%
% flwe_para=plot_Epara(bx,by,bz,flwxe,flwye,flwze,Lx,Ly,Va*n0);
% flwi_para=plot_Epara(bx,by,bz,flwxi,flwyi,flwzi,Lx,Ly,Va*n0);
% jc_para=flwi_para-flwe_para;
% jc_para=simu_filter2d(jc_para);

%%----------output figure of By or density distribution----------------------
plot_field(by,Lx,Ly,b0);
color_range=caxis;
hold on
plot_stream(ss,Lx,Ly,1);
caxis(color_range);
print('-r300','-dpng',[outdir,'By_t',it]);
close(gcf)
%%
% plot_field(ey,Lx,Ly,norm);
% color_range=caxis;
% hold on
% plot_stream(ss,Lx,Ly,1);
% caxis(color_range);
% print('-r300','-dpng',[outdir,'Ey_t',it]);
% close(gcf)
% %%
% plot_field(ez,Lx,Ly,norm);
% color_range=caxis;
% hold on
% plot_stream(ss,Lx,Ly,1);
% caxis(color_range);
% print('-r300','-dpng',[outdir,'Ez_t',it]);
% close(gcf)
%%---------------------------------------------------------------
% ny=size(by,1);
%%--------------------By VS Ne-----------------------
% for j=1:nl2
% ff1=plot_line(by,Lx,Ly,zlower_cut(j),b0,0);
% ff2=plot_line(ne,Lx,Ly,zlower_cut(j),n0,0);
% %%
% yy=-Ly/2:Ly/ny:Ly/2-Ly/ny;
% xx=0:Lx/nx:Lx-Lx/nx;
% [ax,h1,h2]=plotyy(xx,ff1,xx,ff2);
% %
% xlim(ax(1),[5 50]);  
% xlim(ax(2),[5 50]);
% %%
% set(ax(1),'YaxisLocation','left','xminortick','on')
% set(ax(2),'YaxisLocation','right','xminortick','on')
% set(get(ax(2),'Ylabel'),'color','k','fontsize',13)
% set(get(ax(2),'Ylabel'),'color','r','fontsize',13)
% set(h1,'color','k','linewidth',1.)
% set(h2,'color','r','linewidth',1)
% set(ax(1),'Ycolor','k')
% set(ax(2),'Xticklabel',{},'Ycolor','r')
% set(ax,'fontsize',14)
%ylim(ax(2),[0,0.5]);
%%
% [ne_min,kmin]=min(ff2(ny/2+1:ny*3/4));
% [by_max,kmax]=max(abs(ff1(ny/2+1:ny*3/4)));
% kdisp=abs(kmax-kmin)*2/di;
%%
% icut=10*zlower_cut(j);
% %title(['displacement: ',num2str(kdisp,'%4.3f')]);
% print('-r300','-dpng',[outdir,'ByNe_t',it,'_z',num2str(icut,'%3.3d')]);
% close(gcf)
% %%
% end
%%--------------------Jpara VS Vepara-----------------------
% ff1=plot_line(jc_para,Lx,Ly,xupper_cut(j),n0*Va,1);
% ff2=plot_line(ve_para,Lx,Ly,xupper_cut(j),Va,1);
% %%
% yy=-Ly/2:Ly/ny:Ly/2-Ly/ny;
% [ax,h1,h2]=plotyy(yy,ff1,yy,ff2);
% %%
% xlim(ax(1),[0 Ly/2]);  xlim(ax(2),[0 Ly/2]);
% %%
% set(ax(1),'YaxisLocation','left','xminortick','on')
% set(ax(2),'YaxisLocation','right','xminortick','on')
% set(get(ax(2),'Ylabel'),'color','k','fontsize',13)
% set(get(ax(2),'Ylabel'),'color','r','fontsize',13)
% set(h1,'color','k','linewidth',1.)
% set(h2,'color','r','linewidth',1)
% set(ax(1),'Ycolor','k')
% set(ax(2),'Xticklabel',{},'Ycolor','r')
% set(ax,'fontsize',14)
% %%
% print('-r300','-dpng',[outdir,'JcVe_t',it,'_x',num2str(icut,'%3.3d')]);
% close(gcf)

% end

%%-----------------------------------------------------------------
% for j=1:nl2
% ff1=plot_line(by,Lx,Ly,xlower_cut(j),b0,1);
% ff2=plot_line(ne,Lx,Ly,xlower_cut(j),n0,1);
% %%
% yy=-Ly/2:Ly/ny:Ly/2-Ly/ny;
% [ax,h1,h2]=plotyy(yy,ff1,yy,ff2);
% %
% xlim(ax(1),[-Ly/2 0]);  xlim(ax(2),[-Ly/2 0]);
% %%
% set(ax(1),'YaxisLocation','left','xminortick','on')
% set(ax(2),'YaxisLocation','right','xminortick','on')
% set(get(ax(2),'Ylabel'),'color','k','fontsize',13)
% set(get(ax(2),'Ylabel'),'color','r','fontsize',13)
% set(h1,'color','k','linewidth',1.)
% set(h2,'color','r','linewidth',1)
% set(ax(1),'Ycolor','k')
% set(ax(2),'Xticklabel',{},'Ycolor','r')
% set(ax,'fontsize',14)
% ylim(ax(2),[0,0.4]);
% %%
% [ne_min,kmin]=min(ff2(1:ny/4));
% [by_max,kmax]=max(abs(ff1(1:ny/4)));
% kdisp=abs(kmax-kmin)*2/di;
% 
% icut=10*xlower_cut(j);
% title(['displacement: ',num2str(kdisp,'%4.3f')]);
% print('-r300','-dpng',[outdir,'ByNe_t',it,'_x',num2str(icut,'%3.3d')]);
% close(gcf)
%%--------------------Jpara VS Vepara-----------------------
% ff1=plot_line(jc_para,Lx,Ly,xlower_cut(j),n0*Va,1);
% ff2=plot_line(ve_para,Lx,Ly,xlower_cut(j),Va,1);
% %%
% yy=-Ly/2:Ly/ny:Ly/2-Ly/ny;
% [ax,h1,h2]=plotyy(yy,ff1,yy,ff2);
% 
% xlim(ax(1),[-Ly/2 0]);  xlim(ax(2),[-Ly/2 0]);
% %%
% set(ax(1),'YaxisLocation','left','xminortick','on')
% set(ax(2),'YaxisLocation','right','xminortick','on')
% set(get(ax(2),'Ylabel'),'color','k','fontsize',13)
% set(get(ax(2),'Ylabel'),'color','r','fontsize',13)
% set(h1,'color','k','linewidth',1.)
% set(h2,'color','r','linewidth',1)
% set(ax(1),'Ycolor','k')
% set(ax(2),'Xticklabel',{},'Ycolor','r')
% set(ax,'fontsize',14)
% %%
% print('-r300','-dpng',[outdir,'JcVe_t',it,'_x',num2str(icut,'%3.3d')]);
% close(gcf)
%%-----------------------for Ohm's law-------------------------------
% ef=ohm(:,1);
% evbi=ohm(:,2);
% evbe=ohm(:,3);
% dv=ohm(:,4);
% dp=ohm(:,5);
% %%
% ef=reshape(ef,nx,ny);
% ef=ef';
% evbi=reshape(evbi,nx,ny);
% evbi=evbi';
% evbe=reshape(evbe,nx,ny);
% evbe=evbe';
% dv=reshape(dv,nx,ny);
% dv=dv';
% dp=reshape(dp,nx,ny);
% dp=dp';
% %%
% %%
% aa=ef-evbi;
% bb=ef-evbe;
% aa=simu_filter2d(aa);
% bb=simu_filter2d(bb);
% dv=simu_filter2d(dv);
% dp=simu_filter2d(dp);
%%plot_field(dp,Lx,Ly,norm);
% plot_field(aa,Lx,Ly,norm);
% plot_field(bb,Lx,Ly,norm);
%%
% for j=1:nl1
% cut=xupper_cut(j);
% 
% plot_line(aa,Lx,Ly,cut,norm,1,'k',1);
% hold on
% plot_line(bb,Lx,Ly,cut,norm,1,'r');
% plot_line(dv,Lx,Ly,cut,norm,1,'g');
% plot_line(dp,Lx,Ly,cut,norm,1,'b');
% plot_line(ne,Lx,Ly,cut,n0,1,'m--');
% xlim([0 Ly/2])
% ylim([-3,3])
% plot([Ly/4 Ly/4],[-3,3],'k--','linewidth',1.)
% 
% print('-r300','-dpng',[outdir,'Ohmz_upper_t',it,'_x',num2str(cut,'%3.3d')]);
% close(gcf)
% end
%%%%%========================================
% for j=1:nl2
% cut=xlower_cut(j);
% 
% plot_line(aa,Lx,Ly,cut,norm,1,'k',1);
% hold on
% plot_line(bb,Lx,Ly,cut,norm,1,'r');
% % plot_line(dv,Lx,Ly,cut,norm,1,'g');
% % plot_line(dp,Lx,Ly,cut,norm,1,'b');
% plot_line(ne,Lx,Ly,cut,n0,1,'m--');
% xlim([-Ly/2 0])
% ylim([-3,3])
% plot([-Ly/4 -Ly/4],[-3,3],'k--','linewidth',1.)
% 
% print('-r300','-dpng',[outdir,'Ohmz_lower_t',it,'_x',num2str(cut,'%3.3d')]);
% close(gcf)
% end

%%
end









