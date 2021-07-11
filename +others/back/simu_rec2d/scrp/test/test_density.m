%% test the density
% writen by Liangjin Song 
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/test/';
tt=55;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;

cd(indir);
ni=read_data('Densi',tt);
ne=read_data('Dense',tt);
ss=read_data('stream',tt);
dn=ni-ne;

figure;
plot_overview(dn,ss,1,Lx,Ly);
title(['\Omega_{ci}t=',num2str(tt)]);
cd(outdir);
