% function plot_sub_distribution_function()
%%
% @info: writen by Liangjin Song on 20210607 
% @brief: plot the distribution function as the function of velocity and rx
%%
clear;
%% parameters
% directory
indir='E:\Asym\Cold2\data';
outdir='E:\Asym\Cold2\out\Distribution\Separatrix';
prm=slj.Parameters(indir, outdir);
% the file name of distribution function
name='PVl_ts20010_x0-1000_y400-600_z0-1';
% velocity direction
vdir=3;
xrange=[14,16];
% xrange=[34.48,35.48];
zrange=[-1,-0.5];
yrange=[-10,10];
%% the figure style
range=5;
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
dst=spc.dstv(prm.value.vA);
dst=dst.intgrtv(vdir);

%% plot figure
f=slj.Plot();
f.field2d(dst.value, dst.ll, dst.ll,extra);
f.png(prm,[name,suffix,'_sub',num2str(xrange(1)),'-',num2str(xrange(2))]);