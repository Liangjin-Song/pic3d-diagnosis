function vrf=calc_RF_velocity_timing(bzp,bzn,Lx,Ly,z0,wci,di)
%% calculate the propagating speed of reconnection front
% writen by Liangjin Song on 20191114
%
% bzn, bzp are the magnetic field of two moments
% Lx, Ly are the box size
% z0 is the position of front in z direction
% wci is the ion gyrofrequency
% di is the ion inertia length
%
% vrf is the propagating velocity of front
%%
[lbzp,lx]=get_line_data(bzp,Lx,Ly,z0,1,0);
[lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
vrf=calc_instant_RF_velocity(lbzp,lbzn,lx,wci,di);
