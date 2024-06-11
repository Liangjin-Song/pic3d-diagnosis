% function plot_vector_overview()
%%
% plot the cold ions density overview
% writen by Liangjin Song on 20210629
%%
clear;
%% parameters
indir='E:\Turbulence\test';
outdir='E:\Turbulence\test';
prm=slj.Parameters(indir,outdir);

%% variable information
name='B';
tt=0;
% norm=prm.value.vA;
norm = 1;

%% figure properties
extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.title=['Vicz, \Omega_{ci}t=',num2str(tt)];
% extra.xrange=[10,50];
% extra.yrange=[-5,5];
% extra.caxis=[-1.5,1.5];

%% read data
fd=prm.read(name,tt);
% Ve = fd;
fd=slj.Scalar(fd.x);
ss=prm.read('stream',tt);

%% figure
f=slj.Plot();
% f.overview_suit(fd,ss,prm.value.lx,prm.value.lz,norm,extra);
f.overview(fd,ss,prm.value.lx,prm.value.lz,norm,extra);
% hold on
% f.plot_vector(Ve.x,Ve.z,prm.value.Lx,prm.value.Lz,40,5,'r')
cd(outdir);
% f.png(prm,[name,'x_t',num2str(tt),]);