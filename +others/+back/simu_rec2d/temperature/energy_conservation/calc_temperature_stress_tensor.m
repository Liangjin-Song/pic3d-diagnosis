function [tst,px,py,pz]=calc_temperature_stress_tensor(pxx,pxy,pxz,pyy,pyz,pzz,vx,vy,vz,n,grids)
%% calculate the stress tensor term
% writen by Liangjin Song on 20190810
%
% pxx, pxy, pxz, pyy, pyz and pzz are the full pressure tensor
% vx, vy, and vz are the bulk velocity
% n is the number density
% grids is the width of two adjacent points in the data
%
% tst is the stress tensor term
% tst=-2/3*(P' dot gradient) dot v/n
%% 
% calculate the stress tensor P'
p=(pxx+pyy+pzz)/3;
ndx=size(pxx,2);
ndy=size(pxx,1);
pdxx=pxx-p;
pdxy=pxy;
pdxz=pxz;
pdyy=pyy-p;
pdyz=pyz;
pdzz=pzz-p;

% calculate (P' dot gradient) dot v
[gx,gy,gz]=calc_gradient(vx,grids);
px=gx.*pdxx+gy.*pdxy+gz.*pdxz;
[gx,gy,gz]=calc_gradient(vy,grids);
py=gx.*pdxy+gy.*pdyy+gz.*pdyz;
[gx,gy,gz]=calc_gradient(vz,grids);
pz=gx.*pdxz+gy.*pdyz+gz.*pdzz;

px=px./n;
px=-2*px/3;

py=py./n;
py=-2*py/3;

pz=pz./n;
pz=-2*pz/3;

tst=px+py+pz;
% tst=tst./n;
% tst=-2*tst/3;
