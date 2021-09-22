indir='E:\PIC\Cold-Ions\data';
outdir='E:\PIC\Cold-Ions\benchmark';
nx=1200;
ny=800;
nz=1;
di=20;

Lx=nx/di;
Ly=ny/di;
mi=0.499998;
n0=800.003418;
vA=0.025;
tt=30;

norm=0.5*mi*n0*vA*vA;

xrange=[0,Lx];
yrange=[-Ly/2,Ly/2];

cd(indir);

nic=pic3d_read_data('Nl',tt,nx,ny,nz);
vic=pic3d_read_data('Vl',tt,nx,ny,nz);
ss=pic3d_read_data('stream',tt,nx,ny,nz);

K=0.5*mi*(nic.*(vic.x.^2+vic.y.^2+vic.z.^2));
pic3d_plot_2D_base_field(K,Lx,Ly,norm); hold on
cr=caxis;
pic3d_plot_2D_stream(ss,Lx,Ly,20); hold off
caxis(cr);
title(['K_{i}, \Omega_{ci}t =',num2str(tt)]);
xlim(xrange);
ylim(yrange);
cd(outdir);