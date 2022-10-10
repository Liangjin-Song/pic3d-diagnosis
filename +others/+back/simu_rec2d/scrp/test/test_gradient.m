%% test curl b
% writen by Liangjin Song on 20190531
clear
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M25SBg00Sx/test/';
c=0.6;
t=95;
di=20;
ndx=4000;
ndy=2000;
Lx=ndx/di;
Ly=ndy/di;
grids=1;
z0=25;
% load data
cd(indir);
bx=read_data('Bx',t);
bx=bx/c;
by=read_data('By',t);
by=by/c;
bz=read_data('Bz',t);
bz=bz/c;

b=sqrt(bx.^2+by.^2+bz.^2);
bx=bx./b;
by=by./b;
bz=bz./b;
b=sqrt(bx.^2+by.^2+bz.^2);

fout=simu_div(b,b,1);

[gx,gy,gz]=calc_gradient(b,grids);
g=gx+gz;
% [lb,lx]=get_line_data(b,Lx,Ly,z0,1,0);
