% function plot_distribution_function_as_vx_rx()
%%
% @info: writen by Liangjin Song on 20210607 
% @brief: plot the distribution function as the function of velocity and rx
%%
clear;
%% parameters
% directory
indir='Z:\Simulation\asym\cold2_ds1\data';
% indir = 'E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Kinetic\Distribution';
prm=slj.Parameters(indir, outdir);
% the file name of distribution function
name1='PVe_ts64000_x1200-1600_y418-661_z0-1';
name2='PVe_ts64000_x1600-2000_y418-661_z0-1';
name = 'e';
% velocity direction
vdir=1;
%% the figure style
extra.colormap='moon';
extra.xrange=[30,50];
% extra.yrange=[-20,20];
% extra.caxis=[0,300];
extra.xlabel='X [c/\omega_{pi}]';
if vdir==1
    extra.ylabel=['V', name, '_x [V_A]'];
    suffix='_rx_vx';
elseif vdir == 2
    extra.ylabel=['V', name, '_y [V_A]'];
    suffix='_rx_vy';
else
    extra.ylabel=['V', name, '_z [V_A]'];
    suffix='_rx_vz';
end
%% read data
spc1 = prm.read(name1);
spc2 = prm.read(name2);
spcs = spc1.add(spc2);
spc = spcs.subposition([0, 50], [0, 1], [-1, -0.85]);
dst=spc.dstrv(1,vdir,prm.value.vA,prm.value.nx);
%% plot figure
f=slj.Plot();
extra.log = false;
f.field2d_suitable(dst.value, dst.ll.lr, dst.ll.lv,extra);
cd(outdir);
% f.png(prm,[name,suffix]);