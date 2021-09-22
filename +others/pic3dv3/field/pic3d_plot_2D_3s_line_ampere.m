% test the Ampere's law of the pic simulation
% writen by Liangjin Song on
clear;
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Line\Check';

tt=0;

nx=4000;
ny=2000;
nz=1;

ql=0.0013;
qh=ql;
qe=-ql;

di=40;
Lx=nx/di;
Ly=ny/di;

z0=50;
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
vh=pic3d_read_data('Vh',tt,nx,ny,nz);
vl=pic3d_read_data('Vl',tt,nx,ny,nz);
ve=pic3d_read_data('Ve',tt,nx,ny,nz);
vhe=pic3d_read_data('Vhe',tt,nx,ny,nz);
nh=pic3d_read_data('Nh',tt,nx,ny,nz);
nl=pic3d_read_data('Nl',tt,nx,ny,nz);
ne=pic3d_read_data('Ne',tt,nx,ny,nz);
nhe=pic3d_read_data('Nhe',tt,nx,ny,nz);

jhx=qh*vh.x.*nh;
jhy=qh*vh.y.*nh;
jhz=qh*vh.z.*nh;

jhex=qe*vhe.x.*nhe;
jhey=qe*vhe.y.*nhe;
jhez=qe*vhe.z.*nhe;

jlx=ql*vl.x.*nl;
jly=ql*vl.y.*nl;
jlz=ql*vl.z.*nl;

jex=qe*ve.x.*ne;
jey=qe*ve.y.*ne;
jez=qe*ve.z.*ne;


jpx=jex+jlx+jhx+jhex;
jpy=jey+jly+jhy+jhey;
jpz=jez+jlz+jhz+jhez;



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

[ljex,~]=get_line_data(jex,Lx,Ly,z0,norm,dir);
[ljey,~]=get_line_data(jey,Lx,Ly,z0,norm,dir);
[ljez,~]=get_line_data(jez,Lx,Ly,z0,norm,dir);

[ljlx,~]=get_line_data(jlx,Lx,Ly,z0,norm,dir);
[ljly,~]=get_line_data(jly,Lx,Ly,z0,norm,dir);
[ljlz,~]=get_line_data(jlz,Lx,Ly,z0,norm,dir);

[ljhx,~]=get_line_data(jhx,Lx,Ly,z0,norm,dir);
[ljhy,~]=get_line_data(jhy,Lx,Ly,z0,norm,dir);
[ljhz,~]=get_line_data(jhz,Lx,Ly,z0,norm,dir);

[ljhex,~]=get_line_data(jhex,Lx,Ly,z0,norm,dir);
[ljhey,~]=get_line_data(jhey,Lx,Ly,z0,norm,dir);
[ljhez,~]=get_line_data(jhez,Lx,Ly,z0,norm,dir);


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
plot(lx,ljpy,'r','LineWidth',1.5); hold on
plot(lx,ljey,'--k','LineWidth',1.5); hold on
plot(lx,ljhy,'g','LineWidth',1.5); hold on
plot(lx,ljly,'b','LineWidth',1.5); hold on
plot(lx,ljhey,'--m','LineWidth',1.5); hold on
xlim(xrange);
xlabel('Z [c/\omega_{pi}]');
ylabel('Jy');
legend('J_{tot}','Je','Jic','Ji','Jice');
title(['Current Density, \omega_{ci}t=',num2str(tt)]);
set(gca,'Fontsize',16);

cd(outdir)
print(f1,'-dpng','-r300',['Jx_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);
print(f2,'-dpng','-r300',['Jy_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);
print(f3,'-dpng','-r300',['Jz_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);
print(f4,'-dpng','-r300',['Jp_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);