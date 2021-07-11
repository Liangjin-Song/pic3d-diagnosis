%% subplot J E vi and ve
% writen by Liangjin Song on 20191028
clear;
indir='/data/simulation/rec2d_M100SBg00Tie2/data/';
outdir='/data/simulation/rec2d_M100SBg00Tie2/out/je/';
tt=60;
c=0.6;
n0=964.28925;
wci=0.000750;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);
vA=di*wci;

cd(indir);
ex=read_data('Ex',tt);
ey=read_data('Ey',tt);
ez=read_data('Ez',tt);

vx=read_data('vxi',tt);
vy=read_data('vyi',tt);
vz=read_data('vzi',tt);

bx=read_data('Bx',tt);
bx=bx/c;
by=read_data('By',tt);
by=by/c;
bz=read_data('Bz',tt);
bz=bz/c;

ss=read_data('stream',tt);

% E+VxB
edx=ex+vy.*bz-vz.*by;
edy=ey+vz.*bx-vx.*bz;
edz=ez+vx.*by-vy.*by;

figure;
plot_overview(edz,ss,vA,Lx,Ly);
cd(outdir);
