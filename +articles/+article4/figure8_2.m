% function figure8()
%%
% writen by Liangjin Song on 20210720
% the 3D distribution function at the DF
%%
% function plot_3D_distribution_function()
%%
% plot the 3D distribution function
% writen by Liangjin Song on 20210629
%%
clear;
%% parameters
clear;
run('articles.article4.parameters.m');
%% distribution function name
nic='PVh_ts102564_x1460-1505_y986-1015_z0-1';
ni='PVl_ts102564_x1460-1505_y986-1015_z0-1';
ne='PVe_ts102564_x1460-1505_y986-1015_z0-1';

%% for cold ions
name=nic;
extra.isovalue=20;
extra.presion=50;
extra.xlabel='Vic_x';
extra.ylabel='Vic_y';
extra.zlabel='Vic_z';
f1=plot_3d_distribution_function(prm, name, extra);
cd(outdir);
print('-dpng','-r300','figure8-2.png');

%% for ions
name=ni;
extra.isovalue=30;
extra.presion=40;
extra.xlabel='Vih_x';
extra.ylabel='Vih_y';
extra.zlabel='Vih_z';
f2=plot_3d_distribution_function(prm, name, extra);
cd(outdir);
print('-dpng','-r300','figure8-3.png');

%% for ions
name=ne;
extra.isovalue=20;
extra.presion=30;
extra.xlabel='Ve_x';
extra.ylabel='Ve_y';
extra.zlabel='Ve_z';
f3=plot_3d_distribution_function(prm, name, extra);
cd(outdir);
print('-dpng','-r300','figure8-4.png');

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