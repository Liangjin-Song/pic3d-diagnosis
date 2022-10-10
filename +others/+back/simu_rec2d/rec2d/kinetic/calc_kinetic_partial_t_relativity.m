function [K,flux,we,wp]=calc_kinetic_partial_t_relativity(q,m,n,vx,vy,vz,ex,ey,ez,p,grids,c)
%% calculate partial(K/t)
% writen by Liangjin Song on 20190519 
%
% q is the charge
% m is the mass of the particle
% n is the density
% vx, vy, vz are the bulk velocity
% ex, ey, ez are electric field 
% p is the pressure
% grids is the width of two adjacent points in the data
% c is the light speed
% 
% K is the bulk kinetic energy density
% flux is thebulk kinetic energy flux, flux=-nabla cdot (KV)
% we is the work by electric field, we=qnv dot E
% wp is the work by pressure gradient, wp=-(nabla dot P) dot V
%% 
ndx=size(n,2);
ndy=size(n,1);
%% bulk kinetic energy
K=calc_bulk_kinetic_energy_relativity(m,n,vx,vy,vz,c);

%% bulk kinetic energy flux, it's defined at half grids in x and z directions
flux=calc_bulk_kinetic_energy_flux(K,vx,vy,vz,grids);

%% work by electric field, which need to change to half grids in x and z directions
we=calc_kinetic_work_by_efield(q,n,vx,vy,vz,ex,ey,ez);
% we=calc_grids_full_half_z(we,1);
% we=calc_grids_full_half_x(we,1);

%% work by pressure gradient, which defined at half grids in x and z directions
[pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ndy,ndx);
wp=calc_kinetic_work_by_pressure(pxx,pxy,pxz,pyy,pyz,pzz,vx,vy,vz,grids);
