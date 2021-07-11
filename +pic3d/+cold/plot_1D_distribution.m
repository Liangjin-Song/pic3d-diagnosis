function plot_1D_distribution
%%
% plot the 1-D distribution function
% writen by Liangjin Song on 20210629
%%
clear;
%%
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out';
prm=slj.Parameters(indir,outdir);

%% distribution function name
name='PVh_ts99359_x1785-1875_y988-1013_z0-1';

%% figure properties
extra=[];
extra.presion=100;

%% read and treat
dst=prm.read(name);
dst=dst.dstv(prm.value.vA, extra.presion);
dst=dst.intgrtv(1);
ld=sum(dst.value,2);

%% figure
plot(dst.ll,ld,'-k','LineWidth',2);