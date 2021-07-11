function [tens,pb,pt]=calc_force(bx,by,bz,p,c,grids)
%% calculate the MHD force
% writen by Liangjin Song on 20191206
%
% bx, by, bz are the magnetic field
% p is the pressure
% c is the light speed
% grids is the width between two adjacent grid points
%
% tens=nabla \cdot (BB/mu0)
% pb=- nabla dot (b^2/2mu0 I)
% pt=- nabla dot P
%%
mu0=c^(-2);
ndx=size(bx,2);
ndy=size(bx,1);
zr=zeros(ndy,ndx);

% thermal pressure
[pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ndy,ndx);
[x,y,z]=calc_divergence_pressure(pxx,pxy,pxz,pyy,pyz,pzz,grids);
pt.x=-x;
pt.y=-y;
pt.z=-z;

% magnetic pressure
b2=(bx.^2+by.^2+bz.^2)/(2*mu0);
[x,y,z]=calc_divergence_pressure(b2,zr,zr,b2,zr,b2,grids);
pb.x=-x;
pb.y=-y;
pb.z=-z;

% magnetic tension
bxx=bx.*bx/mu0;
bxy=bx.*by/mu0;
bxz=bx.*bz/mu0;
byy=by.*by/mu0;
byz=by.*bz/mu0;
bzz=bz.*bz/mu0;
[x,y,z]=calc_divergence_pressure(bxx,bxy,bxz,byy,byz,bzz,grids);
tens.x=x;
tens.y=y;
tens.z=z;
