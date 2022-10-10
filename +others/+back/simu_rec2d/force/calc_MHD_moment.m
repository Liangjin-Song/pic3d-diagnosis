function [jxb,grdp,momv]=calc_MHD_moment(jx,jy,jz,bx,by,bz,vx,vy,vz,p,n,m,grids)
%% calc the force derived from MHD momentum functions
% writen by Liangjin Song on 20191206
% 
% jx, jy, jz are current density
% bx, by, bz are magnetic field
% vx, vy, vz are the velocity
% p is the pressure
% n is the density
% m is the mass
%
% jxb=J cross B
% grdp=nabla dot P
% momv=rho(v dot nabla)v
%%

%% J cross B
[x,y,z]=calc_cross(jx,jy,jz,bx,by,bz);
jxb.x=x;
jxb.y=y;
jxb.z=z;

%% nabla dot P
ndx=size(bx,2);
ndy=size(bx,1);
[pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ndy,ndx);
[x,y,z]=calc_divergence_pressure(pxx,pxy,pxz,pyy,pyz,pzz,grids);
grdp.x=x;
grdp.y=y;
grdp.z=z;

%% rho (v dot nabla)v
rho=n*m;
[gx,gy,gz]=calc_gradient(vx,grids);
x=vx.*gx+vy.*gy+vz.*gz;

[gx,gy,gz]=calc_gradient(vy,grids);
y=vx.*gx+vy.*gy+vz.*gz;

[gx,gy,gz]=calc_gradient(vz,grids);
z=vx.*gx+vy.*gy+vz.*gz;

momv.x=x;
momv.y=y;
momv.z=z;
