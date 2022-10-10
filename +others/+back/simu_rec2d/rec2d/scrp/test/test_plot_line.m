%% test RF
% writen by Liangjin Song on 20190624
tt=118;
indir='/home/liangjin/Simulation/AsyBg0/rec2d_M25B1.5T06Bs6Bg00/data/';
c=0.6;
ndx=2400;
ndy=1200;
di=2.3*5;
Lx=2400/di;
Ly=1200/di;
z0=25.75;
cd(indir);
bz=read_data('Bz',tt);
[lbz,lx]=get_line_data(bz,Lx,Ly,z0,c,0);
plot(lx,lbz,'k','LineWidth',2);
xlabel('X[c/\omega_{pi}]');
ylabel('Bz');
set(gca,'FontSize',16);
