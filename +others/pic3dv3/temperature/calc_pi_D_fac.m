function [tot, dia, ndia]=calc_pi_D_fac(pres,vx,vy,vz,bx,by,bz,grids)
%% calculate the Pi-D in the field aligned coordinate system
% writen by Liangjin Song on 20200512
% 
% pres is the pressure tensor
% vx, vy, vz are the velocity
% bx, by, bz are the magnetic field
%
% dia is the diagonal term
% ndia is the off-diagonal term
% tot = dia+ndia
%%

Column=size(bz,2);
Row=size(bz,1);

pp=simu_pres_fac(pres,bx,by,bz);
para=pp(:,6);
para=reshape(para,Column,Row);
para=para';
perp=(pp(:,1)+pp(:,4))/2;
perp=reshape(perp,Column,Row);
perp=perp';
aver=(pp(:,6)+pp(:,1)+pp(:,4))/3;
aver=reshape(aver,Column,Row);
aver=aver';

% P'
[pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(pres,Row,Column);
pxx=pxx-aver;
pyy=pyy-aver;
pzz=pzz-aver;

% unit magnetic field vector
bt=sqrt(bx.^2+by.^2+bz.^2);
bx=bx./bt;
by=by./bt;
bz=bz./bt;

% the dyad of unit of magnetic field vector
bxx=bx.*bx;
byy=by.*by;
bzz=bz.*bz;
bxy=bx.*by;
bxz=bx.*bz;
byz=by.*bz;

% unit tensor
uxx=ones(Row,Column);
uyy=ones(Row,Column);
uzz=ones(Row,Column);
uxy=zeros(Row,Column);
uxz=zeros(Row,Column);
uyz=zeros(Row,Column);

% para
para=para-aver;
axx=para.*bxx;
ayy=para.*byy;
azz=para.*bzz;
axy=para.*bxy;
axz=para.*bxz;
ayz=para.*byz;

% perp
perp=perp-aver;
exx=perp.*(uxx-bxx);
eyy=perp.*(uyy-byy);
ezz=perp.*(uzz-bzz);
exy=perp.*(uxy-bxy);
exz=perp.*(uxz-bxz);
eyz=perp.*(uyz-byz);

% diagonal term
dxx=axx+exx;
dyy=ayy+eyy;
dzz=azz+ezz;
dxy=axy+exy;
dxz=axz+exz;
dyz=ayz+eyz;

% calculate (P' dot gradient) dot v for the diagonal term
[gx,gy,gz]=calc_gradient(vx,grids);
px=gx.*dxx+gy.*dxy+gz.*dxz;
[gx,gy,gz]=calc_gradient(vy,grids);
py=gx.*dxy+gy.*dyy+gz.*dyz;
[gx,gy,gz]=calc_gradient(vz,grids);
pz=gx.*dxz+gy.*dyz+gz.*dzz;
dia=-px-py-pz;

% off-diagonal term
oxx=pxx-dxx;
oyy=pyy-dyy;
ozz=pzz-dzz;
oxy=pxy-dxy;
oxz=pxz-dxz;
oyz=pyz-dyz;

% calculate (P' dot gradient) dot v for the off-diagonal term
[gx,gy,gz]=calc_gradient(vx,grids);
px=gx.*oxx+gy.*oxy+gz.*oxz;
[gx,gy,gz]=calc_gradient(vy,grids);
py=gx.*oxy+gy.*oyy+gz.*oyz;
[gx,gy,gz]=calc_gradient(vz,grids);
pz=gx.*oxz+gy.*oyz+gz.*ozz;
ndia=-px-py-pz;

tot=dia+ndia;
