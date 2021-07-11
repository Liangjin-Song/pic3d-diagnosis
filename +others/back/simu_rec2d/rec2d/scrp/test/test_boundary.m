%% test the boundary
% writen by Liangjin Song on 20190707 
clear;
indir='/data/simulation/M100SBg00Sx_low_vte/ppc=100/';
outdir='/data/simulation/M100SBg00Sx_low_vte/out/ppc=100/article/';
tt=53;
c=0.6;
ndx=6000;
ndy=3000;
di=60;
Lx=ndx/di;
Ly=ndy/di;

cd(indir);
vx=read_data('vxi',tt);
vz=read_data('vzi',tt);
bz=read_data('Bz',tt);
ss=read_data('stream',tt);
plot_overview(bz,ss,c,Lx,Ly); hold on
plot_vector(vx,vz,Lx,Ly,60,6,'r');

xlim([10,40]);
ylim([5,20]);

cd(outdir);
