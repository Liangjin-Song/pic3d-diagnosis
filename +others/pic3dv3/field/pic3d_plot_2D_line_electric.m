%% plot the plasma density line
% writen by Liangjin Song on 20210318
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Line\DF';
nx=4000;
ny=2000;
nz=1;
di=40;

vA=0.0125;

tt=45;
x0=0;
dir=0;

%% 
Lx=nx/di;
Ly=ny/di;
xrange=[0,Lx];
yrange=[-Ly/2,Ly/2];

%% read data
cd(indir);
E=pic3d_read_data('E',tt,nx,ny,nz);
% E.x=pic3d_simu_filter2d(E.x);
% E.y=pic3d_simu_filter2d(E.y);
% E.z=pic3d_simu_filter2d(E.z);
[e.x,lx]=get_line_data(E.x,Lx,Ly,x0,vA,dir);
[e.y,~]=get_line_data(E.y,Lx,Ly,x0,vA,dir);
[e.z,~]=get_line_data(E.z,Lx,Ly,x0,vA,dir);
plot(lx,lex,'r','LineWidth',1); hold on
plot(lx,ley,'b','LineWidth',1); hold on
% plot(lx,lez,'k','LineWidth',1); hold off
xlim([20,40]);
% ylim([-0.4,0.4]);
title(['\Omega_{ci}t = ',num2str(tt)])
xlabel('Z [c/\omega_{pi}]');
ylabel('Electric Field');
legend('Ex','Ey');
% legend('Ex','Ey','Ez');
set(gca,'FontSize',14);
cd(outdir);
print('-dpng','-r300','electric_field_t030.00_z.png');