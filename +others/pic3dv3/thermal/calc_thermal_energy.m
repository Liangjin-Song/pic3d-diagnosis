function U=calc_thermal_energy(pxx,pyy,pzz)
%% calculate the thermal energy density 
% writen by Liangjin Song on 20190517 
%
% pxx, pyy, pzz are the diagonal components of the pressure
%
% U is the thermal energy density 
%%
U=0.5*(pxx+pyy+pzz);
