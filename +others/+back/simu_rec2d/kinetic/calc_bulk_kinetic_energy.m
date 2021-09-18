function K=calc_bulk_kinetic_energy(m,n,vx,vy,vz)
%% calculate the bulk kinetic energy density 
% writen by Liangjin Song on 20190517 
%
% m is the mass of a species of particle
% n is the density of the species of particle 
% vx, vy, vz is the bulk velocity of the species of particle 
%
% K is the bulk kinetic energy density 
%%
K=n.*(vx.^2+vy.^2+vz.^2);
K=0.5*m*K;
