%% plot overview
% writen by Liangjin on 20190519 
clear;
indir='/data/simulation/M25SBg00Sx_low_vte/data/';
outdir='/data/simulation/M25SBg00Sx_low_vte/out/overview/';
tt=40.5:0.5:99.5;
c=0.6;
n0=750.01184;
wci=0.001;
di=30;
Lx=6000/di;
Ly=3000/di;
vA=di*wci;
plot_general_overview(indir,outdir,tt,c,vA,n0,Lx,Ly);
