% function figure4_1()
%% figure 4, part 1
% writen by Liangjin Song on 20210628
% the distribution function of cold ions, hot ions, and electrons at DF
%%
clear;
run('articles.article4.parameters.m');
extra.log=true;
%% the distribution function file name of cold ions, hot ions, and electrons
nic='PVh_ts102564_x1460-1505_y986-1015_z0-1';
ni='PVl_ts102564_x1460-1505_y986-1015_z0-1';
ne='PVe_ts102564_x1460-1505_y986-1015_z0-1';

%% set the figure
f=figure('Position',[500,10,1100,800]);
ha=slj.Plot.subplot(3,3,[0.09,0.09],[0.085,0.07],[0.085,0.07]);


%% for cold ions
% the speed precision
extra.precv=120;
dst=prm.read(nic);
dst=dst.dstv(prm.value.vA, extra.precv);
extra.range1=2.5;
extra.range2=2.5;
extra.range3=1.5;
plot_species_distribution_function(dst,1,ha,extra,'Vic')

%% for hot ions
% the speed precision
extra.precv=60;
dst=prm.read(ni);
dst=dst.dstv(prm.value.vA, extra.precv);
extra.range1=5;
extra.range2=5;
extra.range3=5;
plot_species_distribution_function(dst,2,ha,extra,'Vi')

%% for hot electrons
% the speed precision
extra.precv=30;
dst=prm.read(ne);
dst=dst.dstv(prm.value.vA, extra.precv);
extra.range1=18;
extra.range2=18;
extra.range3=18;
plot_species_distribution_function(dst,3,ha,extra,'Ve')

%% save the figure
cd(outdir);
print('-dpng','-r300','figure8-1.png');

%% plot the distribution function for a species
function plot_species_distribution_function(pv,np,ha,extra,sp)
extra.colormap='moon';
%% x-y
axes(ha(np));
extra.xlabel=[sp,'_x'];
extra.ylabel=[sp,'_y'];
dst=pv.intgrtv(3);
extra.xrange=[-extra.range1,extra.range1];
extra.yrange=[-extra.range1,extra.range1];
slj.Plot.field2d(dst.value, dst.ll, dst.ll,extra);
%% x-z
axes(ha(np+3));
extra.xlabel=[sp,'_x'];
extra.ylabel=[sp,'_z'];
extra.xrange=[-extra.range2,extra.range2];
extra.yrange=[-extra.range2,extra.range2];
dst=pv.intgrtv(2);
slj.Plot.field2d(dst.value, dst.ll, dst.ll,extra);
%% x-z
axes(ha(np+6));
extra.xlabel=[sp,'_y'];
extra.ylabel=[sp,'_z'];
dst=pv.intgrtv(1);
extra.xrange=[-extra.range3,extra.range3];
extra.yrange=[-extra.range3,extra.range3];
slj.Plot.field2d(dst.value, dst.ll, dst.ll,extra);
end