function data=pic3d_read_data(name,time,varargin)
%% writen by Liangjin Song on 20200908
% read the binary data of pic3d simualtion
%
% name is the physical quantity name, and it is a string.
% time is the time.
% tp is the type of the data. It is a string, and it may be a scalar('scalar'), a vector('vector'), or a tensor('tensor')
% varargin including nx ny nz are the three-dimensional box size
%%

% Check the number of parameters
if nargin ~= 2 && nargin~=5 && nargin ~= 6 && nargin ~= 1
    fprintf('\nParameters error!\n\n');
    fprintf('Usage: \n\n');
    fprintf('\t fd=pic3d_read_data(varname,time) \n \t fd=pic3d_read_data(varname,time, nx, ny, nz)\n \t fd=pic3d_read_data(varname,time,nx,ny,nz,tp)\n\n');
    return;
end
if nargin==1
    data=particle_distribution(name);
elseif nargin == 2
    if strcmp(name,'Prti') || strcmp(name,'Prte')
        data=particle(name,time);
    elseif strcmp(name,'spctrme') || strcmp(name,'spctrmi') || strcmp(name,'spctrmh') || strcmp(name,'spctrmhe') || strcmp(name,'spctrml')
        data=field(name,time);
    end
elseif nargin == 5
    nx=varargin{1};
    ny=varargin{2};
    nz=varargin{3};
    if strcmp(name,'Ni') || strcmp(name,'Ne') || strcmp(name,'stream') || strcmp(name,'divB') || strcmp(name,'divJ') || strcmp(name,'divE') || strcmp(name,'Nl') || strcmp(name,'Nh') || strcmp(name,'Nhe') || strcmp(name,'Nshi') || strcmp(name,'Nshe') || strcmp(name,'Nspi') || strcmp(name,'Nspe') || strcmp(name,'Nsph') || strcmp(name,'Nsphe')
        data=field(name,time);
        data=scalar(data,nx,ny,nz);
    elseif strcmp(name,'B') || strcmp(name,'E') || strcmp(name,'J') || strcmp(name,'Vi') || strcmp(name,'Ve') || strcmp(name,'Vh') || strcmp(name,'Vhe') || strcmp(name,'Vl') || strcmp(name,'Amp') || strcmp(name,'qfluxi') || strcmp(name,'qfluxe') || strcmp(name,'qfluxh') || strcmp(name,'qfluxhe') || strcmp(name,'Vshi') || strcmp(name,'Vshe') || strcmp(name,'Vspi') || strcmp(name,'Vspe') || strcmp(name,'Vsph') || strcmp(name,'Vsphe') ...
             || strcmp(name,'qfluxi') || strcmp(name,'qfluxe') || strcmp(name,'qfluxl') || strcmp(name,'qfluxh')
        data=field(name,time);
        data=vector(data,nx,ny,nz);
    elseif strcmp(name,'Pi') || strcmp(name,'Pe') || strcmp(name,'Pl') || strcmp(name,'Ph') || strcmp(name,'Phe')
        data=field(name,time);
        data=tensor(data,nx,ny,nz);
    elseif strcmp(name,'Ohm')
        data=field(name,time);
        data=ohm(data,nx,ny,nz);
    end
elseif nargin==6
    nx=varargin{1};
    ny=varargin{2};
    nz=varargin{3};
    tp=varargin{4};
    data=field(name,time);
    if strcmp(tp,'scalar')
        data=scalar(data,nx,ny,nz);
    elseif strcmp(tp,'vector')
        data=vector(data,nx,ny,nz);
    elseif strcmp(tp,'tensor')
        data=tensor(data,nx,ny,nz);
    end
end
end

%% read the field data
function data=field(name, time)
type='float';
fid=fopen([name,'_t',num2str(time,'%06.2f'),'.bsd'],'rb');
data=fread(fid,Inf,type);
fclose(fid);
end

%% read the particle data
function data=particle(name,time)
type='float';
fid=fopen([name,'_ts',num2str(time),'.bsd'],'rb');
prt=fread(fid,Inf,type);
fclose(fid);
prt=reshape_particle(prt,6);
% velocity
data.vx=prt(1,:);
data.vy=prt(2,:);
data.vz=prt(3,:);
% position
data.rx=prt(4,:)-2;
data.ry=prt(5,:)-2;
data.rz=prt(6,:)-2;
end

%% read the particle distribution function data
function data=particle_distribution(name)
type='uint64';
fid=fopen([name,'_id.bsd'],'rb');
data.id=uint64(fread(fid,Inf,type)');
fclose(fid);
type='float';
fid=fopen([name,'.bsd'],'rb');
prt=fread(fid,Inf,type);
fclose(fid);
prt=reshape_particle(prt,6);
data.vx=prt(1,:);
data.vy=-prt(3,:);
data.vz=prt(2,:);
data.rx=prt(4,:);
data.ry=prt(5,:);
data.rz=prt(6,:);
end

%% reshape particle
function data=reshape_particle(data,nvar)
% the particle number
np=length(data)/nvar;
data=reshape(data,[nvar,np]);
end

%% the data is a scalar
function fd=scalar(s,nx,ny,nz)
fd=reshape(s,[nx,ny,nz]);
data=zeros(ny,nx,nz);
for k=1:nz
    data(:,:,k)=fd(:,:,k)';
end
fd=data;
end

%% the data is a vector
function fd=vector(v,nx,ny,nz)
v=reshape(v,[nx*ny*nz,3,1]);
fd.x=scalar(v(:,1),nx,ny,nz);
fd.z=scalar(v(:,2),nx,ny,nz);
fd.y=-scalar(v(:,3),nx,ny,nz);
end

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

%% the ohm's law data
function fd=ohm(t,nx,ny,nz)
t=reshape(t,[nx*ny*nz,5,3]);

% electric field
fd.E.x=scalar(t(:,1,1),nx,ny,nz);
fd.E.y=scalar(t(:,1,2),nx,ny,nz);
fd.E.z=scalar(t(:,1,3),nx,ny,nz);

% ion frozen-in term
fd.frozen.x=scalar(t(:,2,1),nx,ny,nz);
fd.frozen.y=scalar(t(:,2,2),nx,ny,nz);
fd.frozen.z=scalar(t(:,2,3),nx,ny,nz);

% hall term
fd.Hall.x=scalar(t(:,3,1),nx,ny,nz)-fd.frozen.x;
fd.Hall.y=scalar(t(:,3,2),nx,ny,nz)-fd.frozen.y;
fd.Hall.z=scalar(t(:,3,3),nx,ny,nz)-fd.frozen.z;

% electron pressure gradient term
fd.Pgrad.x=scalar(t(:,4,1),nx,ny,nz);
fd.Pgrad.y=scalar(t(:,4,2),nx,ny,nz);
fd.Pgrad.z=scalar(t(:,4,3),nx,ny,nz);

% electron inertia term
fd.inertia.x=scalar(t(:,5,1),nx,ny,nz);
fd.inertia.y=scalar(t(:,5,2),nx,ny,nz);
fd.inertia.z=scalar(t(:,5,3),nx,ny,nz);
end
