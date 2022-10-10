function [lx,px]=calc_force2_at_RF(jx,jy,jz,bx,by,bz,pi,pe,grids)
%% calculate the Force at the RF
% writen by Liangjin Song on 20190705
%
% jx, jy, jz are current density
% bx, by, bz are magnetic field
% pi, pe are the plasma pressure
%
% lx is the Lorentz force density
% px is the pressure gradient froce density
%%

%% Lorentz force density
[lx,ly,lz]=calc_cross(jx,jy,jz,bx,by,bz);

%% pressure gradient force density
ndx=size(bx,2);
ndy=size(bx,1);
pp=pi+pe;
[pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(pp,ndy,ndx);
[px,py,pz]=calc_divergence_pressure(pxx,pxy,pxz,pyy,pyz,pzz,grids);
px=-px;
py=-py;
pz=-pz;
