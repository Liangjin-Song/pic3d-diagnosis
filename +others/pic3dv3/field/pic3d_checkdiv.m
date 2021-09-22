%% check divergence of magnetic field and electric field
%% parameter
indir='E:\PIC\Cold-Ions\data';
outdir='E:\PIC\Cold-Ions\out';
nx=1200;
ny=800;
nz=1;
di=20;

tt=20;

Lx=nx/di;
Ly=ny/di;

z0=15;
dir=1;

xrange=[-Ly/2+1,Ly/2-1];
% xrange=[0,Lx];x

cd(indir);
dive=pic3d_read_data('divE',tt,nx,ny,nz);
divb=pic3d_read_data('divB',tt,nx,ny,nz);

[le,lx]=get_line_data(dive,Lx,Ly,z0,1,dir);
[lb,~]=get_line_data(divb,Lx,Ly,z0,1,dir);

h1=figure;
plot(lx,le,'k','LineWidth',2);
xlim(xrange);
xlabel('Z [c/\omega_{pi}]');
title(['(\nabla \cdot E-q_iN_i-q_eN_e), \omega_{ci}t=',num2str(tt)]);

h2=figure;
plot(lx,lb,'k','LineWidth',2);
xlim(xrange);
xlabel('Z [c/\omega_{pi}]');
title(['\nabla \cdot B, \omega_{ci}t=',num2str(tt)]);

cd(outdir)
print(h1,'-dpng','-r300',['dive_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);
print(h2,'-dpng','-r300',['divb_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);