function hfx=calc_temperatute_heat_flux(qx,qy,qz,n,grids)
%% calculate the thermal heat flux
% writen by Liangjin Song on 20190806
%
% qx, qy and qz are the heat flux vector
% n is the number density
% grids is the width of two adjacent points in the data
%
% hfx is the divergence of the heat flux
% hfx=-2/3*(gradient dot q)/n
%%
hfx=calc_divergence(qx,qy,qz,grids);
hfx=hfx./n;
hfx=-2*hfx/3;
