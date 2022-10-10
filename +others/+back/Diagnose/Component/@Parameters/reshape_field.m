function fd=reshape_field(obj, fd, type)
%% writen by Liangjin Song on 20210326
% reshape the field
%%
nx=obj.value.nx;
ny=obj.value.nz;
nz=obj.value.ny;
if type == FieldType.Scalar
    fd=scalar(fd,nx,ny,nz);
elseif type == FieldType.Stream
    fd=scalar(fd,nx,ny,nz);
elseif type == FieldType.Vector
    fd=vector(fd,nx,ny,nz);
elseif type == FieldType.Tensor
    fd=tensor(fd,nx,ny,nz);
else
    error('Parameters error!');
end
end

%% ======================================================================== %%
%% the field is a scalar
function fd=scalar(s,nx,ny,nz)
fd=reshape(s,[nx,ny,nz]);
data=zeros(ny,nx,nz);
for k=1:nz
    data(:,:,k)=fd(:,:,k)';
end
fd=data;
end

%% ======================================================================== %%
%% the data is a vector
function fd=vector(v,nx,ny,nz)
v=reshape(v,[nx*ny*nz,3,1]);
fd.x=scalar(v(:,1),nx,ny,nz);
fd.y=-scalar(v(:,3),nx,ny,nz);
fd.z=scalar(v(:,2),nx,ny,nz);
end

%% ======================================================================== %%
%% the data is a tensor
function fd=tensor(t,nx,ny,nz)
t=reshape(t,[nx*ny*nz,6,1]);
% fd.xx=scalar(t(:,1),nx,ny,nz);
% fd.xy=scalar(t(:,2),nx,ny,nz);
% fd.xz=scalar(t(:,3),nx,ny,nz);
% fd.yy=scalar(t(:,4),nx,ny,nz);
% fd.yz=scalar(t(:,5),nx,ny,nz);
% fd.zz=scalar(t(:,6),nx,ny,nz);
fd.xx=scalar(t(:,1),nx,ny,nz);
fd.xy=-scalar(t(:,3),nx,ny,nz);
fd.xz=scalar(t(:,2),nx,ny,nz);
fd.yy=scalar(t(:,6),nx,ny,nz);
fd.yz=-scalar(t(:,5),nx,ny,nz);
fd.zz=scalar(t(:,4),nx,ny,nz);
end
