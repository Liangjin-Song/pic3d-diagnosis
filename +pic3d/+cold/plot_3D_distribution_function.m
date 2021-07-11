% function plot_3D_distribution_function()
%%
% plot the 3D distribution function
% writen by Liangjin Song on 20210629
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Distribution_Function\Diagnose\X-line\3D\X-line\15';
prm=slj.Parameters(indir, outdir);

%% distribution function name
name='PVh_ts48100_x1980-2020_y993-1008_z0-1';

%% for cold ions
extra.isovalue=40;
extra.presion=80;
extra.xlabel='Vic_x';
extra.ylabel='Vic_y';
extra.zlabel='Vic_z';
f1=plot_3d_distribution_function(prm, name, extra);
f1.png(prm,name);

%% for ions
name(3)='l';
extra.isovalue=30;
extra.presion=40;
extra.xlabel='Vi_x';
extra.ylabel='Vi_y';
extra.zlabel='Vi_z';
f2=plot_3d_distribution_function(prm, name, extra);
f2.png(prm,name);

%% for ions
name(3)='e';
extra.isovalue=20;
extra.presion=30;
extra.xlabel='Ve_x';
extra.ylabel='Ve_y';
extra.zlabel='Ve_z';
f3=plot_3d_distribution_function(prm, name, extra);
f3.png(prm,name);

function f=plot_3d_distribution_function(prm, name, extra)
dst=prm.read(name);
dst=dst.dstv(prm.value.vA, extra.presion);
value=dst.value;
for i=1:extra.presion
    value(:,:,i)=value(:,:,i)';
end
%% figure
f=slj.Plot();
f.isosurface(value, dst.ll, dst.ll, dst.ll, extra.isovalue, extra);
end