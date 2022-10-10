%% the thermal energy density conversation equation
% writen by Liangjin Song on 20210320
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie25\data';
outdir='E:\PIC\Cold-Ions\mie25\out\Line\FR';
nx=1200;
ny=800;
nz=1;
di=20;

tt=47;

n0=1481.487305;
vA=0.025;
m=0.269999;
q=0.000337;
wci=0.00125;
norm=0.5*m*n0*vA*vA;

Lx=nx/di;
Ly=ny/di;

x0=0;
dir=0;

xrange=[0,Lx];
yrange=[-Ly/2,Ly/2];
range=[24,32];

%% read data
cd(indir);
B=pic3d_read_data('B',tt,nx,ny,nz);
Pic=pic3d_read_data('Ph',tt,nx,ny,nz);
qic=pic3d_read_data('qfluxh',tt,nx,ny,nz);
Vic=pic3d_read_data('Vh',tt,nx,ny,nz);
% previous and next
pPic=pic3d_read_data('Ph',tt-1,nx,ny,nz);
nPic=pic3d_read_data('Ph',tt+1,nx,ny,nz);

%% calculation
[U,enp,htf,thp]=calc_partial_U_t(Pic.xx,Pic.xy,Pic.xz,Pic.yy,Pic.yz,Pic.zz,qic.x,qic.y,qic.z,Vic.x,Vic.y,Vic.z,1);
ut=0.5*wci*(nPic.xx+nPic.yy+nPic.zz-pPic.xx-pPic.yy-pPic.zz)/2;

%% get line
[lbz,lx]=get_line_data(B.z,Lx,Ly,x0,1,dir);
lu=get_line_data(U,Lx,Ly,x0,norm,dir);
lut=get_line_data(ut,Lx,Ly,x0,norm*wci,dir);
lenp=get_line_data(enp,Lx,Ly,x0,norm*wci,dir);
lhtf=get_line_data(htf,Lx,Ly,x0,norm*wci,dir);
lthp=get_line_data(thp,Lx,Ly,x0,norm*wci,dir);
sum=lenp+lhtf+lthp;

%% figure
cd(outdir);
f1=figure;
yyaxis left
plot(lx,lu,'-k','LineWidth',1.5);
xlabel('X [c/\omega_{pi}]');
ylabel('Uic');
title(['\Omega_{ci}t =',num2str(tt)]);
set(gca,'ycolor','k');

yyaxis right
plot(lx,lbz,'-r','LineWidth',1.5);
ylabel('Bz');
set(gca,'ycolor','r');
xlim(range);
set(gca,'FontSize',14);
print(f1,'-dpng','-r300',['Uic_t',num2str(tt,'%06.2f'),'.png']);

f2=figure;
yyaxis left
plot(lx,lut,'--k','LineWidth',1.5); hold on
plot(lx,lenp,'-m','LineWidth',1.5);
plot(lx,lhtf,'-g','LineWidth',1.5);
plot(lx,lthp,'-b','LineWidth',1.5);
plot(lx,sum,'-k','LineWidth',1.5); hold off
set(gca,'ycolor','k');

yyaxis right
plot(lx,lbz,'-r','LineWidth',1.5);
ylabel('Bz');
set(gca,'ycolor','r');
xlim(range);

legend('\partial Uic/\partial t','-\nabla \cdot H','-\nabla \cdot Q','(\nabla \cdot Pic) \cdot Vic','Sum','Bz');
xlabel('X [c/\omega_{pi}]');
title(['\Omega_{ci}t =',num2str(tt)]);
set(gca,'FontSize',14);
print(f2,'-dpng','-r300',['cold_ions_thermal_energy_conversion_equation_t',num2str(tt,'%06.2f'),'.png']);