%% the bulk kinetic energy at the X-line
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

x0=50;
dir=1;

Lx=nx/di;
Ly=ny/di;

xrange=[0,Lx];
yrange=[-Ly/2,Ly/2];

%% read data
cd(indir);
Nic=pic3d_read_data('Nh',tt,nx,ny,nz);
Vic=pic3d_read_data('Vh',tt,nx,ny,nz);
E=pic3d_read_data('E',tt,nx,ny,nz);
Pic=pic3d_read_data('Ph',tt,nx,ny,nz);
% previous and next
pNic=pic3d_read_data('Nh',tt-1,nx,ny,nz);
pVic=pic3d_read_data('Vh',tt-1,nx,ny,nz);
nNic=pic3d_read_data('Nh',tt+1,nx,ny,nz);
nVic=pic3d_read_data('Vh',tt+1,nx,ny,nz);

%% calculation
% bulk kinetic energy
Kic=0.5*m*Nic.*(Vic.x.^2+Vic.y.^2+Vic.z.^2);

%% get the line
[lk,lx]=get_line_data(Kic,Lx,Ly,x0,norm,dir);

%% figure
cd(outdir);
%% bulk kinetic energy
f1=figure;
plot(lx,lk,'-k','LineWidth',1.5);
xlabel('Z [c/\omega_{pi}]');
ylabel('Kic');
title(['\Omega_{ci}t =',num2str(tt)]);
xlim([-10,10]);
set(gca,'FontSize',14);
print(f1,'-dpng','-r300',['Kic_t',num2str(tt,'%06.2f'),'.png']);

%% bulk kinetic energy density conservation equation
%% qnV dot E
je=q*Nic.*(Vic.x.*E.x+Vic.y.*E.y+Vic.z.*E.z);
je=pic3d_simu_filter2d(je);

%% - (nabla dot P) dot V
[dp.x,dp.y,dp.z]=calc_divergence_pressure(Pic.xx,Pic.xy,Pic.xz,Pic.yy,Pic.yz,Pic.zz,1);
pv=-(dp.x.*Vic.x+dp.y.*Vic.y+dp.z.*Vic.z);
pv=pic3d_simu_filter2d(pv);

%% - nabla dot (KV)
kv=-calc_divergence(Kic.*Vic.x,Kic.*Vic.y,Kic.*Vic.z,1);
kv=pic3d_simu_filter2d(kv);

%% partial(K/t)
kt=0.5*m*nNic.*(nVic.x.^2+nVic.y.^2+nVic.z.^2)-0.5*m*pNic.*(pVic.x.^2+pVic.y.^2+pVic.z.^2);
kt=kt*wci/2;
kt=pic3d_simu_filter2d(kt);

%% get line
% lkt=get_line_data(kt,Lx,Ly,x0,norm*wci,dir);
% lkv=get_line_data(kv,Lx,Ly,x0,norm*wci,dir);
% lpv=get_line_data(pv,Lx,Ly,x0,norm*wci,dir);
% lje=get_line_data(je,Lx,Ly,x0,norm*wci,dir);
% sum=lkv+lpv+lje;
rxm=1990:2010;
norm=norm*wci;
lkt=mean(kt(:,rxm)/norm,2);
lkv=mean(kv(:,rxm)/norm,2);
lpv=mean(pv(:,rxm)/norm,2);
lje=mean(je(:,rxm)/norm,2);
sum=lkv+lpv+lje;

%% figue
f2=figure;
plot(lx,lkt,'--k','LineWidth',1.5); hold on
plot(lx,lkv,'-r','LineWidth',1.5);
plot(lx,lpv,'-g','LineWidth',1.5);
plot(lx,lje,'-b','LineWidth',1.5);
plot(lx,sum,'-k','LineWidth',1.5); hold off
xlim([-3,3]);
legend('\partial Kic/\partial t','-\nabla \cdot (KicVic)','-(\nabla \cdot Pic)\cdot Vic','qicNicVic\cdot E','Sum');
xlabel('Z [c/\omega_{pi}]');
title(['\Omega_{ci}t =',num2str(tt)]);
set(gca,'FontSize',14);
print(f2,'-dpng','-r300',['cold_ions_bulk_kinetic_conversion_equation_t',num2str(tt,'%06.2f'),'.png']);