function [T,hfx,enp,vgp,tnv,con]=calc_dT_dt_from_thermal(p,qflux,vx,vy,vz,n,vrfx,vrfy,vrfz,grids)
%% calculate partial T/ partial t, the equation is derived by the thermal energy and density equation
% writen by Liangjin Song on 20191102
% 
% p is the pressure 
% q is the heat flux vector
% vx, vy, and vz are the bulk velocity
% n is the number density
% grids is the width of two adjacent points in the data
% 
% T is the scalar temperature
% hfx=-2/3*(gradient dot q)/n
% enp=-2/3*(gradient dot H)/n, where H=UV + P dot V
% vgp=2/3*(V dot (gradient dot P))/n
% tnv=T gradient dot (nV)/n
% con=VRF dot (gradient T)
%%
[T,hfx,enp,vgp,tnv]=calc_partial_T_t_from_thermal(p,qflux,vx,vy,vz,n,grids);

[gx,gy,gz]=calc_gradient(T,grids);
con=gx.*vx+gy.*vy+gz.*vz;
