function lenergy=calc_local_energy_conversion_item(Jx,Jy,Jz,Ex,Ey,Ez,B,mu)
%% calculate the local energy conversion item
% writen by Liangjin Song on 20180706
%   Jx,Jy,Jz is the current density, which is defined in full grids and full time steps
%   Ex, Ey, Ez is the electric field, which is defined in full grids and full time steps
%   B is total magnetic field, which is defined in full grids and full time steps
%   c is light speed
%
% output
%   lenergy is the local energy conversion item, which is defined in half grids and full time steps
%

jde=calc_energy_conversion(Jx,Jy,Jz,Ex,Ey,Ez);
lenergy=jde*mu;
lenergy=lenergy./B;
lenergy=(-1)*lenergy;

% make it defined at half grids in x and z direction
% lenergy=calc_grids_full_half_z(lenergy,1);
% lenergy=calc_grids_full_half_x(lenergy,1);
