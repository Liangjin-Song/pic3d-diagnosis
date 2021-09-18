%% illustrate RF thickness
% writen by Liangjin Song on 20190612 
indir='/simu/Simulation/rec2d_M100SBg00Tie2/data/';
outdir='/home/liangjin/Documents/Article/Revise/v1/';
tt=54;
% qe=-0.000311;
% qi=0.000311;
qi=1;
qe=-qi;
c=0.6;
vA=0.03;
n0=964.28925;
ndx=4800;
ndy=2400;
di=40;
Lx=ndx/di;
Ly=ndy/di;
x0=15;

% get data
cd(indir)
ni=read_data('Densi',tt);
ne=read_data('Densi',tt);
vix=read_data('vxi',tt);
viy=read_data('vyi',tt);
viz=read_data('vzi',tt);
vex=read_data('vxe',tt);
vey=read_data('vye',tt);
vez=read_data('vze',tt);
bz=read_data('Bz',tt);
bz=bz/c;

[Jx,Jy,Jz]=calc_current_density(ni,ne,qi,qe,vix,viy,viz,vex,vey,vez);
[ljy,lx]=get_line_data(Jy,Lx,Ly,x0,n0*vA,0);
[lbz,~]=get_line_data(bz,Lx,Ly,x0,1,0);

h=figure;
set(h,'Visible','on');
[ax,h1,h2]=plotyy_with_bz(ljy,lbz,lx,'Jy',[98,106]);
set(ax(1),'ylim',[0,13])
set(ax(2),'ylim',[-1,1.5])
cd(outdir)
