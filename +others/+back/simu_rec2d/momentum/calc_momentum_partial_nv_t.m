function [acl, dip, nvv]=calc_momentum_partial_nv_t(q,m,n,ex,ey,ez,vx,vy,vz,bx,by,bz,p,grids)
%% momentum equation, partial (nv/t)
% writen by Liangjin Song on 20200705
%
% q is the charge
% m is the mass
% ex, ey, ez are the electric field
% vx, vy, vz are the bulk velocity
% bx, by, bz are the magnetic field
% p is the thermal pressure
% grids is the interval between two points
%
% acl=qn(E + V x B)/m
% dip=-(nabla dot P)/m
% nvv=-nabla dot (nvv)
%
% all of them are vector, having three components
%%

%% qn(E+VxB)/m
[cx,cy,cz]=calc_cross(vx,vy,vz,bx,by,bz);
cx=cx+ex;
cy=cy+ey;
cz=cz+ez;
acl.x=q.*n.*cx./m;
acl.y=q.*n.*cy./m;
acl.z=q.*n.*cz./m;

%% -(nabla dot P)/m
ndy=size(bx,1);
ndx=size(bx,2);
[pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ndy,ndx);
[px,py,pz]=calc_divergence_pressure(pxx,pxy,pxz,pyy,pyz,pzz,grids);
dip.x=-px/m;
dip.y=-py/m;
dip.z=-pz/m;

%% -nabla dot (nvv)
[px,py,pz]=calc_divergence_pressure(n.*vx.*vx,n.*vx.*vy,n.*vx.*vz,n.*vy.*vy,n.*vy.*vz,n.*vz.*vz,grids);
nvv.x=-px;
nvv.y=-py;
nvv.z=-pz;
