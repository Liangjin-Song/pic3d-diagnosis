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
        fd = reshape_scalar(fd, nx, ny, nz, value);
        fd = slj.Scalar(fd);
    case {'B', 'E', 'J', 'Vi', 'Ve', 'Vl', 'Vh', 'Vhe', 'Vshi', 'Vshe', 'Vspi', 'Vspe', 'Vsph', 'Vsphe', 'qfluxe', 'qfluxi', 'qfluxl', 'qfluxh'}
        fd = reshape_vector(fd, nx, ny, nz, reset, value);
        fd = slj.Vector(fd);
    case {'Pi', 'Pe', 'Pl', 'Ph', 'Phe', 'Pshi', 'Pshe', 'Pspi', 'Pspe', 'Psph', 'Psphe'}
        fd = reshape_tensor(fd, nx, ny, nz, reset, value);
        fd = slj.Tensor(fd);
    case {'spctrmh','spctrmi','spctrme','spctrml','spctrmhe'}
        fd=fd;
    case {'heste', 'hesti'}
        id = slj.Parameters.read_binary_file([name,'_t',num2str(time,'%06.2f'),'_id.bsd'], 'uint64');
        fd = high_energy_particles(fd, id, time, reset);
    otherwise
        error('Parameters error!');
end

end

%% ======================================================================== %%
function fd = reshape_scalar(v, nx, ny, nz, val)
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
if val.dimension == 3
    if val.reset
        fd = permute(fd, [3, 2, 1]);
    end
end
end

%% ======================================================================== %%
function fd = reshape_vector(v, nx, ny, nz, reset, val)
%%
% @brief: reshape the 1-D fd as a Vector 
% @param: v - the 1-D data
% @param: nx, ny, nz - the box size 
% @param: reset - whether the coordinate system has been rotated
% @return: fd - the vector 
%%
v=reshape(v,[nx*ny*nz,3,1]);
fd.x=reshape_scalar(v(:,1),nx,ny,nz, val);
if reset
    fd.y=-reshape_scalar(v(:,3),nx,ny,nz, val);
    fd.z=reshape_scalar(v(:,2),nx,ny,nz, val);
else
    fd.y=reshape_scalar(v(:,2),nx,ny,nz, val);
    fd.z=reshape_scalar(v(:,3),nx,ny,nz, val);
end
end

%% ======================================================================== %%
function fd = reshape_tensor(v, nx, ny, nz, reset, val)
%%
% @brief: reshape the 1-D fd as a Tensor
% @param: v - the 1-D data
% @param: nx, ny, nz - the box size 
% @param: reset - whether the coordinate system has been rotated
% @return: fd - the tensor
%%
t=reshape(v,[nx*ny*nz,6,1]);
if reset
    fd.xx=reshape_scalar(t(:,1),nx,ny,nz, val);
    fd.xy=-reshape_scalar(t(:,3),nx,ny,nz, val);
    fd.xz=reshape_scalar(t(:,2),nx,ny,nz, val);
    fd.yy=reshape_scalar(t(:,6),nx,ny,nz, val);
    fd.yz=-reshape_scalar(t(:,5),nx,ny,nz, val);
    fd.zz=reshape_scalar(t(:,4),nx,ny,nz, val);
else
    fd.xx=reshape_scalar(t(:,1),nx,ny,nz, val);
    fd.xy=reshape_scalar(t(:,2),nx,ny,nz, val);
    fd.xz=reshape_scalar(t(:,3),nx,ny,nz, val);
    fd.yy=reshape_scalar(t(:,4),nx,ny,nz, val);
    fd.yz=reshape_scalar(t(:,5),nx,ny,nz, val);
    fd.zz=reshape_scalar(t(:,6),nx,ny,nz, val);
end
end

%% ======================================================================== %%
function fd = high_energy_particles(v, id, time, reset)
%%
% @brief: read the high energy particles
% @param: v - the 1-D data
% @param: id - the particles' id
% @param: reset - whether the coordinate system has been rotated
% @return: fd - the high energy particles
%%
value.id=id';
nvar=7;
np=length(v)/nvar;
prt=reshape(v,[nvar,np]);
%%
value.vx=prt(1,:);
if reset
    value.vy=-prt(3,:);
    value.vz=prt(2,:);
else
    value.vy=prt(2,:);
    value.vz=prt(3,:);
end
value.rx=prt(4, :);
if reset
    value.ry=prt(6, :);
    value.rz=prt(5, :);
else
    value.ry=prt(5, :);
    value.rz=prt(6, :);
end
%% weight
value.weight=prt(7,:);
fd = slj.Species('high energy', time, 1, value);
end