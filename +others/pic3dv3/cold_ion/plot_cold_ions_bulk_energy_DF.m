%% the bulk kinetic energy at the X-line
% writen by Liangjin Song on 20210320
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie25\data';
outdir='E:\PIC\Cold-Ions\mie25\out\Line\DF';
nx=1200;
ny=800;
nz=1;
di=20;

tt=34;

n0=1481.487305;
vA=0.025;
m=0.269999;
q=0.000337;
wci=0.00125;
norm=0.5*m*n0*vA*vA;

x0=0;
dir=0;

Lx=nx/di;
Ly=ny/di;

xrange=[0,Lx];
yrange=[-Ly/2,Ly/2];
range=[32,42];

%% read data
cd(indir);
B=pic3d_read_data('B',tt,nx,ny,nz);
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
[lbz,lx]=get_line_data(B.z,Lx,Ly,x0,1,dir);
lk=get_line_data(Kic,Lx,Ly,x0,norm,dir);

%% figure
cd(outdir);
%% bulk kinetic energy
f1=figure;
yyaxis left
plot(lx,lk,'-k','LineWidth',1.5);
xlabel('X [c/\omega_{pi}]');
ylabel('Kic');
set(gca,'ycolor','k');
title(['\Omega_{ci}t =',num2str(tt)]);
xlim(range);
yyaxis right
plot(lx,lbz,'-r','LineWidth',1.5);
ylabel('Bz');
set(gca,'ycolor','r');
set(gca,'FontSize',14);
print(f1,'-dpng','-r300',['Kic_t',num2str(tt,'%06.2f'),'.png']);

%% bulk kinetic energy density conservation equation
%% qnV dot E
je=q*Nic.*(Vic.x.*E.x+Vic.y.*E.y+Vic.z.*E.z);

%% - (nabla dot P) dot V
[dp.x,dp.y,dp.z]=calc_divergence_pressure(Pic.xx,Pic.xy,Pic.xz,Pic.yy,Pic.yz,Pic.zz,1);
pv=-(dp.x.*Vic.x+dp.y.*Vic.y+dp.z.*Vic.z);

%% - nabla dot (KV)
kv=-calc_divergence(Kic.*Vic.x,Kic.*Vic.y,Kic.*Vic.z,1);

%% partial(K/t)
kt=0.5*m*nNic.*(nVic.x.^2+nVic.y.^2+nVic.z.^2)-0.5*m*pNic.*(pVic.x.^2+pVic.y.^2+pVic.z.^2);
kt=kt*wci/2;

%% get line
lkt=get_line_data(kt,Lx,Ly,x0,norm*wci,dir);
lkv=get_line_data(kv,Lx,Ly,x0,norm*wci,dir);
lpv=get_line_data(pv,Lx,Ly,x0,norm*wci,dir);
lje=get_line_data(je,Lx,Ly,x0,norm*wci,dir);
sum=lkv+lpv+lje;

%% figue
f2=figure;
yyaxis left
plot(lx,lkt,'--k','LineWidth',1.5); hold on
plot(lx,lkv,'-m','LineWidth',1.5);
plot(lx,lpv,'-g','LineWidth',1.5);
plot(lx,lje,'-b','LineWidth',1.5);
plot(lx,sum,'-k','LineWidth',1.5); hold off
xlim(range);
set(gca,'ycolor','k');
xlabel('X [c/\omega_{pi}]');
title(['\Omega_{ci}t =',num2str(tt)]);

yyaxis right
plot(lx,lbz,'-r','LineWidth',1.5);
ylabel('Bz');
set(gca,'ycolor','r');
set(gca,'FontSize',14);
legend('\partial Kic/\partial t','-\nabla \cdot (KicVic)','-(\nabla \cdot Pic)\cdot Vic','qicNicVic\cdot E','Sum','Bz');
print(f2,'-dpng','-r300',['cold_ions_bulk_kinetic_conversion_equation_t',num2str(tt,'%06.2f'),'.png']);