function fd = read_field(value, name, time)
%%
% @info: writen by Liangjin Song on 20210425
% @brief: read_field - read the field data, including scalar field, vector field, and so on
% @param: value - the member of Parameters object
% @param: name - the field name
% @param: time - the time step of the field
%%
filename=[name,'_t',num2str(time,'%06.2f'),'.bsd'];
if strcmp(name, 'Ehest0.1')
    fd = slj.Parameters.read_binary_file(filename, 'uint64');
    return;
end
if isfield(value,'reset')
    if value.reset
        nx=value.nx;
        ny=value.nz;
        nz=value.ny;
        reset=true;
    else
        nx=value.nx;
        ny=value.ny;
        nz=value.nz;
        reset=false;
    end
else
    nx=value.nx;
    ny=value.ny;
    nz=value.nz;
    reset=false;
end
fd=slj.Parameters.read_binary_file(filename, value.type);

%% reshape the data
switch name
    % scalar field
    case {'Ne', 'Nl', 'Nh', 'Nhe', 'Ni', 'stream', 'divE', 'divB', 'Nshi', 'Nshe', 'Nspi', 'Nspe', 'Nsph', 'Nsphe'}
        fd = reshape_scalar(fd, nx, ny, nz);
        fd = slj.Scalar(fd);
    case {'B', 'E', 'J', 'Vi', 'Ve', 'Vl', 'Vh', 'Vhe', 'Vshi', 'Vshe', 'Vspi', 'Vspe', 'Vsph', 'Vsphe', 'qfluxe', 'qfluxi', 'qfluxl', 'qfluxh'}
        fd = reshape_vector(fd, nx, ny, nz, reset);
        fd = slj.Vector(fd);
    case {'Pi', 'Pe', 'Pl', 'Ph', 'Phe', 'Pshi', 'Pshe', 'Pspi', 'Pspe', 'Psph', 'Psphe'}
        fd = reshape_tensor(fd, nx, ny, nz, reset);
        fd = slj.Tensor(fd);
    case {'spctrmh','spctrmi','spctrme','spctrml','spctrmhe'}
        fd=fd;
    otherwise
        error('Parameters error!');
end

end

%% ======================================================================== %%
function fd = reshape_scalar(v, nx, ny, nz)
%%
% @brief: reshape the 1-D fd as a Scalar
% @param: v - the 1-D data
% @param: nx, ny, nz - the box size 
% @return: fd - the scalar
%%
data=reshape(v,[nx,ny,nz]);
fd=zeros(ny,nx,nz);
for k=1:nz
    fd(:,:,k)=data(:,:,k)';
end
end

%% ======================================================================== %%
function fd = reshape_vector(v, nx, ny, nz, reset)
%%
% @brief: reshape the 1-D fd as a Vector 
% @param: v - the 1-D data
% @param: nx, ny, nz - the box size 
% @param: reset - whether the coordinate system has been rotated
% @return: fd - the vector 
%%
v=reshape(v,[nx*ny*nz,3,1]);
fd.x=reshape_scalar(v(:,1),nx,ny,nz);
if reset
    fd.y=-reshape_scalar(v(:,3),nx,ny,nz);
    fd.z=reshape_scalar(v(:,2),nx,ny,nz);
else
    fd.y=reshape_scalar(v(:,2),nx,ny,nz);
    fd.z=reshape_scalar(v(:,3),nx,ny,nz);
end
end

%% ======================================================================== %%
function fd = reshape_tensor(v, nx, ny, nz, reset)
%%
% @brief: reshape the 1-D fd as a Tensor
% @param: v - the 1-D data
% @param: nx, ny, nz - the box size 
% @param: reset - whether the coordinate system has been rotated
% @return: fd - the tensor
%%
t=reshape(v,[nx*ny*nz,6,1]);
if reset
    fd.xx=reshape_scalar(t(:,1),nx,ny,nz);
    fd.xy=-reshape_scalar(t(:,3),nx,ny,nz);
    fd.xz=reshape_scalar(t(:,2),nx,ny,nz);
    fd.yy=reshape_scalar(t(:,6),nx,ny,nz);
    fd.yz=-reshape_scalar(t(:,5),nx,ny,nz);
    fd.zz=reshape_scalar(t(:,4),nx,ny,nz);
else
    fd.xx=reshape_scalar(t(:,1),nx,ny,nz);
    fd.xy=reshape_scalar(t(:,2),nx,ny,nz);
    fd.xz=reshape_scalar(t(:,3),nx,ny,nz);
    fd.yy=reshape_scalar(t(:,4),nx,ny,nz);
    fd.yz=reshape_scalar(t(:,5),nx,ny,nz);
    fd.zz=reshape_scalar(t(:,6),nx,ny,nz);
end
end
