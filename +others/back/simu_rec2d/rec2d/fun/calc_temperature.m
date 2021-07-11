function [T_aver,T_perp,T_para,T_anis]=calc_temperature(pres,bx,by,bz,dens)
%% writen by Liangjin Song on 20180909
% calculate the temperature of ions or electrons
%
% pres is the pressure of ions or electrons
% dens is the density of the ions or electrons
%
% T_aver is the average temperature
% T_perp is the perpendicular temperature
% T_para is the parallel temperature
% T_anis is the anisotropy temperature
%%
Column=size(bz,2);
Row=size(bz,1);

pp=simu_pres_fac(pres,bx,by,bz);
para=pp(:,6);
para=reshape(para,Column,Row);
para=para';
perp=(pp(:,1)+pp(:,4))/2;
perp=reshape(perp,Column,Row);
perp=perp';
aver=(pp(:,6)+pp(:,1)+pp(:,4))/3;
aver=reshape(aver,Column,Row);
aver=aver';

T_para=para./dens;
T_perp=perp./dens;
T_aver=aver./dens;
T_anis=T_perp./T_para-1;
