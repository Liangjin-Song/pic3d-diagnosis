% function plot_distribution_function_as_vy_rx()
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
name='PVe_ts7500_x0-2600_y0-1_z0-1';
%% the figure style
extra.colormap='moon';
% extra.yrange=[-20,20];
% extra.caxis=[0,300];
extra.xlabel='X [\lambda_D]';
extra.ylabel='Ve_z [V_A]';
%% read data
spc=prm.read(name);
dst=spc.dstrv(1,2,prm.value.vA,prm.value.nx);
%% plot figure
figure;
slj.Plot.field2d(dst.value, dst.ll.lr, dst.ll.lv,extra);
cd(outdir);
print('-dpng','-r300',[name,'_rx_vy.png']);