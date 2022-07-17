% function plot_density_overview()
%%
% plot the cold ions density overview
% writen by Liangjin Song on 20210629
%%
clear;
%% parameters
indir='E:\Asym\cold2v2\data';
outdir='E:\Asym\cold2v2\out\Article';
prm=slj.Parameters(indir,outdir);

%% variable information
name='Nh';
tt=40;
norm=prm.value.nhm;

%% figure properties
extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
% extra.title=['Nic, \Omega_{ci}t=',num2str(tt)];
% extra.xrange=[40,52];
% extra.yrange=[-5,5];
% extra.caxis=[0,1.5];

%% read data
N=prm.read(name,tt);
ss=prm.read('stream',tt);
Ns = N.value./N.value;
N = N.value + Ns - 1;
%% figure
f=slj.Plot();
f.overview(N,ss,prm.value.lx,prm.value.lz,norm,extra);
% f.png(prm,[name,'_t',num2str(tt),'_range'])
cd(outdir);
print('-dpng','-r300',[name,'_t',num2str(tt),'.png']);