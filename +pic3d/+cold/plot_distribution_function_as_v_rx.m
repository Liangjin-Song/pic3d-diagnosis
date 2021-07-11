% function plot_distribution_function_as_vx_rx()
%%
% @info: writen by Liangjin Song on 20210607 
% @brief: plot the distribution function as the function of velocity and rx
%%
clear;
%% parameters
% directory
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Distribution_Function\Diagnose\DF';
prm=slj.Parameters(indir, outdir);
% the file name of distribution function
name='PVh_ts102564_x0-4000_y980-1021_z0-1';
% velocity direction
vdir=3;
%% the figure style
extra.colormap='moon';
extra.xrange=[20,50];
% extra.yrange=[-20,20];
% extra.caxis=[0,300];
extra.xlabel='X [c/\omega_{pi}]';
if vdir==1
    extra.ylabel='Vic_x [V_A]';
    suffix='_rx_vx';
elseif vdir == 2
    extra.ylabel='Vic_y [V_A]';
    suffix='_rx_vy';
else
    extra.ylabel='Vic_z [V_A]';
    suffix='_rx_vz';
end
%% read data
spc=prm.read(name);
dst=spc.dstrv(1,vdir,prm.value.vA,prm.value.nx);
%% plot figure
f=slj.Plot();
f.field2d(dst.value, dst.ll.lr, dst.ll.lv,extra);
f.png(prm,[name,suffix]);