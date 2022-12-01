% function plot_vector_overview()
%%
% plot the cold ions density overview
% writen by Liangjin Song on 20210629
%%
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Kinetic\Distribution';
prm=slj.Parameters(indir,outdir);

%% variable information
name='E';
tt=50;
norm=prm.value.vA;
% norm = 1;
% norm = prm.value.bm*prm.value.c./sqrt(prm.value.mi*prm.value.nhm);

%% figure properties
extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.title=['Ez, \Omega_{ci}t=',num2str(tt)];
% extra.xrange=[10,50];
% extra.yrange=[-5,5];
% extra.caxis=[-1.5,1.5];

%% read data
fd=prm.read(name,tt);
fd=fd.z;
% afd = fd./fd;
% fd = fd + afd - 1;
ss=prm.read('stream',tt);

%% figure
f=slj.Plot();
f.overview(fd,ss,prm.value.lx,prm.value.lz,norm,extra);
cd(outdir);
f.png(prm,[name,'z_t',num2str(tt)]);