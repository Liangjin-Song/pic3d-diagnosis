function delt=calc_determinant3(pxx,pxy,pxz,pyy,pyz,pzz)
%% calculate the determinant of a three order matrix
% writen by Liangjin Song on 20191129
%
% pxx, pxy, pxz, pyy, pyz, pzz are the terms of a 3x3 matrix
% | pxx pxy pxz |
% | pxy pyy pyz |
% | pxz pyz pzz |
% delt is the determinant of the matrix
%%

delt=pxx.*pyy.*pzz+pxy.*pyz.*pxz+pxz.*pxy.*pyz-pxx.*pyz.*pyz-pxy.*pxy.*pzz-pxz.*pyy.*pxz;
