% function figure3_1()
%% figure 3, part 1
% writen by Liangjin Song on 20210626
% the distribution function of cold ions, hot ions, and electrons in the
% vicinity of the X-line
%%
clear;
run('articles.article4.parameters.m');
extra.log=true;
%% the distribution function file name of cold ions, hot ions, and electrons
nic='PVh_ts51300_x1980-2020_y993-1008_z0-1';
ni='PVl_ts51300_x1980-2020_y993-1008_z0-1';
ne='PVe_ts51300_x1980-2020_y993-1008_z0-1';
% nic='PVh_ts99359_x1785-1875_y988-1013_z0-1';
% ni='PVl_ts99359_x1785-1875_y988-1013_z0-1';
% ne='PVe_ts99359_x1785-1875_y988-1013_z0-1';

%% set the figure
f=figure('Position',[500,10,1100,800]);
ha=slj.Plot.subplot(3,3,[0.09,0.09],[0.085,0.07],[0.085,0.07]);

%% for cold ions
% the speed precision
extra.precv=100;
dst=prm.read(nic);
dst=dst.dstv(prm.value.vA, extra.precv);
extra.range1=1;
extra.range2=1;
extra.range3=1;
plot_species_distribution_function(dst,1,ha,extra,'Vic')

%% for hot ions
% the speed precision
extra.precv=60;
dst=prm.read(ni);
dst=dst.dstv(prm.value.vA, extra.precv);
extra.range1=5;
extra.range2=3;
extra.range3=5;
plot_species_distribution_function(dst,2,ha,extra,'Vih')

%% for hot electrons
% the speed precision
extra.precv=30;
dst=prm.read(ne);
dst=dst.dstv(prm.value.vA, extra.precv);
extra.range1=20;
extra.range2=20;
extra.range3=20;
plot_species_distribution_function(dst,3,ha,extra,'Ve')

%% save the figure
cd(outdir);
print('-dpng','-r300','figure6-1.png');

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