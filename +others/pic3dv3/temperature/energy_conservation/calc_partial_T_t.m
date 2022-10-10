function [T,hfx,tst,tpn,bct]=calc_partial_T_t(p,qflux,vx,vy,vz,n,grids)
%% calculate partial T/t
% writen by Liangjin Song on 20190810
%
% p is the pressure 
% q is the heat flux vector
% vx, vy, and vz are the bulk velocity
% n is the number density
% grids is the width of two adjacent points in the data
% 
% T is the scalar temperature
% hfx=-2/3*(gradient dot q)/n
% tst=-2/3*(P' dot gradient) dot v/n
% tpn=-2/3*(p gradient dot v)/n
% bct=-v dot gradient T
%%
ndx=size(n,2);
ndy=size(n,1);
% heat flux term
% [qx,qy,qz]=reshape_qflux(qflux,ndy,ndx);
hfx=calc_temperature_heat_flux(qflux.x,qflux.y,qflux.z,n,grids);
% stress tensor
% [pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ndy,ndx);
pxx=p.xx;
pxy=p.xy;
pxz=p.xz;
pyy=p.yy;
pyz=p.yz;
pzz=p.zz;
tst=calc_temperature_stress_tensor(pxx,pxy,pxz,pyy,pyz,pzz,vx,vy,vz,n,grids);
% compression term
tpn=calc_temperature_pression(vx,vy,vz,pxx,pyy,pzz,n,grids);
% bulk converction term
T=calc_scalar_temperature(pxx,pyy,pzz,n);
bct=calc_temperature_bulk_convection(T,vx,vy,vz,grids);
