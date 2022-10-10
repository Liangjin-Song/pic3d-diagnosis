%% plot 2d field
%% writen by Liangjin Song on 20210411
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Overview\range';
cd(indir);

nx=4000;
ny=2000;
nz=1;
di=40;
norm=0.0125;

Lx=nx/di;
Ly=ny/di;
xrange=[49,56];
yrange=[-5,5];
cxs=[-0.8,0.8];
%% read da
tt=31;
fd=pic3d_read_data('E',tt,nx,ny,nz);
fd=fd.x;
ss=pic3d_read_data('stream',tt,nx,ny,nz);

%% figure
f=figure;
plot_overview(fd,ss,norm,Lx,Ly);
colormap(mycolormap(0));
caxis(cxs);
xlim(xrange);
ylim(yrange);
title(['Ex,\Omega_{ci}t=',num2str(tt)]);
set(gca,'FontSize',16);
%% save
cd(outdir)
print('-dpng','-r300',['Ex_t',num2str(tt,'%06.2f'),'.png']);