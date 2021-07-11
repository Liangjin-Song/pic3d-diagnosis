%% test the gradient of total magnetic field
% writen by Liangjin Song on 20190712 
clear;
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M25SBg00Sx/out/test/';
tt=85;
c=0.6;
ndx=4000;
ndy=2000;
di=20;
Lx=ndx/di;
Ly=ndy/di;
grids=1;

cd(indir);
bx=read_data('Bx',tt);
by=read_data('By',tt);
bz=read_data('Bz',tt);
b=sqrt(bx.^2+by.^2+bz.^2);
b=b/c;
ss=read_data('stream',tt);

[gx,gy,gz]=calc_gradient(b,grids);

figure;
% plot_field(b,Lx,Ly,c);
plot_field(gz,Lx,Ly,c);
color_range=caxis;
hold on
plot_stream(ss,Lx,Ly,40);
caxis(color_range);
xlim([100,200]);
ylim([0,50]);
set(gca,'FontSize',16);
cd(outdir);
