%% plot the J dot E
% writen by Liangjin Song on 20210318
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Poster';
nx=4000;
ny=2000;
nz=1;
di=40;

tt=15;

qi=0.0013;
n0=384.620087;
vA=0.0125;
norm=n0*vA*vA;

x0=0;
dir=0;

Lx=nx/di;
Ly=ny/di;

xrange=[0,Lx];
yrange=[-Ly/2,Ly/2];
range=[40,60];

cd(indir);
Nic=pic3d_read_data('Nh',tt,nx,ny,nz);
Vic=pic3d_read_data('Vh',tt,nx,ny,nz);
E=pic3d_read_data('E',tt,nx,ny,nz);

JicEx=Nic.*Vic.x.*E.x;
JicEy=Nic.*Vic.y.*E.y;
JicEz=Nic.*Vic.z.*E.z;
JicEx=pic3d_simu_filter2d(JicEx);
JicEy=pic3d_simu_filter2d(JicEy);
JicEz=pic3d_simu_filter2d(JicEz);
JicE=JicEx+JicEy+JicEz;

[ljicex,lx]=get_line_data(JicEx,Lx,Ly,x0,norm,dir);
[ljicey,~]=get_line_data(JicEy,Lx,Ly,x0,norm,dir);
[ljicez,~]=get_line_data(JicEz,Lx,Ly,x0,norm,dir);
[ljice,~]=get_line_data(JicE,Lx,Ly,x0,norm,dir);

%%
figure;
plot(lx,ljicex,'g','LineWidth',1.5); hold on
plot(lx,ljicey,'b','LineWidth',1.5);
plot(lx,ljicez,'r','LineWidth',1.5);
plot(lx,ljice,'k','LineWidth',1.5);
xlabel('X [c/\omega_{pi}]');
ylabel('Jic \cdot E');
legend('Jic_xE_x','Jic_yE_y','Jic_zE_z','Sum');
xlim(range);
title(['\Omega_{ci}t=',num2str(tt)]);
set(gca,'FontSize',14);
cd(outdir);
print('-dpng','-r300',['cold_ions_energy_conversion_t',num2str(tt),'_x-line.png']);