function [Px,Py,Pz]=calc_divergence_pressure(Pxx,Pxy,Pxz,Pyy,Pyz,Pzz,grids)
%% calculate the divergence of pressure
% writen by Liangjin Song on 20180719
%   Pxx, Pxy, Pxz, Pyy, Pyz, Pzz are pressure tensor
%   grids is the interval between two points
%   
% output
%   Px, Py, Pz are three components of the pressure's divergence
%
% divergence_P=(Pxx/x+Pxy/y+Pxz/z)i+(Pxy/x+Pyy/y+Pyz/z)j+(Pxz/x+Pyz/y+Pzz/z)k
%

%% ================================ Version 1 ===========================
%% in x direction
% P_xx=calc_partial_x(Pxx,grids);
% P_xz=calc_partial_z(Pxz,grids);
% % define at half grids in x and z directions
% P_xx=calc_grids_full_half_z(P_xx,1);
% P_xz=calc_grids_full_half_x(P_xz,1);
% Px=P_xx+P_xz;
% 
% %% in y direction
% P_xy=calc_partial_x(Pxy,grids);
% P_yz=calc_partial_z(Pyz,grids);
% % define at half grids in x and z directions
% P_xy=calc_grids_full_half_z(P_xy,1);
% P_yz=calc_grids_full_half_x(P_yz,1);
% Py=P_xy+P_yz;
% 
% %% in z direction
% P_xz=calc_partial_x(Pxz,grids);
% P_zz=calc_partial_z(Pzz,grids);
% % define at half grids in x and z directions
% P_xz=calc_grids_full_half_z(P_xz,1);
% P_zz=calc_grids_full_half_x(P_zz,1);
% Pz=P_xz+P_zz;


%% ===================================== Version 2 ==========================
nx=size(Pxx,2);
nz=size(Pxx,1);
 
Px=calc_divergence(Pxx,Pxy,Pxz,grids);
Py=calc_divergence(Pxy,Pyy,Pyz,grids);
Pz=calc_divergence(Pxz,Pyz,Pzz,grids);
