% test the Ampere's law of the pic simulation
% writen by Liangjin Song on
clear;
indir='E:\PIC\Asym\data';
outdir='E:\PIC\Asym\out';

tt=0;

nx=2000;
ny=1200;
nz=1;

ql=0.003747;
qh=ql;
qe=-ql;

di=20;
Lx=nx/di;
Ly=ny/di;

z0=5;
dir=1;

xrange=[-Ly/2,Ly/2];
% xrange=[0,Lx];

c=0.5;

c2=c^2;
% hc2=c2/qi;

% norm=qi*n0*vA;
norm=1;
cd(indir);

% current in the simulation
J=pic3d_read_data('J',tt,nx,ny,nz);


% magnetic field
b=pic3d_read_data('B',tt,nx,ny,nz);
bx=b.x;
by=b.y;
bz=b.z;

jcx=zeros(ny,nx);
jcy=zeros(ny,nx);
jcz=zeros(ny,nx);
% the curl of the magnetic field
for j=2:ny
    for i=1:nx
        if i==1&&j==1
            jcx(j,i)=by(ny,i)-by(j,i);
            jcy(j,i)=bx(j,i)-bx(ny,i)+bz(j,nx)-bz(j,i);
            jcz(j,i)=by(j,i)-by(j,nx);
        elseif i==1
            jcy(j,i)=bx(j,i)-bx(j-1,i)+bz(j,nx)-bz(j,i);
            jcz(j,i)=by(j,i)-by(j,nx);
        elseif j==1
            jcx(j,i)=by(ny,i)-by(j,i);
            jcy(j,i)=bx(j,i)-bx(ny,i)+bz(j,i-1)-bz(j,i);
        else
            jcx(j,i)=by(j-1,i)-by(j,i);
            jcy(j,i)=bx(j,i)-bx(j-1,i)+bz(j,i-1)-bz(j,i);
            jcz(j,i)=by(j,i)-by(j,i-1);
        end
    end
end

jcx=jcx*c2;
jcy=jcy*c2;
jcz=jcz*c2;

% current calculated by plasma
vshi=pic3d_read_data('Vshi',tt,nx,ny,nz);
vshe=pic3d_read_data('Vshe',tt,nx,ny,nz);
vspi=pic3d_read_data('Vspi',tt,nx,ny,nz);
vspe=pic3d_read_data('Vspe',tt,nx,ny,nz);
vsph=pic3d_read_data('Vsph',tt,nx,ny,nz);
vsphe=pic3d_read_data('Vsphe',tt,nx,ny,nz);
nshi=pic3d_read_data('Nshi',tt,nx,ny,nz);
nshe=pic3d_read_data('Nshe',tt,nx,ny,nz);
nspi=pic3d_read_data('Nspi',tt,nx,ny,nz);
nspe=pic3d_read_data('Nspe',tt,nx,ny,nz);
nsph=pic3d_read_data('Nsph',tt,nx,ny,nz);
nsphe=pic3d_read_data('Nsphe',tt,nx,ny,nz);

jshix=ql*vshi.x.*nshi;
jshiy=ql*vshi.y.*nshi;
jshiz=ql*vshi.z.*nshi;

jshex=qe*vshe.x.*nshe;
jshey=qe*vshe.y.*nshe;
jshez=qe*vshe.z.*nshe;

jspix=ql*vspi.x.*nspi;
jspiy=ql*vspi.y.*nspi;
jspiz=ql*vspi.z.*nspi;

jspex=qe*vspe.x.*nspe;
jspey=qe*vspe.y.*nspe;
jspez=qe*vspe.z.*nspe;

jsphx=qh*vsph.x.*nsph;
jsphy=qh*vsph.y.*nsph;
jsphz=qh*vsph.z.*nsph;

jsphex=qe*vsphe.x.*nsphe;
jsphey=qe*vsphe.y.*nsphe;
jsphez=qe*vsphe.z.*nsphe;

