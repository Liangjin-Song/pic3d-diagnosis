function [je,eb]=calc_partial_B2_t(bx,by,bz,ex,ey,ez,ni,ne,vix,viy,viz,vex,vey,vez,qi,qe,mu0,grids)
%% calculate dB^2/dt
% writen by Liangjin Song on 20191113
%
% bx, by, bz are the magnetic field
% ex, ey, ez are the electric field
% ni, ne are the density
% vix, viy, viz are the ion velocity
% vex, vey, vez are the electron velocity
% qi, qe are the charge
%
% je=- J dot E
% eb=- nabla dot (E cross B) / mu0
%%

%% je
[Jx,Jy,Jz]=calc_current_density(ni,ne,qi,qe,vix,viy,viz,vex,vey,vez);
je=calc_energy_conversion(Jx,Jy,Jz,ex,ey,ez);
je=-je;
% je=-2*mu0*je;

%% eb
[ebx,eby,ebz]=calc_cross(ex,ey,ez,bx,by,bz);
eb=calc_divergence(ebx,eby,ebz,grids);
eb=-eb/mu0;
