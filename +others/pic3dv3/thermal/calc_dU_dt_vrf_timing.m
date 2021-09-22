function [U,enp,htf,thp,con]=calc_dU_dt_vrf_timing(pxx,pxy,pxz,pyy,pyz,pzz,qx,qy,qz,vx,vy,vz,bzn,bzp,grids,Lx,Ly,z0,wci,di)
%% calculate the dU/dt
% writen by Liangjin Song on 20190806
% 
% pxx, pxy, pxz, pyy, pyz and pzz are the pressure tensor
% qx, qy and qz are the heat flux
% vx, vy and vz are the bulk velocity
% bx, by and bz are the magnetic field
% grids is the width of two adjacent points in the data
% Lx and Ly are the simulation box
% z0 is the Z value to get the line in X direction
% 
% U is the thermal energy density
% enp is the divergence of the enthalpy energy flux density
% htf is the divergence of the heat flux
% thp is the power density of the work done by pressure gradient force
% con is the convection term
%%

%% thermal energy density 
U=calc_thermal_energy(pxx,pyy,pzz);

%% the divergence of the enthalpy energy flux density
enp=calc_thermal_enthalpy_flux(U,vx,vy,vz,pxx,pxy,pxz,pyy,pyz,pzz,grids);

%% calculate the thermal heat flux
htf=calc_thermal_heat_flux(qx,qy,qz,grids);

%% the power density of the work done by pressure gradient force
thp=calc_thermal_power_density(pxx,pxy,pxz,pyy,pyz,pzz,vx,vy,vz,grids);

%% convection term
% get the velocity of the reconnection front
[lbzp,lx]=get_line_data(bzp,Lx,Ly,z0,1,0);
[lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
v_RF=calc_instant_RF_velocity(lbzp,lbzn,lx,wci,di);
vrfx=v_RF;
vrfy=0;
vrfz=0;
con=calc_convection_term(U,vrfx,vrfy,vrfz,grids);
