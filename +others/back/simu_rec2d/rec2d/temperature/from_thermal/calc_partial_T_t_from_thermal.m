function [T,hfx,enp,vgp,tnv]=calc_partial_T_t_from_thermal(p,qflux,vx,vy,vz,n,grids)
%% calculate partial T/ partial t, the equation is derived by the thermal energy and density equation
% writen by Liangjin Song on 20191102
% 
% p is the pressure 
% q is the heat flux vector
% vx, vy, and vz are the bulk velocity
% n is the number density
% grids is the width of two adjacent points in the data
% 
% T is the scalar temperature
% hfx=-2/3*(gradient dot q)/n
% enp=-2/3*(gradient dot H)/n, where H=UV + P dot V
% vgp=2/3*(V dot (gradient dot P))/n
% tnv=T gradient dot (nV)/n
%%

ndx=size(n,2);
ndy=size(n,1);
[qx,qy,qz]=reshape_qflux(qflux,ndy,ndx);
[pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ndy,ndx);

% hfx
hfx=calc_thermal_heat_flux(qx,qy,qz,grids);
hfx=hfx*2/3;
hfx=hfx./n;

% enp
U=calc_thermal_energy(pxx,pyy,pzz);
enp=calc_thermal_enthalpy_flux(U,vx,vy,vz,pxx,pxy,pxz,pyy,pyz,pzz,grids);
enp=enp*2/3;
enp=enp./n;

% vgp
vgp=calc_thermal_power_density(pxx,pxy,pxz,pyy,pyz,pzz,vx,vy,vz,grids);
vgp=vgp*2/3;
vgp=vgp./n;

% tnv
T=calc_scalar_temperature(pxx,pyy,pzz,n);
nx=n.*vx;
ny=n.*vy;
nz=n.*vz;
tnv=calc_divergence(nx,ny,nz,grids);
tnv=tnv.*T./n;
