%% Some parameters of M100SBg00Sx_low_vte, ppc=100
% writen by Liangjin Song on 20191130
indir='/data/simulation/M100SBg00Sx_low_vte/ppc=100/';
outdir='/data/simulation/M100SBg00Sx_low_vte/out/ppc=100/article/';
dt=0.5;
di=60;
ndx=6000;
ndy=3000;
Lx=ndx/di; Ly=ndy/di;

tt=30:dt:53;

z0=12.5;
c=0.6;
grids=1;
wci=0.000250;

% x0=4500;
y0=2250;
top=2*di;
bottom=2*di;
left=3*di;
right=3*di;

%% density in current sheet
n0=600.01105;
coeff=30000.54883;

%% Alfven speed
vA=0.015000;

%% mass and charge
mi=2.666618;
me=0.026666;
qi=0.000667;
qe=-qi;

%% thermal velocity
vith=0.01;
veth=0.03536;

Te=1/coeff;
tie=8;
Ti=(1+tie)*Te;
