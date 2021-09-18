function detl=calc_determinant2(pxx,pxy,pyx,pyy)
%% calculate the determinant of a two order matrix
% writen by Liangjin Song on 20191129
%
% pxx, pxy, pyx, pyy are the terms of a 2x2 matrix
% | pxx pxy |
% | pyx pyy |
% delt is the determinant of the matrix
%%
detl=pxx.*pyy-pxy.*pyx;
