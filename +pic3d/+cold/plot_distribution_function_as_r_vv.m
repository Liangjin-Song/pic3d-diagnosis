function plot_distribution_function_as_vx_rx()
%
@info: writen by Liangjin Song on 20210607 
@brief: plot the distribution function as the function of velocity and rx
%
clear;
% parameters
directory
indir='E:\PIC\wave-particle\whistler\data';
outdir='E:\PIC\wave-particle\whistler\out';
prm=slj.Parameters(indir, outdir);
the file name of distribution function
name='PVe_ts0_x0-400_y0-1_z0-1';
velocity direction
vdir=2;
% the figure style
extra.colormap='moon';
extra.xrange=[0,prm.value.Lx];
extra.yrange=[-20,20];
extra.caxis=[0,300];
extra.xlabel='X [c/\omega_{pi}]';
if vdir==1
    extra.ylabel='Vic_y [V_A]';
    extra.zlabel='Vic_z [V_A]';
    suffic='_rx_vyz';
elseif vdir == 2
    extra.ylabel='Vic_x [V_A]';
    extra.zlabel='Vic_z [V_A]';
    suffic='_rx_vxz';
else
    extra.ylabel='Vic_x [V_A]';
    extra.zlabel='Vic_y [V_A]';
    suffic='_rx_vxy';
end
% read data
spc=prm.read(name);
dst=spc.dstrvv(1,vdir,prm.value.vA,prm.value.nx);
figure
sx=[];
sy=[0];
sz=[];
% plot figure
f=slj.Plot();
f.field3d(dst.value,dst.ll.lr, dst.ll.lv1, dst.ll.lv2, sx, sy, sz, extra);
f.png(prm,[name,suffix]);