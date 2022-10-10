function [K,flux,we,wp,cv]=calc_kinetic_dK_dt_vRF_timing(q,m,n,vx,vy,vz,ex,ey,ez,p,grids,Lx,Ly,z0,bzp,bzn,wci,di)
%% calculate dK/dt
% writen by Liangjin Song on 20190519 
%
% q is the charge
% m is the mass of the particle
% n is the density
% vx, vy, vz are the bulk velocity
% ex, ey, ez are electric field 
% p is the pressure
% bzp, and bzn are the magnetic field to calculate RF velocity
% grids is the width of two adjacent points in the data
% 
% K is the bulk kinetic energy density
% flux is thebulk kinetic energy flux
% we is the work by electric field
% wp is the work by pressure gradient
%% 
%{
ndx=size(n,2);
ndy=size(n,1);
%% bulk kinetic energy
K=calc_bulk_kinetic_energy(m,n,vx,vy,vz);

%% bulk kinetic energy flux, it's defined at half grids in x and z directions
flux=calc_bulk_kinetic_energy_flux(K,vx,vy,vz,grids);
flux=-flux;

%% work by electric field, which need to change to half grids in x and z directions
we=calc_work_by_efield(q,n,vx,vy,vz,ex,ey,ez);
% we=calc_grids_full_half_z(we,1);
% we=calc_grids_full_half_x(we,1);

%% work by pressure gradient, which defined at half grids in x and z directions
[pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ndy,ndx);
wp=calc_work_by_pressure(pxx,pxy,pxz,pyy,pyz,pzz,vx,vy,vz,grids);
wp=-wp;
%}


[K,flux,we,wp]=calc_kinetic_partial_t(q,m,n,vx,vy,vz,ex,ey,ez,p,grids);

%% convection term
[lbzp,lx]=get_line_data(bzp,Lx,Ly,z0,1,0);
[lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
v_RF=calc_instant_RF_velocity(lbzp,lbzn,lx,wci,di);
[gx,gy,gz]=calc_gradient(K,grids);
% cv=vrx.*gx+vry.*gy+vrz.*gz;
cv=v_RF*gx;
