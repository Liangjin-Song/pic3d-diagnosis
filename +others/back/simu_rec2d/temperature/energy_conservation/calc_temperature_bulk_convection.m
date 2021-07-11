function bct=calc_temperature_bulk_convection(T,vx,vy,vz,grids)
%% calculate the bulk convection term of temperature
% writen by Liangjin Song on 20190810
%
% T is the temperature 
% vx, vy, and vz are the bulk velocity
% grids is the width of two adjacent points in the data
% 
% bct is the bulk convection term of temperature 
% bct=-v dot gradient T
%% 
[gx,gy,gz]=calc_gradient(T,grids);
bct=vx.*gx+vy.*gy+vz.*gz;
bct=-bct;
