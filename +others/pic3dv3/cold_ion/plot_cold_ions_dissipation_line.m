%% plot diffusion region
% writen by Liangjin Song on 20210331
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Line\Xline';

nx=4000;
ny=2000;
nz=1;
di=40;

tt=31;

n0=384.620087;
vA=0.0125;
norm=n0*vA*vA;

x0=0;
dir=0;

Lx=nx/di;
Ly=ny/di;

xrange=[0,Lx];
yrange=[-Ly/2,Ly/2];
nt=length(tt);

%% read data
cd(indir);
Ni=pic3d_read_data('Nl',tt,nx,ny,nz);
Nic=pic3d_read_data('Nh',tt,nx,ny,nz);
Ne=pic3d_read_data('Ne',tt,nx,ny,nz);
Nice=pic3d_read_data('Nhe',tt,nx,ny,nz);
Vi=pic3d_read_data('Vl',tt,nx,ny,nz);
Vic=pic3d_read_data('Vh',tt,nx,ny,nz);
Ve=pic3d_read_data('Ve',tt,nx,ny,nz);
Vice=pic3d_read_data('Vhe',tt,nx,ny,nz);
E=pic3d_read_data('E',tt,nx,ny,nz);
B=pic3d_read_data('B',tt,nx,ny,nz);

%% current
Ji=plasma_current(Ni,Vi);
Jic=plasma_current(Nic,Vic);
Je=plasma_current(Ne,Ve);
Jice=plasma_current(Nice,Vice);
J.x=Ji.x+Jic.x-Je.x-Jice.x;
J.y=Ji.y+Jic.y-Je.y-Jice.y;
J.z=Ji.z+Jic.z-Je.z-Jice.z;
%% dissipation
% ions
dpi=dissipation(J,E,Vi,B);
dpi=pic3d_simu_filter2d(dpi);
% cold ions
dpic=dissipation(J,E,Vic,B);
dpic=pic3d_simu_filter2d(dpic);
% electrons
dpe=dissipation(J,E,Ve,B);
dpe=pic3d_simu_filter2d(dpe);
dpice=dissipation(J,E,Vice,B);
dpice=pic3d_simu_filter2d(dpice);

%% get line
[ldpi, ll]=get_line_data(dpi,Lx,Ly,x0,norm,dir);
[ldpic, ~]=get_line_data(dpic,Lx,Ly,x0,norm,dir);
[ldpe, ~]=get_line_data(dpe,Lx,Ly,x0,norm,dir);
[ldpice, ~]=get_line_data(dpice,Lx,Ly,x0,norm,dir);

%% figure
figure;
plot(ll,ldpi,'-k','LineWidth',1.5); hold on
plot(ll,ldpic,'-b','LineWidth',1.5);
plot(ll,ldpe,'-m','LineWidth',1.5);
plot(ll,ldpice,'-r','LineWidth',1.5); hold off

function c=dissipation(j,e,v,b)
c.x=v.y.*b.z-v.z.*b.y;
c.y=v.z.*b.x-v.x.*b.z;
c.z=v.x.*b.y-v.y.*b.x;
c.x=c.x+e.x;
c.y=c.y+e.y;
c.z=c.z+e.z;
c=j.x.*c.x+j.y.*c.y+j.z.*c.z;
end

function j=plasma_current(N,V)
j.x=N.*V.x;
j.y=N.*V.y;
j.z=N.*V.z;
end