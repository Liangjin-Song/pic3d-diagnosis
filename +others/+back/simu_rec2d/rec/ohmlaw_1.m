%% get the component of the generalized ohm's law
%%
clear

%%
tt=42;
nx=1280;
ny=1280;
Lx=102.4;
Ly=102.4;
c=0.6;
q=0.000418;
norm=1*0.04;
norm2=836;
norm3=0.6;
norm4=836*0.03;
cut=25.6;
xrange=[0 30];
%%
it=num2str(tt,'%3.3d');
ohm=load(['ohmy_t',it,'.00.txt']);
% % ne=load(['Dense_t',it,'.00.txt']);
% % bx=load(['Bx_t',it,'.00.txt']);
% % by=load(['By_t',it,'.00.txt']);
% bz=load(['Bz_t',it,'.00.txt']);
% % vxe=load(['vxe_t',it,'.00.txt']);
% % vye=load(['vye_t',it,'.00.txt']);
% % vze=load(['vze_t',it,'.00.txt']);
% vxi=load(['vxi_t',it,'.00.txt']);
% bz=simu_filter2d(bz);
% load(['ohmy_t',it,'_00.mat']);
% eval(['ohm=ohmy_t',it,'_00;']);
%%
ef=ohm(:,1);
evbi=ohm(:,2);
evbe=ohm(:,3);
dv=ohm(:,4);
dp=ohm(:,5);
%%
ef=reshape(ef,nx,ny);
ef=ef';
evbi=reshape(evbi,nx,ny);
evbi=evbi';
evbe=reshape(evbe,nx,ny);
evbe=evbe';
dv=reshape(dv,nx,ny);
dv=dv';
dp=reshape(dp,nx,ny);
dp=dp';
%%
% [jx,jy,jz]=simu_curlB(bx,by,bz,c);
% jx=jx/q/2;    % 2 is due to the grid averaging before output
% jy=jy/q/2;
% jz=jz/q/2;
% Jpara=plot_Epara(bx,by,bz,jx,jy,jz,Lx,Ly,1);
% Jpara=Jpara/q/2;
% Vpara=plot_Epara(bx,by,bz,vxe,vye,vze,Lx,Ly,norm3);
%%
aa=ef-evbi;
bb=ef-evbe;
cc=evbe+dp+dv;
jxb=-evbi+evbe;
ef=simu_filter2d(ef);
aa=simu_filter2d(aa);
bb=simu_filter2d(bb);
cc=simu_filter2d(cc);
jxb=simu_filter2d(jxb);
dv=simu_filter2d(dv);
dp=simu_filter2d(dp);
%%plot_field(dp,Lx,Ly,norm);
% plot_field(aa,Lx,Ly,norm);
% plot_field(bb,Lx,Ly,norm);
%%
plot_line(ef,Lx,Ly,cut,norm,0,'k',1);
hold on
plot_line(evbe,Lx,Ly,cut,norm,0,'b');
% plot_line(jxb,Lx,Ly,cut,norm,0,'r');
plot_line(dv,Lx,Ly,cut,norm,0,'y');
plot_line(dp,Lx,Ly,cut,norm,0,'g');
% plot_line(bz,Lx,Ly,cut,0.6,0,'r--');
plot_line(cc,Lx,Ly,cut,norm,0,'m--');
xlim(xrange)
% ylim([-1,1])
% plot([60 96],[-3,3],'k--','linewidth',1.)
plot(xrange,[0 0],'k--','linewidth',1.)






