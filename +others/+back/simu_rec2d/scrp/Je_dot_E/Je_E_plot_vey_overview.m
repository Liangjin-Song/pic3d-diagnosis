%% analysis of Je dot E, plot Vey overview
% writen by Liangjin Song on 20200601
clear;
indir='/data/simulation/M100SBg00Sx_low_vte/ppc=100/';
outdir='/data/simulation/M100SBg00Sx_low_vte/out/ppc=100/Je.E/';

tt=50.5;
di=60;
Lx=6000/di;
Ly=3000/di;
vA=0.015000;
xrange=[85,100];
yrange=[0,25];

cd(indir);
ss=read_data('stream',tt);
vey=read_data('vye',tt);

figure;
plot_overview(vey,ss,vA,Lx,Ly);
xlim(xrange);
ylim(yrange);
cd(outdir);

