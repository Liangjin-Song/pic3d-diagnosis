function pp = reshape_old(obj, prm)
%%
% @info: writen by Liangjin Song on 20220820
% @brief: reshape_old -- reshape the structure of the data to the format the fortran type
% @param: obj -- the Tensor object
% @param: prm -- the Parameters
% @return: pp -- the reshaped data, pp = [xx, xy, xz, yy, yz, zz]
%%
nx=prm.value.nx;
if prm.value.reset
    ny=prm.value.nz;
    nz=prm.value.ny;
else
    ny=prm.value.ny;
    nz=prm.value.nz;
end
fd=[];
fd.xx=zeros(nx,ny,nz);
fd.xy=zeros(nx,ny,nz);
fd.xz=zeros(nx,ny,nz);
fd.yy=zeros(nx,ny,nz);
fd.yz=zeros(nx,ny,nz);
fd.zz=zeros(nx,ny,nz);
for k=1:nz
    fd.xx(:,:,k)=obj.xx(:,:,k)';
    fd.xy(:,:,k)=obj.xy(:,:,k)';
    fd.xz(:,:,k)=obj.xz(:,:,k)';
    fd.yy(:,:,k)=obj.yy(:,:,k)';
    fd.yz(:,:,k)=obj.yz(:,:,k)';
    fd.zz(:,:,k)=obj.zz(:,:,k)';
end

sz=nx*ny*nz;
pp=zeros(sz,6);
pp(:,1)=reshape(fd.xx, sz, 1);
pp(:,2)=reshape(fd.xy, sz, 1);
pp(:,3)=reshape(fd.xz, sz, 1);
pp(:,4)=reshape(fd.yy, sz, 1);
pp(:,5)=reshape(fd.yz, sz, 1);
pp(:,6)=reshape(fd.zz, sz, 1);
end