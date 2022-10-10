%% get the component of the generalized ohm's law
%%
clear

%%
tt=44;
nx=1280;
ny=1280;
Lx=102.4;
Ly=102.4;
c=0.6;
norm=1*0.04;
norm2=658;
norm3=0.6;
norm4=658*0.03;
xrange=[12 22];
yrange=[23 28.2];
shift=6;
cr=[-0.6 0.6];
%%
it=num2str(tt,'%3.3d');
load(['ohmy_t',it,'_00.mat']);
eval(['ohm=ohmy_t',it,'_00;']);
load(['stream_t',it,'_00.mat']);
eval(['ss=stream_t',it,'_00;']);
%%
ef=ohm(:,1);
evbi=ohm(:,2);
evbe=ohm(:,3);
dp=ohm(:,4);
dv=ohm(:,5);
dvt=ohm(:,6);
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
dvt=reshape(dvt,nx,ny);
dvt=dvt';
dvdt=dv+dvt;
%%
aa=ef-evbi;
bb=ef-evbe;
cc=evbe+dp+dv+dvdt;
jxb=-evbi+evbe;
ef=simu_filter2d(ef);
aa=simu_filter2d(aa);
bb=simu_filter2d(bb);
cc=simu_filter2d(cc);
jxb=simu_filter2d(jxb);
dv=simu_filter2d(dv);
dp=simu_filter2d(dp);
dvdt=simu_filter2d(dvdt);
%%
bb=simu_shift(bb,Lx,Ly,shift);
dp=simu_shift(dp,Lx,Ly,shift);
dvdt=simu_shift(dvdt,Lx,Ly,shift);
ss=simu_shift(ss,Lx,Ly,shift);
%%-----------------male field plot--------------------
figure

h1=subplot(3,1,1);
plot_field(bb,Lx,Ly,norm);
hold on
plot_stream(ss,Lx,Ly,60);
xlim(xrange)
ylim(yrange)
caxis(cr)
%%
h2=subplot(3,1,2);
plot_field(dp,Lx,Ly,norm);
hold on
plot_stream(ss,Lx,Ly,60);
xlim(xrange)
ylim(yrange)
caxis(cr)
%%
h3=subplot(3,1,3);
plot_field(dvdt,Lx,Ly,norm);
hold on
plot_stream(ss,Lx,Ly,60);
xlim(xrange)
ylim(yrange)
caxis(cr)






