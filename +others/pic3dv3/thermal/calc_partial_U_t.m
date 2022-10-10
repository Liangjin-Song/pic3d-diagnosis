function [U,enp,htf,thp]=calc_partial_U_t(pxx,pxy,pxz,pyy,pyz,pzz,qx,qy,qz,vx,vy,vz,grids)
%% calculate the partial U/t
% writen by Liangjin Song on 20190809
% 
% pxx, pxy, pxz, pyy, pyz and pzz are the pressure tensor
% qx, qy and qz are the heat flux
% vx, vy and vz are the bulk velocity
% grids is the width of two adjacent points in the data
% 
% U is the thermal energy density
% enp is the divergence of the enthalpy energy flux density
% htf is the divergence of the heat flux
% thp is the power density of the work done by pressure gradient force
%%

%% thermal energy density 
U=calc_thermal_energy(pxx,pyy,pzz);

%% the divergence of the enthalpy energy flux density
enp=calc_thermal_enthalpy_flux(U,vx,vy,vz,pxx,pxy,pxz,pyy,pyz,pzz,grids);

%% calculate the thermal heat flux
htf=calc_thermal_heat_flux(qx,qy,qz,grids);

%% the power density of the work done by pressure gradient force
thp=calc_thermal_power_density(pxx,pxy,pxz,pyy,pyz,pzz,vx,vy,vz,grids);
