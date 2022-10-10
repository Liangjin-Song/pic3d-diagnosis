%% test v dot divergence of P
% writen by Liangjin Song on 20190530 
clear
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M25SBg00Sx/test/';
t=95;
di=20;
ndx=4000;
ndy=2000;
Lx=ndx/di;
Ly=ndy/di;
grids=1;
z0=25;

% load data
cd(indir)
vx=read_data('vxi',t);
vy=read_data('vyi',t);
vz=read_data('vzi',t);
p=read_data('presi',t);

% v dot divergence of p
[pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ndy,ndx);
wp=calc_work_by_pressure(pxx,pxy,pxz,pyy,pyz,pzz,vx,vy,vz,grids);

% divergence of p dot v
pvx=pxx.*vx+pxy.*vy+pxz.*vz;
pvy=pxy.*vx+pyy.*vy+pyz.*vz;
pvz=pxz.*vx+pyz.*vy+pzz.*vz;
ppv=calc_divergence(pvx,pvy,pvz,grids);

% p nabla v
[gx,gy,gz]=calc_gradient(vx,grids);
p1=pxx.*gx+pxy.*gy+pxz.*gz;
[gx,gy,gz]=calc_gradient(vy,grids);
p2=pxy.*gx+pyy.*gy+pyz.*gz;
[gx,gy,gz]=calc_gradient(vz,grids);
p3=pxz.*gx+pyz.*gy+pzz.*gz;
vpp=p1+p2+p3;

tot=ppv-vpp;


% get line
[lw,lx]=get_line_data(wp,Lx,Ly,z0,1,0);
[lt,~]=get_line_data(tot,Lx,Ly,z0,1,0);

% plot
plot(lx,lt,'k','LineWidth',2); hold on
plot(lx,lw,'r','LineWidth',2);
legend('\nabla\cdot(P\cdotv)-(P\cdot\nabla)\cdotv','v\cdot(\nabla\cdotP)')
xlabel('X')
title(['\Omegat=',num2str(t)]);
set(gca,'Fontsize',16)
cd(outdir)
