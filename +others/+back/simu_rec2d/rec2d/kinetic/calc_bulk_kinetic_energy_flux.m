function flux=calc_bulk_kinetic_energy_flux(K,vx,vy,vz,grids)
%% calculate the bulk kinetic energy flux
% writen by Liangjin Song on 20190517 
% 
% K is the bulk kinetic energy of the species of particle
% vx, vy, vz is the bulk velocity of the species of particle
% grids is the width of two adjacent points in the data
% 
% flux is the bulk kinetic energy flux, it's defined at half grids in x and z directions
% flux=- nbala dot (KV)

%%

%% ================================== Version 1 =========================
flx=K.*vx;
fly=K.*vy;
flz=K.*vz;
flux=calc_divergence(flx,fly,flz,grids);
flux=-flux;

%% ================================== Version 2 ========================
% flux=calc_divergence(vx,vy,vz,grids);
% flux=flux.*K;
