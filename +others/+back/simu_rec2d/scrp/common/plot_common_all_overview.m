%% plot overview
% writen by Liangjin on 20190519 
clear;
indir='E:\Simulation\rec2d_M100SBg00Sx\data';
outdir='E:\Simulation\rec2d_M100SBg00Sx\out\Overview';
tt=40;
c=0.6;
n0=964.28888;
wci=0.000750;
di=40;
Lx=4800/di;
Ly=2400/di;
vA=di*wci;
% varname={'Ex','Ey','Ez','vxi','vyi','vzi','vxe','vye','vze','Densi','Dense'}; % ,'Ti','Te'};
% varname={'Bx','By','Bz','Ex','Ey','Ez','vxi','vyi','vzi','vxe','vye','vze','Densi','Dense'};
varname={'Ex', 'Bz'};
plot_general_overview(indir,outdir,tt,varname,c,vA,n0,Lx,Ly);
