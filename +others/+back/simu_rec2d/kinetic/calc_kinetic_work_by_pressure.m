function wp=calc_kinetic_work_by_pressure(Pxx,Pxy,Pxz,Pyy,Pyz,Pzz,vx,vy,vz,grids)
%% calculate the power densities of the work done by pressure gradient force
% writen by Liangjin Song on 20190517 
%
% P is the pressure tensor
% vx, vy, vz are the bulk velocity 
% grids is the width of two adjacent points in the data
% 
% wp is the power densities of the work done by pressure gradient force, which defined at half grids in x and z direction
% wp=-(nabla dot P) dot V
%% 
[Px,Py,Pz]=calc_divergence_pressure(Pxx,Pxy,Pxz,Pyy,Pyz,Pzz,grids);

% work density 
wp=Px.*vx+Py.*vy+Pz.*vz;
wp=-wp;
