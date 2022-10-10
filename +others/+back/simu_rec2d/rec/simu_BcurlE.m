function [fx,fy,fz]=simu_BcurlE(Bx,By,Bz,Ex,Ey,Ez,dr)
%% this function used to calculate the B cross (curlE)
%%
%%-------------------written by Meng Zhou, at SDCC, Apr-13-2013-----------
if nargin<7, dr=1; end
%
[nz,nx]=size(Bx);
%%
[Epara,nb]=simu_Epara(Bx,By,Bz,Ex,Ey,Ez);
nbx=reshape(nb(:,:,1),nz,nx);
nby=reshape(nb(:,:,2),nz,nx);
nbz=reshape(nb(:,:,3),nz,nx);
Eparax=Epara.*nbx;
Eparay=Epara.*nby;
Eparaz=Epara.*nbz;
%%
%%----------------calculate curlE---------------------
[curlEx,curlEy,curlEz]=simu_curlB(Eparax,Eparay,Eparaz,dr,1);
%%
%%-----------------calculate B cross curlE-------------------
Bx=reshape(Bx,nz*nx,1);
By=reshape(By,nz*nx,1);
Bz=reshape(Bz,nz*nx,1);
curlEx=reshape(curlEx,nz*nx,1);
curlEy=reshape(curlEy,nz*nx,1);
curlEz=reshape(curlEz,nz*nx,1);
Btmp=[Bx,By,Bz];
Etmp=[curlEx,curlEy,curlEz];
ftmp=cross(Btmp,Etmp,2);
fx=ftmp(:,1);
fy=ftmp(:,2);
fz=ftmp(:,3);
fx=reshape(fx,nz,nx);
fy=reshape(fy,nz,nx);
fz=reshape(fz,nz,nx);
%%











