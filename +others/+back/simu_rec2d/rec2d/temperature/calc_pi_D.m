function [tst,tot,pdxx,pdxy,pdxz,pdyy,pdyz,pdzz]=calc_pi_D(pxx,pxy,pxz,pyy,pyz,pzz,vx,vy,vz,grids)
%% calculate the Pi-D
% writen by Liangjin Song on 20191129
%
% pxx, pxy, pxz, pyy, pyz, pzz are the pressure tensor
% vx, vy, vz are the velocity
%
% tst=-(P dot nabla ) dot v
% tot=pdxx+2*pdxy+2*pdxz+pdyy+2*pdyz+pdzz
%%

%% Pi
p=(pxx+pyy+pzz)/3;
Pixx=pxx-p;
Pixy=pxy;
Pixz=pxz;
Piyy=pyy-p;
Piyz=pyz;
Pizz=pzz-p;

%% D
[vxx,vxy,vxz]=calc_gradient(vx,grids);
[vyx,vyy,vyz]=calc_gradient(vy,grids);
[vzx,vzy,vzz]=calc_gradient(vz,grids);
theta=calc_divergence(vx,vy,vz,grids);

Dxx=vxx-theta/3;
Dxy=(vyx+vxy)/2;
Dxz=(vxz+vzx)/2;
Dyy=vyy-theta/3;
Dyz=(vyz+vzy)/2;
Dzz=vzz-theta/3;

% [Dxx,Dxy,Dxz,Dyy,Dyz,Dzz]=calc_inverse_matrix(Dxx,Dxy,Dxz,Dyy,Dyz,Dzz);

pdxx=-Pixx.*Dxx;
pdxy=-Pixy.*Dxy;
pdxz=-Pixz.*Dxz;
pdyy=-Piyy.*Dyy;
pdyz=-Piyz.*Dyz;
pdzz=-Pizz.*Dzz;

tot=pdxx+pdyy+pdzz+(pdxy+pdxz+pdyz)*2;

%% tst
% calculate (P' dot gradient) dot v
[gx,gy,gz]=calc_gradient(vx,grids);
px=gx.*Pixx+gy.*Pixy+gz.*Pixz;
[gx,gy,gz]=calc_gradient(vy,grids);
py=gx.*Pixy+gy.*Piyy+gz.*Piyz;
[gx,gy,gz]=calc_gradient(vz,grids);
pz=gx.*Pixz+gy.*Piyz+gz.*Pizz;
tst=-px-py-pz;
