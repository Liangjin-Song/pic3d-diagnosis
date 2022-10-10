% function plot_distribution_function_as_vx_ry()
%%
% @info: writen by Liangjin Song on 20210607 
% @brief: plot the distribution function as the function of vx and rx
%%
clear;
%% parameters
% directory
indir='E:\PIC\wave-particle\whistler\data5';
outdir='E:\PIC\wave-particle\whistler\out5';
prm=slj.Parameters(indir, outdir);
% the file name of distribution function
name='PVe_ts0_x0-2600_y0-1_z0-1';
%% the figure style
extra.colormap='moon';
extra.xrange=[-20,20];
extra.yrange=[-20,20];
% extra.caxis=[0,300];
extra.xlabel='Ve_{||} [V_A]';
extra.ylabel='Ve_{\perp} [V_A]';
extra.vdir=3;
%% read data
spc=prm.read(name);
dst=spc.dstv(prm.value.vA);
dst=dst.intgrtv(extra.vdir);
%% plot figure
f=slj.Plot();
f.field2d(dst.value, dst.ll, dst.ll,extra);
f.png(prm,[name,'_vx_vy']);
