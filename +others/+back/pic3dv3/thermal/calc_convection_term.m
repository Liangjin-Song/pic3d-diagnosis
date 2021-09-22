function cont=calc_convection_term(U,vrf_x,vrf_y,vrf_z,grids)
%% calculate the convection term
% writen by Liangjin Song on 20190806
%
% U is the thermal energy density
% vrf_x, vrf_y and vrf_z are the velocity of the reconnection front
% grids is the width of two adjacent points in the data
%
% cont is the convection term
% cont=v_RF dot gradient U
%%
[gx,gy,gz]=calc_gradient(U,grids);
cont=gx*vrf_x+gy*vrf_y+gz*vrf_z;
