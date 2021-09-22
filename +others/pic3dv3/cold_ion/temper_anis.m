%% plot A Psi
% writen by Liangjin Song on 20201217
indir='E:\PIC\Cold-Ions\data';
outdir='E:\PIC\Cold-Ions\benchmark';
nx=1200;
ny=800;
nz=1;
di=20;

name='Ph';
norm=1;
tt=20;
Lx=nx/di;
Ly=ny/di;

xrange=[10,30];
yrange=[-5,5];

cd(indir);
P=pic3d_read_data(name,tt,nx,ny,nz);
B=pic3d_read_data('B',tt,nx,ny,nz);
ss=pic3d_read_data('stream',tt,nx,ny,nz);

[para, perp]=field_aligned_coordinate_system(P,B);

anis=para./perp;
anis=log10(anis);

h=figure;
pic3d_plot_2D_base_field(anis,Lx,Ly,norm); hold on
cr=caxis;
pic3d_plot_2D_stream(ss,Lx,Ly,20); hold off
caxis(cr);
title(['log10T_{\parallel}/T_{\perp}, \Omega_{ci}t =',num2str(time)]);
xlim(xrange);
ylim(yrange);
cd(outdir);