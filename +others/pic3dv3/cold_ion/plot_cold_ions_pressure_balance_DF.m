%% the pressure ahead of the DF
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
Lx=nx/di;
Ly=ny/di;

tt=30;

c=0.5;

x0=22;
dir=1;

%% read data
cd(indir);
B=pic3d_read_data('B',tt,nx,ny,nz);
Pi=pic3d_read_data('Pl',tt,nx,ny,nz);
Pic=pic3d_read_data('Ph',tt,nx,ny,nz);
Pe=pic3d_read_data('Pe',tt,nx,ny,nz);
Pice=pic3d_read_data('Phe',tt,nx,ny,nz);

%% calculation
% magnetic pressure
Pb=c*c*(B.x.^2+B.y.^2+B.z.^2)/2;

%% get line
[lpb,lx]=get_line_data(Pb,Lx,Ly,x0,1,dir);
lpi=get_line_data((Pi.xx+Pi.yy+Pi.zz)/3,Lx,Ly,x0,1,dir);
lpe=get_line_data((Pe.xx+Pe.yy+Pe.zz)/3,Lx,Ly,x0,1,dir);
lpic=get_line_data((Pic.xx+Pic.yy+Pic.zz)/3,Lx,Ly,x0,1,dir);
lpice=get_line_data((Pice.xx+Pice.yy+Pice.zz)/3,Lx,Ly,x0,1,dir);
sum=lpb+lpi+lpe+lpic+lpice;

%% figure
cd(outdir);
f1=figure;
plot(lx,lpb,'-r','LineWidth',1.5); hold on
plot(lx,lpi,'-b','LineWidth',1.5);
plot(lx,lpe,'--b','LineWidth',1.5);
plot(lx,lpic,'-m','LineWidth',1.5);
plot(lx,lpice,'--r','LineWidth',1.5);
plot(lx,sum,'-k','LineWidth',1.5); hold off
legend('Pb','Pi','Pe','Pic','Pice','Sum');
xlim([-6,6]);
xlabel('Z [c/\omega_{pi}]');
ylabel('pressure');
set(gca,'FontSize',14);
print(f1,'-dpng','-r300',['pressure_balance_t',num2str(tt,'%06.2f'),'.png']);