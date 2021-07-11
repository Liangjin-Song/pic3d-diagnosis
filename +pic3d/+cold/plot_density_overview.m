function plot_density_overview()
%%
% plot the cold ions density overview
% writen by Liangjin Song on 20210629
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Overview\range';
prm=slj.Parameters(indir,outdir);

%% variable information
name='Nh';
tt=30;
norm=prm.value.n0;

%% figure properties
extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.title=['Nic, \Omega_{ci}t=',num2str(tt)];
extra.xrange=[40,52];
extra.yrange=[-5,5];
extra.caxis=[0,1.5];

%% read data
N=prm.read(name,tt);
ss=prm.read('stream',tt);

%% figure
f=slj.Plot();
f.overview(N,ss,prm.value.lx,prm.value.lz,norm,extra);
f.png(prm,[name,'_t',num2str(tt),'_range'])