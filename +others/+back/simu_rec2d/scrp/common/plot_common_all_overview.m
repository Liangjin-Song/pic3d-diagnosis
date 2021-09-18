%% plot overview
% writen by Liangjin on 20190519 
clear;
indir='E:\Simulation\Test_Asy\rec2d_B1.5T06Bs6Bg00\data';
outdir='E:\Simulation\Test_Asy\rec2d_B1.5T06Bs6Bg00\out';
tt=11:16;
c=0.6;
n0=60.47601;
wci=0.00075;
di=40;
Lx=4800/di;
Ly=2400/di;
vA=di*wci;
varname={'Ex','Ey','Ez','vxi','vyi','vzi','vxe','vye','vze','Densi','Dense'}; % ,'Ti','Te'};
% varname={'Bx','By','Bz','Ex','Ey','Ez','vxi','vyi','vzi','vxe','vye','vze','Densi','Dense','Ti','Te'};
plot_general_overview(indir,outdir,tt,varname,c,vA,n0,Lx,Ly);
