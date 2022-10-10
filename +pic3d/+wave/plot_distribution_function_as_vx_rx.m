% function plot_distribution_function_as_vx_rx()
%%
% @info: writen by Liangjin Song on 20210607 
% @brief: plot the distribution function as the function of vx and rx
%%
clear;
%% parameters
% directory
indir='E:\PIC\wave-particle\test';
outdir='E:\PIC\wave-particle\test';
prm=slj.Parameters(indir, outdir);
% the file name of distribution function
name='PVe_ts0_x0-2600_y0-1_z0-1';
%% the figure style
extra.colormap='moon';
% extra.yrange=[-20,20];
% extra.caxis=[0,300];
extra.xlabel='X [\lambda_D]';
extra.ylabel='Ve_x [V_A]';
%% read data
spc=prm.read(name);
dst=spc.dstrv(1,1,prm.value.vA,prm.value.nx);
%% plot figure
f=slj.Plot();
f.field2d(dst.value, dst.ll.lr, dst.ll.lv,extra);
f.png(prm,[name,'_rx_vx']);