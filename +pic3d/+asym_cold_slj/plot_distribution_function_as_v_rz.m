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
%% time
tt = 50;
spn = 'h';

%% position
s=3;
xrange=[24.5,25.5];
zrange=[-2, 4];
yrange=[-100,100];
% velocity direction
vdir=3;
%% the figure style
extra.colormap='moon';
extra.log=true;
% extra.xrange=[20,50];
% extra.yrange=[-20,20];
% extra.caxis=[0,300];
extra.xlabel='Z [c/\omega_{pi}]';
if vdir==1
    extra.ylabel='Vic_x [V_A]';
    suffix='_rz_vx';
elseif vdir == 2
    extra.ylabel='Vic_y [V_A]';
    suffix='_rz_vy';
else
    extra.ylabel='Vic_z [V_A]';
    suffix='_rz_vz';
end

%% file name
if s == 1
    %% x = [0,10] di
    name=['PV',spn,'_ts',num2str(tt/prm.value.wci),'_x0-400_y418-661_z0-1'];
elseif s == 2
    %% x= [10, 20] di
    name=['PV',spn,'_ts',num2str(tt/prm.value.wci),'_x400-800_y418-661_z0-1'];
elseif s == 3
    %% x = [20, 30] di
    name=['PV',spn,'_ts',num2str(tt/prm.value.wci),'_x800-1200_y418-661_z0-1'];
elseif s == 4
    %% x = [30, 40] di
    name=['PV',spn,'_ts',num2str(tt/prm.value.wci),'_x1200-1600_y418-661_z0-1'];
else
    %% x = [30, 40] di
    name=['PV',spn,'_ts',num2str(tt/prm.value.wci),'_x1600-2000_y418-661_z0-1'];
end

%% read data
spc=prm.read(name);
spc=spc.subposition(xrange,yrange,zrange);
dst=spc.dstrv(3,vdir,prm.value.vA,6*40);
%% plot figure
f=slj.Plot();
f.field2d(dst.value, dst.ll.lr, dst.ll.lv,extra);
cd(outdir);
f.png(prm,[name,suffix]);