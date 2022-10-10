function [T,hfx,tst,tpn,bct,con]=calc_dT_dt_vi(p,qflux,vx,vy,vz,n,bx,by,bz,ex,ey,ez,grids,Lx,Ly,z0,vix,viy,viz)
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
% [vx_drf,vy_drf,vz_drf]=calc_drift_velocity(ex,ey,ez,bx,by,bz);

[gx,gy,gz]=calc_gradient(T,grids);
con=gx.*vix+gy.*viy+gz.*viz;

% [lvx,~]=get_line_data(vx_drf,Lx,Ly,z0,1,0);
% [lvy,~]=get_line_data(vy_drf,Lx,Ly,z0,1,0);
% [lvz,~]=get_line_data(vz_drf,Lx,Ly,z0,1,0);
% [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
% [~,in]=max(lbz);


% vrfx=lvx(in);
% vrfy=lvy(in);
% vrfy=0;
% vrfz=lvz(in);
% vrfz=0;
% con=calc_convection_term(T,vrfx,vrfy,vrfz,grids);
% con=calc_temperature_convection_term(T,vrfx,vrfy,vrfz,grids);
