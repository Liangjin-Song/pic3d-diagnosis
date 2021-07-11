function cv=calc_convective(vrf,vx,vy,vz,K,grids)
% function cv=calc_convective(vrf,K,grids)
%% calculate the convective bulk kinetic associate with the reconnection front.
% writen by Liangjin Song on 20190517 
% 
% vrx, vry, vrz are RF's velocity, which can be replaced by drift velocity
% K is the bulk kinetic energy 
% grids is the width of two adjacent points in the data
% 
% cv is the convective bulk kinetic energy, which defined at half grids
%% 

%% ==================================== Version 1 =========================
[gx,gy,gz]=calc_gradient(K,grids);
cv=vrx.*gx+vry.*gy+vrz.*gz;
cv=vrf*gx+gy+gz;

%% ================================== Version 2 ===========================
% [gx,gy,gz]=calc_gradient(K,grids);
% vx=vrf-vx;
% vy=-vy;
% vz=-vz;
% cv=vx.*gx+vy.*gy+vz.*gz;
