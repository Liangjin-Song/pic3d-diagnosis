% plot the pic3d density line
% writen by Liangjin Song on 20200319
clear;
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Line\Check';

tt=0;

nx=4000;
ny=2000;
nz=1;

n0=1;

di=40;
Lx=nx/di;
Ly=ny/di;

qhl=1;

z0=50;
dir=1;


cd(indir);
nl=pic3d_read_data('Nl',tt,nx,ny,nz);
nh=pic3d_read_data('Nh',tt,nx,ny,nz);
ne=pic3d_read_data('Ne',tt,nx,ny,nz);
nhe=pic3d_read_data('Nhe',tt,nx,ny,nz);

% dens=load('Dens.dat');
% hi=load(['Hi_t',num2str(tt,'%06.2f'),'.bsd']);
% hi=hi/qi;

[lne,lx]=get_line_data(ne,Lx,Ly,z0,n0,dir);
[lnl,~]=get_line_data(nl,Lx,Ly,z0,n0,dir);
[lnh,~]=get_line_data(nh,Lx,Ly,z0,n0,dir);
[lnhe,~]=get_line_data(nhe,Lx,Ly,z0,n0,dir);
lnti=lnl+lnh*qhl;
lnte=lne+lnhe;
figure;
plot(lx,lne,'r','LineWidth',1.5); hold on
plot(lx,lnl,'--g','LineWidth',1.5);
plot(lx,lnh,'b','LineWidth',1.5);
plot(lx,lnhe,'--m','LineWidth',1.5);
plot(lx,lnti,'k','LineWidth',1.5); hold on
plot(lx,lnte,'--y','LineWidth',1.5); hold off

if dir == 1
    xrange=[-Ly/2,Ly/2];
    % xrange=[-8,8];
    xlabel('Z [c/\omega_{pi}]');
    tit='z=';
else
    xrange=[0,Lx];
    xlabel('Y [c/\omega_{pi}]');
    tit='x=';
end

xlim(xrange);
legend('Ne','Ni','Nic','Nice','Ne+Nice','Ni+Nic');
set(gca,'Fontsize',14);
title(['Ni-Ne, \omega_{ci}t=',num2str(tt)]);
cd(outdir);
print('-dpng','-r300',['Nh-Nl-Ne_',tit,num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);