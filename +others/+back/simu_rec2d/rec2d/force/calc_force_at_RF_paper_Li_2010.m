function [curvx,gradx]=calc_force_at_RF_paper_Li_2010(bx,by,bz,pi,pe,c,grids)
%% calculate the force at the RF by using the paper of Li et al., 2010
% writen by Liangjin Song on 20190707
% 
% bx, by, bz are magnetic field
% pi, pe are ion and electron pressure, respectively
% c is the light speed
% grids is the width between two adjacent grid points
%
% curvx is the curvature force density in x direction
% gradx is the grident force density in x direction
%% 

mu0=c^(-2);
ndx=size(bx,2);
ndy=size(bx,1);

%% plasma pressure gradient force density
pp=pi+pe;
[pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(pp,ndy,ndx);
pth=(pxx+pyy+pzz)/3;
%% magnetic pressure
pb=(bx.*bx+by.*by+bz.*bz)/mu0/2;
%% gradient
pp=pb+pth;
[gradx,grady,gradz]=calc_gradient(pp,grids);
gradx=-gradx;
grady=-grady;
gradz=-gradz;

%% curvature force density
[bxx,bxy,bxz]=calc_gradient(bx,grids);
curvx=bx.*bxx+by.*bxy+bz.*bxz;
curvx=curvx/mu0;

[bxy,byy,byz]=calc_gradient(by,grids);
curvy=bx.*bxy+by.*byy+bz.*byz;
curvy=curvy/mu0;

[bxz,byz,bzz]=calc_gradient(bz,grids);
curvz=bx.*bxz+by.*byz+bz.*bzz;
curvz=curvz/mu0;
