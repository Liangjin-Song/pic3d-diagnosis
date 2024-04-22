% function plot_distribution_function_as_vx_rx()
%%
% @info: writen by Liangjin Song on 20210607 
% @brief: plot the distribution function as the function of velocity and rx
%%
clear;
%% parameters
% directory
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Kinetic\Distribution';
prm=slj.Parameters(indir, outdir);
% the file name of distribution function
name1='PVh_ts44800_x1200-1600_y418-661_z0-1';
name2='PVh_ts44800_x1600-2000_y418-661_z0-1';
name = 'ic';
% velocity direction
vdir=1;
%% the figure style
extra.colormap='moon';
extra.xrange=[20,50];
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
spc = spc1.add(spc2);
spc = spc.subposition([0, 50], [0, 1], [-0.75, -0.6]);
dst=spc.dstv();
dst = dst.intgrtv(3);
val = sum(dst.value, 2);

%% plot figure
f=slj.Plot();
plot(dst.ll./prm.value.vA, val/max(val), '-k', 'LineWidth', 2);
cd(outdir);