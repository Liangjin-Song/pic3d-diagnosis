function enp=calc_thermal_enthalpy_flux(U,vx,vy,vz,pxx,pxy,pxz,pyy,pyz,pzz,grids)
%% calculate the divergence of the enthalpy energy flux density
% writen by Liangjin Song on 20190806
% 
% U is the thermal energy density
% vx, vy and vz are the bulk velocity 
% pxx, pxy, pxz, pyy, pyz and pzz are the pressure tensor
% grids is the width of two adjacent points in the data
% 
% enp is the divergence of the enthalpy energy flux density
% enp=-gradient dot H
% H=UV + P dot V
%%
%% enthalpy energy flux density
% UV
enp11=U.*vx;
enp12=U.*vy;
enp13=U.*vz;
% P dot V
enp21=pxx.*vx+pxy.*vy+pxz.*vz;
enp22=pxy.*vx+pyy.*vy+pyz.*vz;
enp23=pxz.*vx+pyz.*vy+pzz.*vz;
% enthalpy
enpx=enp11+enp21;
enpy=enp12+enp22;
enpz=enp13+enp23;
%% the divergence of the enthalpy energy flux density
enp=calc_divergence(enpx,enpy,enpz,grids);
enp=-enp;

