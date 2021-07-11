function [comp,lcon,tran]=calc_dB_vrf_timing(bx,by,bz,ex,ey,ez,vix,viy,viz,vex,vey,vez,ni,ne,qi,qe,mu0,grids,bzp,bzn,Lx,Ly,z0,wci,di)
%% calculate dB/dt at the front
% writen by Liangjin Song on 20191113
% 
% bx, by, bz are the magnetic field
% ex, ey, ez are the electric field
% vix, viy, viz are the ion bulk velocity
% vex, vey, vez are the electron bulk velocity
% ni, ne are the density of ion and electron
% qi, qe are the charge of the ion and electron
% mu0 is the permeability of vacuum. In our simulation, it is 1/c^2
% grids is the width of two adjacent points in the data
% bzp, bzn is the magnetic field of two moments to calculate the propagating speed of front
% 
% comp=-B nabla dot V_E, V_E is the drift velocity
% lcon=-(mu0 J dot E)/B
% tran=(v_RF-2V_E) dot nabla B
%%

%% compression term
% drift velocity    
Bf=sqrt(bx.^2+by.^2+bz.^2);
[vx_drf,vy_drf,vz_drf]=calc_drift_velocity(ex,ey,ez,bx,by,bz);
comp=calc_compression_item(vx_drf,vy_drf,vz_drf,Bf,grids);

%% local energy conversion term
% current density
[Jx,Jy,Jz]=calc_current_density(ni,ne,qi,qe,vix,viy,viz,vex,vey,vez);
lcon=calc_local_energy_conversion_item(Jx,Jy,Jz,ex,ey,ez,Bf,mu0);

%% convection term
% calculate the propagating speed of the front
[lbzp,lx]=get_line_data(bzp,Lx,Ly,z0,1,0);
[lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
v_RF=calc_instant_RF_velocity(lbzp,lbzn,lx,wci,di);
vx_rf=v_RF;
vy_rf=0;
vz_rf=0;
tran=calc_transport_item(vx_rf,vy_rf,vz_rf,vx_drf,vy_drf,vz_drf,Bf,grids);
