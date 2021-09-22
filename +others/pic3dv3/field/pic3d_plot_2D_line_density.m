% plot the pic3d density line
% writen by Liangjin Song on 20200319
clear;
indir='E:\PIC\Test';
outdir='E:\PIC\Test';

tt=0;

nx=500;
ny=500;
nz=1;

di=20;
Lx=nx/di;
Ly=ny/di;

z0=5;
dir=1;


cd(indir);
ni=pic3d_read_data('Ni',tt,nx,ny,nz);
ne=pic3d_read_data('Ne',tt,nx,ny,nz);

% dens=load('Dens.dat');
% hi=load(['Hi_t',num2str(tt,'%06.2f'),'.bsd']);
% hi=hi/qi;

[lni,lx]=get_line_data(ni,Lx,Ly,z0,1,dir);
[lne,~]=get_line_data(ne,Lx,Ly,z0,1,dir);
% [lhi,~]=get_line_data(hi,Lx,Ly,z0,1,dir);
figure;
plot(lx,lni,'k','LineWidth',1.5); hold on
% plot(lx,dens,'g');
% plot(lx,lhi,'--b');
plot(lx,lne,'--r','LineWidth',1.5); hold off

if dir == 1
    xrange=[-Ly/2,Ly/2];
    xlabel('Z [c/\omega_{pi}]');
    tit='z=';
else
    xrange=[0,Lx];
    xlabel('X [c/\omega_{pi}]');
    tit='x=';
end

xlim(xrange);
legend('Ni','Ne');
set(gca,'Fontsize',14);
title(['Ni-Ne, \omega_{ci}t=',num2str(tt)]);
cd(outdir);
print('-dpng','-r300',['Ni-Ne_',tit,num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);