function [temp,vb]=simu_veldist_temp(fd,norm,b0)
% derive the parallel and perpendicular temperature from 
% 3D particle distribution
%
%  plot_veldist2(fd,norm,b0)
%
%input:
%   fd is the array containing three components of 
%   particle velocity
%   norm is the nomalized velocity, such as Alfven velocity
%   b0 is the ambient magnetic field
%
%output:
%%  vth_para and vth_perp are parallel and perpendicular thermal velocity
%%  vb is the bulk velocity in the field-aligned coordinate (3 elements vector)
%%
%%
%--------written by M.Zhou,July,2013, at Wuhan---------------------
%
fd=fd/norm;
%% 
vb0=mean(fd,1);  % bulk velocity in the old coordinate
nv=vb0/sqrt(dot(vb0,vb0));
nb=b0./sqrt(dot(b0,b0));
%%
nperp1=cross(nb,nv); nperp1=nperp1./sqrt(dot(nperp1,nperp1));
nperp2=cross(nb,nperp1);  nperp2=nperp2./sqrt(dot(nperp2,nperp2));
vz=fd(:,1)*nb(1)+fd(:,2)*nb(2)+fd(:,3)*nb(3);
vx=fd(:,1)*nperp1(1)+fd(:,2)*nperp1(2)+fd(:,3)*nperp1(3);
vy=fd(:,1)*nperp2(1)+fd(:,2)*nperp2(2)+fd(:,3)*nperp2(3);
%%
vbx=mean(vx);
vby=mean(vy);
vbz=mean(vz);
vb=[vbx,vby,vbz];
%%
pxx=mean((vx-vbx).*(vx-vbx));
pxy=mean((vx-vbx).*(vy-vby));
pxz=mean((vx-vbx).*(vz-vbz));
pyy=mean((vy-vby).*(vy-vby));
pyz=mean((vy-vby).*(vz-vbz));
pzz=mean((vz-vbz).*(vz-vbz));   %pesudo temperatures
%%
temp=[pxx,pxy,pxz;pxy,pyy,pyz;pxz,pyz,pzz];


%%
%


