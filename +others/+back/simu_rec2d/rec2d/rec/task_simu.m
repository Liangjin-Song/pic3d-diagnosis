%%to plot the Reconnection simulation results
Lx=120;
Ly=40;
Va=0.03;
n0=400;
b0=0.6;
qi=0.000304;
c=0.6;

tt=40;
it=num2str(tt,'%3.3d');

% bx=load(['Bx_t',it,'.00.txt']);
by=load(['By_t',it,'.00.txt']);
% bz=load(['Bz_t',it,'.00.txt']);
%  vxe=load(['vxe_t',it,'.00.txt']);
%  vye=-load(['vye_t',it,'.00.txt']);
%  vze=load(['vze_t',it,'.00.txt']);
%  vxi=load(['vxi_t',it,'.00.txt']);
%  vyi=-load(['vyi_t',it,'.00.txt']);
%  vzi=load(['vzi_t',it,'.00.txt']);
%  ne=load(['Dense_t',it,'.00.txt']);
%  ni=load(['Densi_t',it,'.00.txt']);
flwxe=load(['flwxe_t',it,'.00.txt']);
flwye=load(['flwye_t',it,'.00.txt']);
flwze=load(['flwze_t',it,'.00.txt']);
flwxi=load(['flwxi_t',it,'.00.txt']);
flwyi=load(['flwyi_t',it,'.00.txt']);
flwzi=load(['flwzi_t',it,'.00.txt']);
jx=(flwxi-flwxe);
jy=(flwyi-flwye);
jz=(flwzi-flwze);
% [jxb,jyb,jzb]=simu_curlB(bx,by,bz,c);
% jy0=jy-jyb;
% plot_field(jy0,Lx,Ly,1);
stream=load(['stream_t',it,'.00.txt']);
%   eleaven=load(['eleaven_t',it,'.00.txt']);
% ex=load(['Ex_t',it,'.00.txt']);
% ey=load(['Ey_t',it,'.00.txt']);
% ez=load(['Ez_t',it,'.00.txt']);
%%===============================================
% jdotEi=flwxi.*ex+flwyi.*ey+flwzi.*ez;
% jdotEe=flwxe.*ex+flwye.*ey+flwze.*ez;
% bx=simu_filter2d(bx);
% by=simu_filter2d(by);
% bz=simu_filter2d(bz);
% ex=simu_filter2d(ex);
% ey=simu_filter2d(ey);
% ez=simu_filter2d(ez);
%  ne=simu_filter2d(ne);
% ne=simu_filter2d(ne);
% convx=ex+vyi.*by/b0-vzi.*by/b0;
% convy=ey+vzi.*bx/b0-vxi.*bz/b0;
% convz=ez+vxi.*by/b0-vyi.*bx/b0;
%bt=sqrt(bx.^2+by.^2+bz.^2);
% Epara=plot_Epara(bx,by,bz,ex,ey,ez,Lx,Ly,b0*Va);
% Epara=simu_filter2d(Epara);
% plot_field(Epara,Lx,Ly,b0*Va);
% vv=find(abs(ey/Va/b0)<0.01);
% convy(vv)=0;
plot_field(jx,Lx,Ly,n0*Va,1);
plot_field(jy,Lx,Ly,n0*Va,1);
plot_field(jz,Lx,Ly,n0*Va,1);
%   hold on
%  plot_stream(stream,Lx,Ly,1);
% plot_line(by,Lx,Ly,20,b0,1);
% figure
% plot_line(ne,Lx,Ly,20,n0,1);
% ve_para=plot_Epara(bx,by,bz,vxe,vye,vze,Lx,Ly,Va);

% flwe_para=plot_Epara(bx,by,bz,flwxe,flwye,flwze,Lx,Ly,Va*n0);
% flwi_para=plot_Epara(bx,by,bz,flwxi,flwyi,flwzi,Lx,Ly,Va*n0);
% jc_para=flwi_para-flwe_para;
% jc_para=simu_filter2d(jc_para);
% plot_field(jc_para,Lx,Ly,n0*Va);

%%--------------------YY plot-----------------------
% ff1=plot_line(bz,Lx,Ly,-25,b0,0);
% ff2=plot_line(ey,Lx,Ly,-25,b0*Va,0);
% %%
% yy=0:Lx/1024:Lx-Lx/1024;
% [ax,h1,h2]=plotyy(yy,ff1,yy,ff2);
% xlim(ax(1),[0 120])
% xlim(ax(2),[0 120])
% set(ax(1),'YaxisLocation','left','xminortick','on')
% set(ax(2),'YaxisLocation','right','xminortick','on')
% set(get(ax(2),'Ylabel'),'color','k','fontsize',13)
% set(get(ax(2),'Ylabel'),'color','r','fontsize',13)
% set(h1,'color','k','linewidth',1.)
% set(h2,'color','r','linewidth',1)
% set(ax(1),'Ycolor','k')
% set(ax(2),'Xticklabel',{},'Ycolor','r')
% set(ax,'fontsize',14)









