function [pvt,pvx,pvz]=calc_temperature_p_nabla_v(vx,vy,vz,pxx,pyy,pzz,grids)
%% calculate the p nabla dot v
% writen by Liangjin Song on 20191212
%
% vx, vy, vz are the bulk velocity
% p is the pressure
% 
% pvt=pvx+pvy+pvz
% pvx=p partial vx/partial x
% pvy=p partial vy/partial y, it's equal to zero.
% pvz=p partial vz/partial z
%%

p=(pxx+pyy+pzz)/3;
pvx=calc_partial_x(vx,grids);
pvx=pvx.*p;
pvz=calc_partial_z(vz,grids);
pvz=pvz.*p;
pvt=pvx+pvz;
