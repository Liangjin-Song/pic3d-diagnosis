% function plot_snap_trajectory()
%%
% writen by Liangjin Song on 20210628
% plot the stream and the particle's trajectory
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\article';
prm=slj.Parameters(indir, outdir);

%% time
tt=30;

%% particle's id
% id=uint64(1466770715);
id=uint64(1202918096);

%% the figure property
extra.FontSize=14;
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

%% read data
ss=prm.read('stream',tt);
norm=prm.value.mi*prm.value.vA*prm.value.vA;
prt=prm.read(['trajh_id',num2str(id)]);
prt=prt.norm_energy(norm);
fd=ss;
fd=fd*NaN;

%% plot the figure
slj.Plot.overview(fd, ss, prm.value.lx, prm.value.lz, 1, extra);
xlim([30,50]);
ylim([-5,5]);
range=1:2501;
hold on
p=patch(prt.value.rx(range),prt.value.rz(range),[prt.value.k(range(1):range(end-1)); NaN],'edgecolor','flat','facecolor','none');
colormap('jet');
set(p,'LineWidth',3);
cb=colorbar;
cb.Label.String='K_{ic} [m_{ic}v_A^2]';
cb.Label.FontSize=extra.FontSize;
caxis([min(prt.value.k(range)),max(prt.value.k(range))]);
set(gca,'FontSize',extra.FontSize);


%% save the figure
cd(outdir);
print('-dpng','-r300',['figure4-2_id',num2str(id),'.png']);