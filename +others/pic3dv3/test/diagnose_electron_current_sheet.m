%% diagnosing the electron current sheet
clear;
% writen by Liangjin Song on 20210326
indir='E:\PIC\Electron_Current';
outdir='E:\PIC\Electron_Current';
nx=500;
ny=500;
nz=1;
di=20;

tt=0;

z0=12.5;
dir=1;

Lx=nx/di;
Ly=ny/di;

n0=133.518112;
vA=0.0125;
coeff=1;
c=0.5;
xrange=[-Ly/2,Ly/2];


%% read data
cd(indir);
E=pic3d_read_data('E',tt,nx,ny,nz);
B=pic3d_read_data('B',tt,nx,ny,nz);
Ne=pic3d_read_data('Ne',tt,nx,ny,nz);
Ni=pic3d_read_data('Ni',tt,nx,ny,nz);
Ve=pic3d_read_data('Ve',tt,nx,ny,nz);
Vi=pic3d_read_data('Vi',tt,nx,ny,nz);
Pe=pic3d_read_data('Pe',tt,nx,ny,nz);
Pi=pic3d_read_data('Pi',tt,nx,ny,nz);

%% current
Ji.x=Ni.*Vi.x;
Ji.y=Ni.*Vi.y;
Ji.z=Ni.*Vi.z;
Je.x=-Ne.*Ve.x;
Je.y=-Ne.*Ve.y;
Je.z=-Ne.*Ve.z;

%% pressure
Pb=(B.x.^2+B.y.^2+B.z.^2)*c*c*0.5;
Pe=(Pe.xx+Pe.yy+Pe.zz)*coeff/3;
Pi=(Pi.xx+Pi.yy+Pi.zz)*coeff/3;

%% get line
[lbx,lx]=get_line_data(B.x,Lx,Ly,z0,1,dir);
[lez,~]=get_line_data(E.z,Lx,Ly,z0,vA,dir);
[lni,~]=get_line_data(Ni,Lx,Ly,z0,n0,dir);
[lne,~]=get_line_data(Ne,Lx,Ly,z0,n0,dir);
[lvi,~]=get_line_data(Vi.y,Lx,Ly,z0,vA,dir);
[lve,~]=get_line_data(Ve.y,Lx,Ly,z0,vA,dir);
[lji,~]=get_line_data(Ji.y,Lx,Ly,z0,n0*vA,dir);
[lje,~]=get_line_data(Je.y,Lx,Ly,z0,n0*vA,dir);
[lpb,~]=get_line_data(Pb,Lx,Ly,z0,1,dir);
[lpe,~]=get_line_data(Pe,Lx,Ly,z0,1,dir);
[lpi,~]=get_line_data(Pi,Lx,Ly,z0,1,dir);
lptot=lpb+lpe+lpi;

%% calculate the electric potential
pet=zeros(length(lez),1);
pet(1)=lez(1);
for i=2:length(lez)
    pet(i)=pet(i-1)+lez(i);
end
pet=-pet;

%% figure
f0=figure;
plot(lx,lez,'-k','LineWidth',1.5);
xlabel('Z [c/\omega_{pi}]');
ylabel('Ez');
xlim(xrange);

f1=figure;
plot(lx,pet,'-k','LineWidth',1.5);
xlabel('Z [c/\omega_{pi}]');
ylabel('\psi');
xlim(xrange);

f2=figure;
plot(lx,lbx,'-k','LineWidth',1.5);
xlabel('Z [c/\omega_{pi}]');
ylabel('Bx');
xlim(xrange);

f3=figure;
plot(lx,lni,'-k','LineWidth',1.5); hold on
plot(lx,lne,'-r','LineWidth',1.5); hold off
xlabel('Z [c/\omega_{pi}]');
ylabel('Density');
legend('Ni','Ne');
xlim(xrange);

f4=figure;
plot(lx,lvi,'-k','LineWidth',1.5); hold on
plot(lx,lve,'-r','LineWidth',1.5); hold off
xlabel('Z [c/\omega_{pi}]');
ylabel('Velocity');
legend('Vi','Ve');
xlim(xrange);

f5=figure;
plot(lx,lji,'-k','LineWidth',1.5); hold on
plot(lx,lje,'-r','LineWidth',1.5); hold off
xlabel('Z [c/\omega_{pi}]');
ylabel('current');
legend('Ji','Je');
xlim(xrange);

f6=figure;
plot(lx,lptot,'-k','LineWidth',1.5); hold on
plot(lx,lpe,'-r','LineWidth',1.5);
plot(lx,lpi,'-g','LineWidth',1.5);
plot(lx,lpb,'-b','LineWidth',1.5); hold off
xlabel('Z [c/\omega_{pi}]');
ylabel('Pressure');
legend('Sum','Pe','Pi','Pb');
xlim(xrange);