function [Pxx,Pxy,Pxz,Pyy,Pyz,Pzz]=reshap_pressure(P,Row,Column)
%% reshap the pressure
% writen by Liangjin Song on 20180719
%   P is the pressure
%   Row is size(fd,1)
%   Column is size(fd,2)
%   
% output
%   Pxx, Pxy, Pxz, Pyy, Pyz, Pzz are pressure tensor
%

%% reshap the the data
Pxx=P(:,1);
Pxx=reshape(Pxx,Column,Row);
Pxx=Pxx';

Pyy=P(:,4);
Pyy=reshape(Pyy,Column,Row);
Pyy=Pyy';

Pzz=P(:,6);
Pzz=reshape(Pzz,Column,Row);
Pzz=Pzz';

Pxy=P(:,2);
Pxy=reshape(Pxy,Column,Row);
Pxy=Pxy';

Pxz=P(:,3);
Pxz=reshape(Pxz,Column,Row);
Pxz=Pxz';

Pyz=P(:,5);
Pyz=reshape(Pyz,Column,Row);
Pyz=Pyz';
