%% calculate the width of Hall field
%% this version for By only

Lx=100;
Lz=50;
it=38;
xcut=88;
filename=['By_t',num2str(it,'%3.3d'),'.00.txt'];
ff=load(filename);
% ff=simu_filter2d(ff);
fcut=plot_line(ff,Lx,Lz,xcut,0.6,1);
%%

