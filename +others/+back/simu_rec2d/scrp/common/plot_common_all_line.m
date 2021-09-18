%% plot overview
% writen by Liangjin on 20190519 
clear;
indir='/data/simulation/M25SBg00Sx_low_vte/data/';
outdir='/data/simulation/M25SBg00Sx_low_vte/out/line/';
tt=0:0.5:99.5;
c=0.6;
wci=0.001;
di=30;
vA=di*wci;
n0=750.01184;
x0=25;
dirt=0;
Lx=6000/di;
Ly=3000/di;
plot_general_line(indir,outdir,x0,tt,c,vA,n0,Lx,Ly,dirt);
