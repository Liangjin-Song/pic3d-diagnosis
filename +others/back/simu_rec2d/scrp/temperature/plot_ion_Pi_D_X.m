%% plot Pi-D of a time
% writen by Liangjin Song on 20191129
clear;
indir='/data/simulation/M100SBg00Sx_low_vte/ppc=100/';
outdir='/data/simulation/M100SBg00Sx_low_vte/out/ppc=100/dt/';

tt=40;
di=60;
ndx=6000;
ndy=3000;
Lx=ndx/di; Ly=ndy/di;
z0=12.5;
c=0.6;
grids=1;

cd(indir);
pp=read_data('presi',tt);
vx=read_data('vxi',tt);
vy=read_data('vyi',tt);
vz=read_data('vzi',tt);

[pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(pp,ndy,ndx);

%% stress tensor
p=(pxx+pyy+pzz)/3;
dxx=pxx-p;
dxy=pxy;
dxz=pxz;
dyy=pyy-p;
dyz=pyz;
dzz=pzz-p;

% calculate (P' dot gradient) dot v
[gx,gy,gz]=calc_gradient(vx,grids);
px=gx.*dxx+gy.*dxy+gz.*dxz;
[gx,gy,gz]=calc_gradient(vy,grids);
py=gx.*dxy+gy.*dyy+gz.*dyz;
[gx,gy,gz]=calc_gradient(vz,grids);
pz=gx.*dxz+gy.*dyz+gz.*dzz;
tst=px+py+pz;

%% Pi-D
[tot,pdxx,pdxy,pdxz,pdyy,pdyz,pdzz]=calc_pi_D(pxx,pxy,pxz,pyy,pyz,pzz,vx,vy,vz,grids);

%% get line
[ltst,lx]=get_line_data(tst,Lx,Ly,z0,1,0);
[ltot,~]=get_line_data(tot,Lx,Ly,z0,1,0);
[lxx,~]=get_line_data(pdxx,Lx,Ly,z0,1,0);
[lxy,~]=get_line_data(pdxy,Lx,Ly,z0,1,0);
[lxz,~]=get_line_data(pdxz,Lx,Ly,z0,1,0);
[lyy,~]=get_line_data(pdyy,Lx,Ly,z0,1,0);
[lyz,~]=get_line_data(pdyz,Lx,Ly,z0,1,0);
[lzz,~]=get_line_data(pdzz,Lx,Ly,z0,1,0);

figure;
lw=2;
%{
plot(lx,lxx,'r','LineWidth',lw); hold on
plot(lx,lxy,'g','LineWidth',lw);
plot(lx,lxz,'c','LineWidth',lw);
plot(lx,lyy,'y','LineWidth',lw);
plot(lx,lyz,'m','LineWidth',lw);
plot(lx,lzz,'b','LineWidth',lw);
%}

plot(lx,ltot,'k','LineWidth',lw); hold on
plot(lx,ltst,'--r','LineWidth',lw);

% plot([0,100],[0,0],'--y','LineWidth',1); hold off
xlim([Lx/2,Lx]);
% legend('Pixx','Pixy','Pixz','Piyy','Piyz','Pizz','Sum','Pi-D','Pi-D=0');
