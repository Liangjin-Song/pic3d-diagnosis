%% plot overview
% writen by Liangjin on 20190519 
clear;
indir='E:\Simulation\rec2d_M100SBg00Sx\data';
outdir='E:\Simulation\rec2d_M100SBg00Sx\out\line\DF';
tt=40;
c=0.6;
wci=0.000750;
di=40;
vA=di*wci;
n0=964.28888;
x0=15;
dirt=0;
Lx=4800/di;
Ly=2400/di;
plot_general_line(indir,outdir,x0,tt,c,vA,n0,Lx,Ly,dirt);
