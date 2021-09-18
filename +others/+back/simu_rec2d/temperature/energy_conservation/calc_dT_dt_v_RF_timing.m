function [T,hfx,tst,tpn,bct,con]=calc_dT_dt_v_RF_timing(p,qflux,vx,vy,vz,n,grids,Lx,Ly,z0,bz0,bz1,wci,di)
%% calculate dT/dt
% writen by Liangjin Song on 20190810
%
% p is the pressure 
% q is the heat flux vector
% vx, vy, and vz are the bulk velocity
% n is the number density
% bx, by and bz are the magnetic field
% ex, ey and ez are the electric field
% grids is the width of two adjacent points in the data
% Lx and Ly are the simulation box
% z0 is the Z value to get the line in X direction
%
% T is the scalar temperature
% hfx=-2/3*(gradient dot q)/n
% tst=-2/3*(P' dot gradient) dot v/n
% tpn=-2/3*(p gradient dot v)/n
% bct=-v dot gradient T
% con=v_RF dot gradient T
%%

% partial T/t
[T,hfx,tst,tpn,bct]=calc_partial_T_t(p,qflux,vx,vy,vz,n,grids);

% convection
[lbzp,lx]=get_line_data(bz0,Lx,Ly,z0,1,0);
[lbzn,~]=get_line_data(bz1,Lx,Ly,z0,1,0);
v_RF=calc_instant_RF_velocity(lbzp,lbzn,lx,wci,di);
con=calc_convection_term(T,v_RF,0,0,grids);
