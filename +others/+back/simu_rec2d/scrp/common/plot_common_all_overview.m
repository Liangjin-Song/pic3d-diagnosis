%% plot overview
% writen by Liangjin on 20190519 
clear;
indir='E:\rec2d_M100B02T02Bs6Bg10\data';
outdir='E:\rec2d_M100B02T02Bs6Bg10\out\Overview';
tt=0:19;
c=0.6;
n0=355.07578;
wci=0.000750;
di=40;
Lx=2400/di;
Ly=2400/di;
vA=di*wci;
% varname={'Ex','Ey','Ez','vxi','vyi','vzi','vxe','vye','vze','Densi','Dense'}; % ,'Ti','Te'};
varname={'Bx','By','Bz','Ex','Ey','Ez','vxi','vyi','vzi','vxe','vye','vze','Densi','Dense'};
plot_general_overview(indir,outdir,tt,varname,c,vA,n0,Lx,Ly);
