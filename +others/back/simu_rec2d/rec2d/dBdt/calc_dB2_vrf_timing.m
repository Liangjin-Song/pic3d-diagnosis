function [je,eb,co]=calc_dB2_vrf_timing(bx,by,bz,ex,ey,ez,ni,ne,vix,viy,viz,vex,vey,vez,qi,qe,mu0,grids,bzp,bzn,Lx,Ly,z0,wci,di)
%% calculate dB^2/dt
% writen by Liangjin Song on 20191114
%
% bx, by, bz are the magnetic field
% ex, ey, ez are the electric field
% ni, ne are the density
% vix, viy, viz are the ion velocity
% vex, vey, vez are the electron velocity
% qi, qe are the charge
%
% je=-2 mu0 J dot E
% eb=-2 nabla dot (E cross B)
% co=v_RF dot nabla B^2
%%
[je,eb]=calc_partial_B2_t(bx,by,bz,ex,ey,ez,ni,ne,vix,viy,viz,vex,vey,vez,qi,qe,mu0,grids);

B2=(bx.^2+by.^2+bz.^2)/(2*mu0);
vrf=calc_RF_velocity_timing(bzp,bzn,Lx,Ly,z0,wci,di);
[gx,~,~]=calc_gradient(B2,grids);
co=gx*vrf;
