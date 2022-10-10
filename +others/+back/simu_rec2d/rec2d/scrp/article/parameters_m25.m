%% Some parameters of M100SBg00Sx_low_vte, ppc=100
% writen by Liangjin Song on 20191130
indir='/data/simulation/M25SBg00Sx_low_vte/data/';
outdir='/data/simulation/M25SBg00Sx_low_vte/out/sarticle/';
dt=0.5;
di=30;
ndx=6000;
ndy=3000;
Lx=ndx/di; Ly=ndy/di;

tt=35:dt:73;

z0=25;
c=0.6;
grids=1;
wci=0.001;

% x0=4500;
y0=2250;
top=2*di;
bottom=2*di;
left=3*di;
right=3*di;

%% density in current sheet
n0=750.01184;
coeff=37500.58984;

%% Alfven speed
vA=0.03000;

%% mass and charge
mi=0.533325;
me=0.021333;
qi=0.000533;
qe=-qi;

%% thermal velocity
vith=0.02;
veth=0.03536;

Te=1/coeff;
tie=8;
Ti=(1+tie)*Te;
