function [ed,epx,epy,epz]=calc_energy_dissipation(jx,jy,jz,ex,ey,ez,vx,vy,vz,bx,by,bz)
%% calculate the energy dissipation
% writen by Liangjin Song on 20190603
% 
% jx, jy, jz are the current density 
% ex, ey, ez are the electric field
% vx, vy, vz are the bulk velocity of ion or electron
% bx, by, bz are the magnetic field 
%
% ed is the energy dissipation, and ed=J dot (E + V cross B)
%%
[epx,epy,epz]=calc_cross(vx,vy,vz,bx,by,bz);
epx=epx+ex;
epy=epy+ey;
epz=epz+ez;

epx=epx.*jx;
epy=epy.*jy;
epz=epz.*jz;
ed=epx+epy+epz;
