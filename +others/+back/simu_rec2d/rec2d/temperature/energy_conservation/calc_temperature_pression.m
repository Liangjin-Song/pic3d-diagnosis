function tpn=calc_temperature_pression(vx,vy,vz,pxx,pyy,pzz,n,grids)
%% calculate the temperature pression
% writen by Liangjin Song on 20190810
%
% vx, vy, and vz are the bulk velocity
% pxx, pyy, and pzz are the diagonal terms of the full pressure tensor
% n is the number density
% grids is the width of two adjacent points in the data
% 
% tpn is the temperature pression
% tpn=-2/3*(p gradient dot v)/n
%%
tpn=calc_divergence(vx,vy,vz,grids);
p=(pxx+pyy+pzz)/3;
tpn=tpn.*p./n;
tpn=-2*tpn/3;
