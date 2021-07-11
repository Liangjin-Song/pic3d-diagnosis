function compre=calc_compression_item(vx,vy,vz,B,divsor)
%% calculate the compression item
% writen by Liangjin Song on 20180710
%   vx, vy, vz is the drift velocity, which is defined in full grids and full time steps
%   B is total magnetic field, which is defined in full grids and full time steps
%
% output
%   compre is the compression item, which is defined at half grids and full time steps
%   
%% 
% calculate the divergence of drift velocity 
divergdv=calc_divergence(vx,vy,vz,divsor);

% make it defined at half grids in x and z direction
% Bt=calc_grids_full_half_z(B,1);
% Bt=calc_grids_full_half_x(Bt,1);

compre=divergdv.*B;
compre=(-1)*compre;
