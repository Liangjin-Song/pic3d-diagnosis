%% get the component of the generalized ohm's law
%%
clear

%%
tt=32;
nx=1000;
ny=1000;
Lx=50;
Ly=50;
norm=0.03;
cut=26;
center=12.5;    % the current sheet location
xrange=[0 25];
drt=1;   %1 means vertical cut, 0 means horizontal cut
%%
it=num2str(tt,'%06.2f');
it=[it(1:3),'_',it(5:6)];
load(['ohmz_t',it,'.mat']);
eval(['ohm=ohmz_t',it,';']);
% load(['By_t',it,'_00.mat']);
% eval(['by=By_t',it,'_00;']);

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
%%
ef=simu_filter2d(ef);   % smoothing the data
evbi=simu_filter2d(evbi);
evbe=simu_filter2d(evbe);
dv=simu_filter2d(dv);
dp=simu_filter2d(dp);
%%
aa=ef-evbi;   %E+ViXB
bb=ef-evbe;   %E+VeXB
cc=evbe+dp+dv;  %-VeXB-gradP-dVe/dt
jxb=-evbi+evbe;  %ViXB-VeXB
%%
plot_line(ef,Lx,Ly,cut,norm,drt,'k',1);
hold on
plot_line(evbi,Lx,Ly,cut,norm,drt,'b');
plot_line(jxb,Lx,Ly,cut,norm,drt,'r');
plot_line(dv,Lx,Ly,cut,norm,drt,'y');
plot_line(dp,Lx,Ly,cut,norm,drt,'g');
% plot_line(by,Lx,Ly,cut,0.6,drt,'r--');
plot_line(cc,Lx,Ly,cut,norm,drt,'m');
xlim(xrange)
plot(xrange,[0 0],'k--','linewidth',1.)
vv=axis;
plot([center,center],[vv(3),vv(4)],'k--','linewidth',1.)






