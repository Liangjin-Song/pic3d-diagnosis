function [Jx,Jy,Jz]=calc_current_density(densi,dense,qi,qe,vxi,vyi,vzi,vxe,vye,vze)
%% calculate the current density
% writen by Liangjin Song on 20180525
%   densi and dense are the density of ions and electrons respecitively
%   qi,qe are charge of electrons and ions respectively
%   vxi,vyi,vzi,vxe,vye,vze are the ions and electrons velocity
%
% output
%   Jx, Jy, Jz is the current density
%

%% current density
Jx=(densi.*vxi)*qi+(dense.*vxe)*qe;
Jy=(densi.*vyi)*qi+(dense.*vye)*qe;
Jz=(densi.*vzi)*qi+(dense.*vze)*qe;
