function we=calc_kinetic_work_by_efield(q,n,vx,vy,vz,ex,ey,ez)
%% calculate the  power densities of the work done by electric field force 
% writen by Liangjin Song on 20190517 
%
% q is the charge of the species of the particle 
% n is the density of the species of the particle 
% vx, vy, vz are the bulk velocity of the species of the particle 
% ex, ey, ez are the electric field 
% 
% we is the power densities of the work done by electric field force
% we=qnv dot E
%%
we=vx.*ex+vy.*ey+vz.*ez;
we=q*(n.*we);
