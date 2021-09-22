%% the thermal energy density conversation equation
% writen by Liangjin Song on 20210320
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Line\Xline';
nx=4000;
ny=2000;
nz=1;
di=40;

tt=16;

n0=384.620087;
vA=0.0125;
m=4.159949;
q=0.0013;
wci=0.000312;
norm=0.5*m*n0*vA*vA;

Lx=nx/di;
Ly=ny/di;

x0=50;
dir=1;

xrange=[0,Lx];
yrange=[-Ly/2,Ly/2];

%% read data
cd(indir);
Pic=pic3d_read_data('Ph',tt,nx,ny,nz);
qic=pic3d_read_data('qfluxh',tt,nx,ny,nz);
Vic=pic3d_read_data('Vh',tt,nx,ny,nz);
% previous and next
pPic=pic3d_read_data('Ph',tt-1,nx,ny,nz);
nPic=pic3d_read_data('Ph',tt+1,nx,ny,nz);

%% calculation
[U,enp,htf,thp]=calc_partial_U_t(Pic.xx,Pic.xy,Pic.xz,Pic.yy,Pic.yz,Pic.zz,qic.x,qic.y,qic.z,Vic.x,Vic.y,Vic.z,1);
ut=0.5*wci*(nPic.xx+nPic.yy+nPic.zz-pPic.xx-pPic.yy-pPic.zz)/2;
enp=pic3d_simu_filter2d(enp);
htf=pic3d_simu_filter2d(htf);
thp=pic3d_simu_filter2d(thp);
ut=pic3d_simu_filter2d(ut);

%% get line
[lu,lx]=get_line_data(U,Lx,Ly,x0,norm,dir);
% lut=get_line_data(ut,Lx,Ly,x0,norm*wci,dir);
% lenp=get_line_data(enp,Lx,Ly,x0,norm*wci,dir);
% lhtf=get_line_data(htf,Lx,Ly,x0,norm*wci,dir);
% lthp=get_line_data(thp,Lx,Ly,x0,norm*wci,dir);
rxm=1980:2020;
norm=norm*wci;
lenp=mean(enp(:,rxm)/norm,2);
lhtf=mean(htf(:,rxm)/norm,2);
lthp=mean(thp(:,rxm)/norm,2);
lut=mean(ut(:,rxm)/norm,2);
sum=lenp+lhtf+lthp;

%% figure
cd(outdir);
f1=figure;
plot(lx,lu,'-k','LineWidth',1.5);
xlabel('Z [c/\omega_{pi}]');
ylabel('Uic');
title(['\Omega_{ci}t =',num2str(tt)]);
xlim([-5,5]);
set(gca,'FontSize',14);
print(f1,'-dpng','-r300',['Uic_t',num2str(tt,'%06.2f'),'.png']);

f2=figure;
plot(lx,lut,'--k','LineWidth',1.5); hold on
plot(lx,lenp,'-r','LineWidth',1.5);
plot(lx,lhtf,'-g','LineWidth',1.5);
plot(lx,lthp,'-b','LineWidth',1.5);
plot(lx,sum,'-k','LineWidth',1.5); hold off
legend('\partial Uic/\partial t','-\nabla \cdot H','-\nabla \cdot Q','(\nabla \cdot Pic) \cdot Vic','Sum');
xlim([-1,1]);
xlabel('Z [c/\omega_{pi}]');
title(['\Omega_{ci}t =',num2str(tt)]);
set(gca,'FontSize',14);
print(f2,'-dpng','-r300',['cold_ions_thermal_energy_conversion_equation_t',num2str(tt,'%06.2f'),'.png']);