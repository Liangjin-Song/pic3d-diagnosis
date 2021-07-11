%% get the component of the generalized ohm's law
%%
clear

%%
tt=46;
nx=1280;
ny=1280;
Lx=102.4;
Ly=102.4;
c=0.6;
q=0.000418;
norm=1*0.04;
norm2=500;
norm3=0.6;
norm4=658*0.03;
cut=25.6;
center=12.5;
xrange=[26,52];
yrange=[23,28.2];
ishift=30;
drt=0;
%%
it=num2str(tt,'%06.2f');
it=[it(1:3),'_',it(5:6)];
% ohm=load(['ohmy_t',it,'.txt']);
% % ne=load(['Dense_t',it,'.00.txt']);
% % bx=load(['Bx_t',it,'.00.txt']);
% % by=load(['By_t',it,'.00.txt']);
% bz=load(['Bz_t',it,'.00.txt']);
% % vxe=load(['vxe_t',it,'.00.txt']);
% % vye=load(['vye_t',it,'.00.txt']);
% % vze=load(['vze_t',it,'.00.txt']);
% vxi=load(['vxi_t',it,'.00.txt']);
% bz=simu_filter2d(bz);
load(['stream_t',it,'.mat']);
eval(['ss=stream_t',it,';'])
load(['Bz_t',it,'.mat']);
eval(['bz=Bz_t',it,';'])
load(['ohmz_t',it,'.mat']);
eval(['ohm=ohmz_t',it,';']);
% load(['By_t',it,'_00.mat']);
% eval(['by=By_t',it,'_00;']);

%%
ef=ohm(:,1);
evbi=ohm(:,2);
evbe=ohm(:,3);
dp=ohm(:,4);
dvv=ohm(:,5);
dvt=ohm(:,6);
%%
ef=reshape(ef,nx,ny);
ef=ef';
evbi=reshape(evbi,nx,ny);
evbi=evbi';
evbe=reshape(evbe,nx,ny);
evbe=evbe';
dvv=reshape(dvv,nx,ny);
dvv=dvv';
dp=reshape(dp,nx,ny);
dp=dp';
dvt=reshape(dvt,nx,ny);
dvt=dvt';
%%
%%
ef=simu_filter2d(ef);
evbi=simu_filter2d(evbi);
evbe=simu_filter2d(evbe);
dvv=simu_filter2d(dvv);
dvt=simu_filter2d(dvt);
dp=simu_filter2d(dp);
dvdt=dvv+dvt;
aa=ef-evbi;
bb=ef-evbe;
cc=evbe+dp+dvdt;
jxb=-evbi+evbe;
%%
aa=simu_shift(aa,Lx,Ly,ishift);
ss=simu_shift(ss,Lx,Ly,ishift);
bz=simu_shift(bz,Lx,Ly,ishift);
%% ---------------pcolor plot----------------

% plot_field(aa,Lx,Ly,norm);
% vv=caxis;
% hold on
% plot_stream(ss,Lx,Ly,60);
% caxis(vv)
% xlim(xrange)
% ylim(yrange)

%% ---------------line plot------------------
% plot_line(bz,Lx,Ly,cut,0.6,drt,'k',1);
% hold on
% plot_line(aa,Lx,Ly,cut,norm,drt,'r');
% % plot_line(jxb,Lx,Ly,cut,norm,drt,'r');
% % plot_line(dvdt,Lx,Ly,cut,norm,drt,'y');
% % plot_line(dp,Lx,Ly,cut,norm,drt,'g');
% % % plot_line(dvt,Lx,Ly,cut,norm,drt,'c');
% % plot_line(bz,Lx,Ly,cut,0.6,drt,'m--');
% % plot_line(cc,Lx,Ly,cut,norm,drt,'m');
% xlim(xrange)
% % ylim([-1,1])
% % plot([60 96],[-3,3],'k--','linewidth',1.)
% plot(xrange,[0 0],'k--','linewidth',1.)
% % vv=axis;
% % plot([center,center],[vv(3),vv(4)],'k--','linewidth',1.)

%% -------------an oblique line---------------------
% [xx,yy]=ginput(2);
% r0=[xx(1),yy(1)];
% r1=[xx(2),yy(2)];  % select the trajectory by hand
% plot([r0(1),r1(1)],[r0(2),r1(2)],'k--','linewidth',1.5)
% %
% plot_line2(aa,Lx,Ly,r0,r1,1,'r',1);
% hold on
% plot_line2(bz,Lx,Ly,r0,r1,1,'b');
% xlim(xrange)
% plot(xrange,[0 0],'k--','linewidth',1.)





