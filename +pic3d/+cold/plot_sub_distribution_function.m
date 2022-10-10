% function plot_sub_distribution_function()
%%
% @info: writen by Liangjin Song on 20210607 
% @brief: plot the distribution function as the function of velocity and rx
%%
clear;
%% parameters
% directory
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Distribution_Function\Diagnose\DF\Other';
prm=slj.Parameters(indir, outdir);
% the file name of distribution function
name='PVe_ts102564_x1460-1505_y986-1015_z0-1';
% velocity direction
vdir=3;
xrange=[36.9,37.1];
% xrange=[34.48,35.48];
zrange=[-0.1,0.1];
yrange=[-10,10];
%% the figure style
range=2.5;
extra.colormap='moon';
extra.xrange=[-range,range];
extra.yrange=[-range,range];
extra.log=true;
% extra.caxis=[0,4000];
if vdir==1
    extra.xlabel='Vic_y [V_A]';
    extra.ylabel='Vic_z [V_A]';
    suffix='_rx_vx';
elseif vdir == 2
    extra.xlabel='Vic_x [V_A]';
    extra.ylabel='Vic_z [V_A]';
    suffix='_rx_vy';
else
    extra.xlabel='Vic_x [V_A]';
    extra.ylabel='Vic_y [V_A]';
    suffix='_rx_vz';
end
%% read data
spc=prm.read(name);
spc=spc.subposition(xrange,yrange,zrange);
dst=spc.dstv(prm.value.vA);
dst=dst.intgrtv(vdir);

%% plot figure
f=slj.Plot();
f.field2d(dst.value, dst.ll, dst.ll,extra);
f.png(prm,[name,suffix,'_sub',num2str(xrange(1)),'-',num2str(xrange(2))]);