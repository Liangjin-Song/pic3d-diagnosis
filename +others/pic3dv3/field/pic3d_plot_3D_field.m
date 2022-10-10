%% writen by Liangjin Song on 20201130
% plot the three-dimensional field
clear;

%% parameters
indir='E:\PIC\Three-Dimensional\3d\data';
outdir='E:\PIC\Three-Dimensional\3d\out';

nx=1000;
ny=400;
nz=100;

di=20;
Lx=nx/di;
Ly=ny/di;
Lz=nz/di;

name='divE';
tt=20;

%% plot
cd(indir);
data=pic3d_read_data(name,tt,nx,ny,nz);

xx=0:Lx/nx:Lx-Lx/nx;
yy=-Ly/2:Ly/ny:Ly/2-Ly/ny;
zz=0:Lz/nz:Lz-Lz/nz;

[XX, YY, ZZ]=meshgrid(xx,yy,zz);

sx=[5,25,45];
sy=[];
sz=[1,4];
% sz=[];

slice(XX,YY,ZZ,data,sx,sy,sz,'linear');
colorbar;shading flat;
xlabel('X [c/\omega_{pi}]');
ylabel('Y [c/\omega_{pi}]');
zlabel('Z [c/\omega_{pi}]');
xlim([0,Lx]);
ylim([-Ly/2+1;Ly/2-1]);
zlim([0,Lz]);
title(['\nabla \cdot B   \Omega_{ci}t=',num2str(tt)]);
set(gca,'FontSize',14);

cd(outdir);