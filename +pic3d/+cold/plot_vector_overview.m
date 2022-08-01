% function plot_vector_overview()
%%
% plot the cold ions density overview
% writen by Liangjin Song on 20210629
%%
clear;
%% parameters
indir='E:\Asym\cold2v2\data';
outdir='E:\Asym\cold2v2\out';
prm=slj.Parameters(indir,outdir);

%% variable information
name='Vh';
tt=30;
norm=prm.value.vA;
% norm = 1;

%% figure properties
extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
% extra.title=['Ez, \Omega_{ci}t=',num2str(tt)];
% extra.xrange=[10,50];
% extra.yrange=[-5,5];
% extra.caxis=[-1.5,1.5];

%% read data
fd=prm.read(name,tt);
fd=slj.Scalar(fd.y);
ss=prm.read('stream',tt);

%% figure
f=slj.Plot();
f.overview(fd,ss,prm.value.lx,prm.value.lz,norm,extra);
% f.png(prm,[name,'_t',num2str(tt),'_range'])