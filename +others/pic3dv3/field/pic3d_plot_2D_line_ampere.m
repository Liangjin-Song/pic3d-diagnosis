% test the Ampere's law of the pic simulation
% writen by Liangjin Song on
clear;
indir='E:\PIC\Test';
outdir='E:\PIC\Test';

tt=0;

nx=500;
ny=500;
nz=1;

qi=0.001167;
qe=-qi;

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
vi=pic3d_read_data('Vi',tt,nx,ny,nz);
ve=pic3d_read_data('Ve',tt,nx,ny,nz);
ni=pic3d_read_data('Ni',tt,nx,ny,nz);
ne=pic3d_read_data('Ne',tt,nx,ny,nz);

jpx=qi*vi.x.*ni+qe*ve.x.*ne;
jpy=qi*vi.y.*ni+qe*ve.y.*ne;
jpz=qi*vi.z.*ni+qe*ve.z.*ne;

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


f1=figure;
plot(lx,ljx,'r','LineWidth',1.5); hold on
plot(lx,ljcx,'--k','LineWidth',1.5); hold on
plot(lx,ljpx,'b','LineWidth',1.5); hold on
xlim(xrange);
xlabel('Z [c/\omega_{pi}]');
ylabel('Jx');
legend('Js','Jc','Jp');
title(['Current Density, \omega_{ci}t=',num2str(tt)]);
set(gca,'Fontsize',14);

f2=figure;
plot(lx,ljy,'r','LineWidth',1.5); hold on
plot(lx,ljcy,'--k','LineWidth',1.5); hold on
plot(lx,ljpy,'b','LineWidth',1.5); hold on
xlim(xrange);
xlabel('Z [c/\omega_{pi}]');
ylabel('Jy');
legend('Js','Jc','Jp');
title(['Current Density, \omega_{ci}t=',num2str(tt)]);
set(gca,'Fontsize',14);

f3=figure;
plot(lx,ljz,'r','LineWidth',1.5); hold on
plot(lx,ljcz,'--k','LineWidth',1.5); hold on
plot(lx,ljpz,'b','LineWidth',1.5); hold on
xlim(xrange);
xlabel('Z [c/\omega_{pi}]');
ylabel('Jz');
legend('Js','Jc','Jp');
title(['Current Density, \omega_{ci}t=',num2str(tt)]);
set(gca,'Fontsize',14);

cd(outdir)
print(f1,'-dpng','-r300',['Jx_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);
print(f2,'-dpng','-r300',['Jy_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);
print(f3,'-dpng','-r300',['Jz_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);