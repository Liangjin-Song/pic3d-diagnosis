% function plot_sub_distribution_function()
%%
% @info: writen by Liangjin Song on 20210607 
% @brief: plot the distribution function as the function of velocity and rx
%%
clear;
%% parameters
% directory
indir='E:\Asym\cb1\data';
outdir='E:\Asym\cb1\out\Distribution\X-line';
prm=slj.Parameters(indir, outdir);
% the file name of distribution function
name='PVh_ts12000_x0-1200_y300-500_z0-1';
% velocity direction
vdir=1;
xrange=[27,29];
% xrange=[34.48,35.48];
zrange=[-1,0];
yrange=[-100,100];
precision=100;
%% the figure style
range=1;
extra.colormap='moon';
extra.xrange=[-range,range];
extra.yrange=[-range,range];
extra.log=true;
% extra.caxis=[0,4000];

if name(3) == 'l'
    sfx='ih';
elseif name(3) == 'h'
    sfx='ic';
elseif name(3) == 'e'
    sfx = 'e';
else
    error('Parameters Error!');
end


if vdir==1
    extra.xlabel=['V',sfx,'_y [V_A]'];
    extra.ylabel=['V',sfx,'_z [V_A]'];
    suffix='_rx_vx';
elseif vdir == 2
    extra.xlabel=['V',sfx,'_x [V_A]'];
    extra.ylabel=['V',sfx,'_z [V_A]'];
    suffix='_rx_vy';
else
    extra.xlabel=['V',sfx,'_x [V_A]'];
    extra.ylabel=['V',sfx,'_y [V_A]'];
    suffix='_rx_vz';
end
%% read data
spc=prm.read(name);
spc=spc.subposition(xrange,yrange,zrange);
dst=spc.dstv(prm.value.vA,precision);
dst=dst.intgrtv(vdir);

%% plot figure
f=slj.Plot();
f.field2d(dst.value, dst.ll, dst.ll,extra);
% f.png(prm,[name,suffix,'_sub',num2str(xrange(1)),'-',num2str(xrange(2)),...
%     '_',num2str(yrange(1)),'-',num2str(yrange(2)),...
%     '_',num2str(zrange(1)),'-',num2str(zrange(2))]);