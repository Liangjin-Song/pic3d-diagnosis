%% plot the velocity vector of cold ions
clear;
%% writen by Liangjin Song on 20210411
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out';
cd(indir);

nx=4000;
ny=2000;
nz=1;
di=40;

norm=384.620087*0.0125*0.0125;
norm=0.0125;
Lx=nx/di;
Ly=ny/di;
xrange=[35,50];
yrange=[-5,5];
% cxs=[-5,5];

%% read data
tt=32;
Vic=pic3d_read_data('Vh',tt,nx,ny,nz);
Nic=pic3d_read_data('Nh',tt,nx,ny,nz);
E=pic3d_read_data('E',tt,nx,ny,nz);
ss=pic3d_read_data('stream',tt,nx,ny,nz);

%% calculation
Jic.x=Vic.x.*Nic;
Jic.y=Vic.y.*Nic;
Jic.z=Vic.z.*Nic;
JicE=Jic.x.*E.x+Jic.y.*E.y+Jic.z.*E.z;

%% figure
f=figure;
plot_overview(E.y,ss,norm,Lx,Ly);
hold on
plot_vector(Vic.x,Vic.z,Lx,Ly,50,3,'r');
% caxis(cxs);
xlim(xrange);
ylim(yrange);
title(['E_y, \Omega_{ci}t=',num2str(tt)]);
set(gca,'FontSize',16);
%% save
cd(outdir)
print('-dpng','-r300',['Ey_Vic_vector_t',num2str(tt,'%06.2f'),'.png']);