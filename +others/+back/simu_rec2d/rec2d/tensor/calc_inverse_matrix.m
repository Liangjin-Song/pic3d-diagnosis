function [axx,axy,axz,ayy,ayz,azz]=calc_inverse_matrix(pxx,pxy,pxz,pyy,pyz,pzz)
%% calculate the adjoint matrix of P
% writen by Liangjin Song on 20191129
%
% pxx, pxy, pxz, pyy, pyz, pzz are the terms of matrix P
% axx, axy, axz, ayy, ayz, azz are the terms of the adjoint matrix of P
%%
% determinant
delt=calc_determinant3(pxx,pxy,pxz,pyy,pyz,pzz);

axx=(pyy.*pzz-pyz.*pyz)./delt;
axy=-(pxy.*pzz-pyz.*pxz)./delt;
axz=(pxy.*pyz-pyy.*pxz)./delt;
ayy=(pxx.*pzz-pxz.*pxz)./delt;
ayz=-(pxx.*pyz-pxy.*pxz)./delt;
azz=(pxx.*pyy-pxy.*pxy)./delt;
