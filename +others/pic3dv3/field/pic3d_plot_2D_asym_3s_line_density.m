% plot the pic3d density line
% writen by Liangjin Song on 20200319
clear;
indir='E:\PIC\Asym\data';
outdir='E:\PIC\Asym\out';

tt=0;

nx=2000;
ny=1200;
nz=1;

n0=100.083466;

di=20;
Lx=nx/di;
Ly=ny/di;

qhl=1;

z0=5;
dir=1;


cd(indir);
nshi=pic3d_read_data('Nshi',tt,nx,ny,nz);
nshe=pic3d_read_data('Nshe',tt,nx,ny,nz);
nspi=pic3d_read_data('Nspi',tt,nx,ny,nz);
nspe=pic3d_read_data('Nspe',tt,nx,ny,nz);
nsph=pic3d_read_data('Nsph',tt,nx,ny,nz);
nsphe=pic3d_read_data('Nsphe',tt,nx,ny,nz);

% dens=load('Dens.dat');
% hi=load(['Hi_t',num2str(tt,'%06.2f'),'.bsd']);
% hi=hi/qi;

[lnshi,lx]=get_line_data(nshi,Lx,Ly,z0,n0,dir);
[lnshe,~]=get_line_data(nshe,Lx,Ly,z0,n0,dir);
[lnspi,~]=get_line_data(nspi,Lx,Ly,z0,n0,dir);
[lnspe,~]=get_line_data(nspe,Lx,Ly,z0,n0,dir);
[lnsph,~]=get_line_data(nsph,Lx,Ly,z0,n0,dir);
[lnsphe,~]=get_line_data(nsphe,Lx,Ly,z0,n0,dir);
lnti=lnshi+lnspi+lnsph*qhl;
lnte=lnshe+lnspe+lnsphe;
figure;
plot(lx,lnshi,'-r','LineWidth',1.5); hold on
plot(lx,lnspi,'-g','LineWidth',1.5);
plot(lx,lnsph,'-b','LineWidth',1.5);
plot(lx,lnshe,'--r','LineWidth',1.5);
plot(lx,lnspe,'--g','LineWidth',1.5);
plot(lx,lnsphe,'--b','LineWidth',1.5);
plot(lx,lnti,'k','LineWidth',1.5);
plot(lx,lnte,'--m','LineWidth',1.5);

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
legend('shi','spi','spic','she','spe','sphe','Ni','Ne');
set(gca,'Fontsize',14);
title(['Ni-Ne, \omega_{ci}t=',num2str(tt)]);
cd(outdir);
print('-dpng','-r300',['Nh-Nl-Ne_',tit,num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);