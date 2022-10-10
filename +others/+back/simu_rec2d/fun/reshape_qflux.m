function [qfx,qfy,qfz]=reshape_qflux(qflux,Row,Column)
%% reshap the heat flux 
% writen by Liangjin Song on 20190522
%   qflux is the heat flux 
%   Row is size(fd,1)
%   Column is size(fd,2)
%
%   qfx, qfy, qfz are heat flux vector
%%
qfx=qflux(:,1);
qfx=reshape(qfx,Column,Row);
qfx=qfx';

qfy=qflux(:,2);
qfy=reshape(qfy,Column,Row);
qfy=qfy';

qfz=qflux(:,3);
qfz=reshape(qfz,Column,Row);
qfz=qfz';