jpx=jshix+jshex+jspix+jspex+jsphx+jsphex;
jpy=jshiy+jshey+jspiy+jspey+jsphy+jsphey;
jpz=jshiz+jshez+jspiz+jspez+jsphz+jsphez;

%%
[ljx,lx]=get_line_data(J.x,Lx,Ly,z0,norm,dir);
[ljy,~]=get_line_data(J.y,Lx,Ly,z0,norm,dir);
[ljz,~]=get_line_data(J.z,Lx,Ly,z0,norm,dir);

[ljcx,~]=get_line_data(jcx,Lx,Ly,z0,norm,dir);
[ljcy,~]=get_line_data(jcy,Lx,Ly,z0,norm,dir);
[ljcz,~]=get_line_data(jcz,Lx,Ly,z0,norm,dir);

[ljpx,~]=get_line_data(jpx,Lx,Ly,z0,norm,dir);
[ljpy,~]=get_line_data(jpy,Lx,Ly,z0,norm,dir);
[ljpz,~]=get_line_data(jpz,Lx,Ly,z0,norm,dir);

[ljshiy,~]=get_line_data(jshiy,Lx,Ly,z0,norm,dir);
[ljshey,~]=get_line_data(jshey,Lx,Ly,z0,norm,dir);

[ljspiy,~]=get_line_data(jspiy,Lx,Ly,z0,norm,dir);
[ljspey,~]=get_line_data(jspey,Lx,Ly,z0,norm,dir);

[ljsphy,~]=get_line_data(jsphy,Lx,Ly,z0,norm,dir);
[ljsphey,~]=get_line_data(jsphey,Lx,Ly,z0,norm,dir);


f1=figure;
plot(lx,ljx,'r','LineWidth',1.5); hold on
plot(lx,ljcx,'--k','LineWidth',1.5); hold on
plot(lx,ljpx,':b','LineWidth',1.5); hold on
xlim(xrange);
xlabel('Z [c/\omega_{pi}]');
ylabel('Jx');
legend('Js','Jc','Jp');
title(['Current Density, \omega_{ci}t=',num2str(tt)]);
set(gca,'Fontsize',14);

f2=figure;
plot(lx,ljy,'r','LineWidth',1.5); hold on
plot(lx,ljcy,'--k','LineWidth',1.5); hold on
plot(lx,ljpy,':b','LineWidth',1.5); hold on
xlim(xrange);
xlabel('Z [c/\omega_{pi}]');
ylabel('Jy');
legend('Js','Jc','Jp');
title(['Current Density, \omega_{ci}t=',num2str(tt)]);
set(gca,'Fontsize',14);

f3=figure;
plot(lx,ljz,'r','LineWidth',1.5); hold on
plot(lx,ljcz,'--k','LineWidth',1.5); hold on
plot(lx,ljpz,':b','LineWidth',1.5); hold on
xlim(xrange);
xlabel('Z [c/\omega_{pi}]');
ylabel('Jz');
legend('Js','Jc','Jp');
title(['Current Density, \omega_{ci}t=',num2str(tt)]);
set(gca,'Fontsize',14);

f4=figure;
plot(lx, ljshiy, '-k', 'LineWidth', 2); hold on
plot(lx, ljshey, '-r', 'LineWidth', 2);
plot(lx, ljspiy, '-g', 'LineWidth', 2);
plot(lx, ljspey, '-b', 'LineWidth', 2);
plot(lx, ljsphy, '-m', 'LineWidth', 2);
plot(lx, ljsphey, '-y', 'LineWidth', 2); hold off
xlim(xrange);
xlabel('Z [c/\omega_{pi}]');
ylabel('Jy');
legend('J_{shi}','J_{she}','J_{spi}','J_{spe}','J_{spic}','J_{spice}');
title(['Current Density, \omega_{ci}t=',num2str(tt)]);
set(gca,'Fontsize',16);

cd(outdir)
print(f1,'-dpng','-r300',['Jx_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);
print(f2,'-dpng','-r300',['Jy_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);
print(f3,'-dpng','-r300',['Jz_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);
print(f4,'-dpng','-r300',['Jp_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);