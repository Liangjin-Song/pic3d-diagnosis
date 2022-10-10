function [curx,pbx,ppx]=calc_force3_at_RF(bx,by,bz,pi,pe,c,grids)
%% force balance at the Reconnect Front
% writen by Liangjin Song on 20190704
% 
% bx, by, bz are magnetic field
% pi, pe are ion and electron pressure, respectively
% c is the light speed
% grids is the width between two adjacent grid points
%
% curx is the curvature force density in x direction
% pbx is the magnetic pressure gradient force density in x direction
% ppx is the plasma pressure gradient force density in x direction
%%
mu0=c^(-2);
ndx=size(bx,2);
ndy=size(bx,1);

%% plasma pressure gradient force density
pp=pi+pe;
[pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(pp,ndy,ndx);
[ppx,ppy,ppz]=calc_divergence_pressure(pxx,pxy,pxz,pyy,pyz,pzz,grids);
ppx=-ppx;
ppy=-ppy;
ppz=-ppz;

%% magnetic pressure gradient force density
b=sqrt(bx.^2+by.^2+bz.^2);
[pbx,pby,pbz]=calc_divergence_pressure(b,b,b,b,b,b,grids);
pbx=pbx/mu0/2;
pby=pby/mu0/2;
pbz=pbz/mu0/2;
pbx=-pbx;
pby=-pby;
pbz=-pbz;

%% curvature force density 
bxx=bx.*bx;
bxy=bx.*by;
bxz=bx.*bz;
byy=by.*by;
byz=by.*bz;
bzz=bz.*bz;
[curx,cury,curz]=calc_divergence_pressure(bxx,bxy,bxz,byy,byz,bzz,grids);
curx=curx/mu0;
cury=cury/mu0;
curz=curz/mu0;
