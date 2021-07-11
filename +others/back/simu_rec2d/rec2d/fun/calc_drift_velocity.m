function [vx,vy,vz]=calc_drift_velocity(Ex,Ey,Ez,Bx,By,Bz)
%% calculate the drift velocity, where v_drift=(E cross B)/B^2
% writen by Liangjin Song on 20180710
%   Ex,Ey,Ez is the Electric Field
%   Bx, By, Bz is the Magnetic Field
%
% output
%   vx, vy, vz is the drift velocity which is defined at full grids and full time steps
%

vx=Ey.*Bz-Ez.*By;
vy=Ez.*Bx-Ex.*Bz;
vz=Ex.*By-Ey.*Bx;

B2=Bx.^2+By.^2+Bz.^2;

vx=vx./B2;
vy=vy./B2;
vz=vz./B2;
