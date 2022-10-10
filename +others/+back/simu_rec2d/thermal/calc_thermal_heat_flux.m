function hfx=calc_thermal_heat_flux(qx,qy,qz,grids)
%% calculate the thermal heat flux
% writen by Liangjin Song on 20190806
%
% qx, qy and qz are the heat flux vector
% grids is the width of two adjacent points in the data
%
% hfx is the divergence of the heat flux
% hfx=gradient dot q
%%
hfx=calc_divergence(qx,qy,qz,grids);
hfx=-hfx;
