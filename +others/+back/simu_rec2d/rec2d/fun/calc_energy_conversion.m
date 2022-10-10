function Ec=calc_energy_conversion(Jx,Jy,Jz,Ex,Ey,Ez)
%% calculate energy conversion
% writen by Liangjin Song on 20181112
% 
% Jx, Jy, Jz are current density
% Ex, Ey, Ez are electric field
%%
Ec=Jx.*Ex+Jy.*Ey+Jz.*Ez;