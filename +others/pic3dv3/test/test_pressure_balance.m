%% diagnosing the electron current sheet
clear;
% writen by Liangjin Song on 20210326
indir='E:\Simulation\rec2d_M100SBg00Sx\data';
outdir='E:\Simulation\rec2d_M100SBg00Sx';
nx=4800;
ny=2400;
nz=1;
di=40;

tt=0;

z0=12.5;
dir=1;

Lx=nx/di;
Ly=ny/di;

coeff=1;
c=0.6;
xrange=[-Ly/2,Ly/2];


%% read data
cd(indir);
% B=pic3d_read_data('B',tt,nx,ny,nz);
% Pe=pic3d_read_data('Pe',tt,nx,ny,nz);
% Pi=pic3d_read_data('Pl',tt,nx,ny,nz);
cd(indir);
B.x=importdata(['Bx_t',num2str(tt,'%06.2f'),'.mat']);
B.y=importdata(['By_t',num2str(tt,'%06.2f'),'.mat']);
B.z=importdata(['Bz_t',num2str(tt,'%06.2f'),'.mat']);
Pi0=importdata(['presi_t',num2str(tt,'%06.2f'),'.mat']);
Pe0=importdata(['prese_t',num2str(tt,'%06.2f'),'.mat']);
[Pi.xx,Pi.xy,Pi.xz,Pi.yy,Pi.yz,Pi.zz]=reshap_pressure(Pi0,ny,nx);
[Pe.xx,Pe.xy,Pe.xz,Pe.yy,Pe.yz,Pe.zz]=reshap_pressure(Pe0,ny,nx);

%% pressure
Pb=(B.x.^2+B.y.^2+B.z.^2)*c*c*0.5;
Pe=(Pe.xx+Pe.yy+Pe.zz)/3;
Pi=(Pi.xx+Pi.yy+Pi.zz)/3;

%% get line
[lbx,lx]=get_line_data(B.x,Lx,Ly,z0,1,dir);
[lpb,~]=get_line_data(Pb,Lx,Ly,z0,1,dir);
[lpe,~]=get_line_data(Pe,Lx,Ly,z0,1,dir);
[lpi,~]=get_line_data(Pi,Lx,Ly,z0,1,dir);
lptot=lpb+lpe+lpi;

%% figure
f6=figure;
plot(lx,lptot,'-k','LineWidth',1.5); hold on
plot(lx,lpe,'-r','LineWidth',1.5);
plot(lx,lpi,'-g','LineWidth',1.5);
plot(lx,lpb,'-b','LineWidth',1.5); hold off
xlabel('Z [c/\omega_{pi}]');
ylabel('Pressure');
legend('Sum','Pe','Pi','Pb');
xlim(xrange);