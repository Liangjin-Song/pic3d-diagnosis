%% plot the different terms of GOL with 2D plot
clear

%%
tt=32;
nx=1000;
ny=1000;
Lx=50;
Ly=50;
c=0.6;
norm=0.03;
xrange=[37 39];
yrange=[11.5 13.5];
cr=[-0.4 0.4];
%%
dirr='H:\HallEM\size_50_50\Bg=1.0L=0.7\';
cd(dirr)
%%
it=num2str(tt,'%06.2f');
it=[it(1:3),'_',it(:,5:6)];
load(['ohmy_t',it,'.mat']);
eval(['ohm=ohmy_t',it,';']);
load(['stream_t',it,'.mat']);
eval(['ss=stream_t',it,';']);
% ohm=load(['ohmy_t',it,'.00.txt']);
% ss=load(['stream_t',it,'.00.txt']);
%%
ef=ohm(:,1);
evbi=ohm(:,2);
evbe=ohm(:,3);
dp=ohm(:,5);
dvv=ohm(:,4);
% dvt=ohm(:,6);
%%
ef=reshape(ef,nx,ny);
ef=ef';
evbi=reshape(evbi,nx,ny);
evbi=evbi';
evbe=reshape(evbe,nx,ny);
evbe=evbe';
dp=reshape(dp,nx,ny);
dp=dp';
dvv=reshape(dvv,nx,ny);
dvv=dvv';
% dvt=reshape(dvt,nx,ny);
% dvt=dvt';
% dvdt=dvv+dvt;
%%
ef=simu_filter2d(ef);
evbi=simu_filter2d(evbi);
evbe=simu_filter2d(evbe);
dvv=simu_filter2d(dvv);
dp=simu_filter2d(dp);
% dvdt=simu_filter2d(dvdt);
aa=ef-evbi;
bb=ef-evbe;
cc=ef-(evbe+dp+dvv);
jxb=-evbi+evbe;
%%-----------------male field plot--------------------
figure
h1=subplot('position',[0.2,0.7,0.6,0.28]);
% h1=subplot(3,1,1);
plot_field(bb,Lx,Ly,norm);
hold on
plot_stream(ss,Lx,Ly,80);
xlim(xrange)
ylim(yrange)
caxis(cr)
xlabel('');
set(h1,'xticklabel',{''})
%%
h2=subplot('position',[0.2,0.4,0.6,0.28]);
% h2=subplot(3,1,2);
plot_field(dp,Lx,Ly,norm);
hold on
plot_stream(ss,Lx,Ly,80);
xlim(xrange)
ylim(yrange)
caxis(cr)
xlabel('');
set(h2,'xticklabel',{''})
%%
h3=subplot('position',[0.2,0.1,0.6,0.28]);
% h3=subplot(3,1,3);
plot_field(dvv,Lx,Ly,norm);
hold on
plot_stream(ss,Lx,Ly,80);
xlim(xrange)
ylim(yrange)
caxis(cr)



