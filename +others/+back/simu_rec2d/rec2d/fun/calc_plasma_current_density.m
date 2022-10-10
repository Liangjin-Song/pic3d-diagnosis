function [Jx,Jy,Jz]=calc_plasma_current_density(q,n,vx,vy,vz)
%% writen by Liangjin Song on 20190102
% calculate current density created by ions or electrons.
%
% q is the charge of plasma.
% n is the density of plasma.
% v is the velovity of plasma.
%%
Jx=q*(n.*vx);
Jy=q*(n.*vy);
Jz=q*(n.*vz);