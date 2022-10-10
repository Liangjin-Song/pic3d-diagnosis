function [U,enp,htf,thp,con]=calc_dU_dt(pxx,pxy,pxz,pyy,pyz,pzz,qx,qy,qz,vx,vy,vz,bx,by,bz,ex,ey,ez,grids,Lx,Ly,z0)
%% calculate the dU/dt
% writen by Liangjin Song on 20190806
% 
% pxx, pxy, pxz, pyy, pyz and pzz are the pressure tensor
% qx, qy and qz are the heat flux
% vx, vy and vz are the bulk velocity
% bx, by and bz are the magnetic field
% ex, ey and ez are the electric field
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
[vx_drf,vy_drf,vz_drf]=calc_drift_velocity(ex,ey,ez,bx,by,bz);
[lvx,~]=get_line_data(vx_drf,Lx,Ly,z0,1,0);
[lvy,~]=get_line_data(vy_drf,Lx,Ly,z0,1,0);
[lvz,~]=get_line_data(vz_drf,Lx,Ly,z0,1,0);
[lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
[~,in]=max(lbz);
vrfx=lvx(in);
vrfy=lvy(in);
vrfz=lvz(in);
con=calc_convection_term(U,vrfx,vrfy,vrfz,grids);
