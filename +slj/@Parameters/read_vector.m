function fd = read_vector(value, name)
%%
% @info: writen by Liangjin Song on 20210501
% @brief: read_vector - read the 1-D data
% @param: value - the member of Parameters object
% @param: name - the filename information
% @return: fd - the simulation data
%%
if strcmp(name(1:4),'traj')
    fd = particle_trajectory(name, value);
elseif strcmp(name(1:2), 'PV')
    fd = distribution_function(name, value);
elseif strcmp(name(1:2), 'en')
    fd = slj.Parameters.read_binary_file([name,'.bsd'], 'uint64');
else
    error('Parameters error!');
end
end

%% ======================================================================== %%
function fd = particle_trajectory(name, val)
%%
% @brief: read the particle's trajectory
% @param: name - the filename information
% @param: val - the member of Parameters object
% @return: fd - the particle information
%%
info=split(name,'_');
id=char(info(2));
id=uint64(str2num(id(3:end)));
data=load([name,'.dat']);
info=char(info(1));

if strcmp(info, 'trajh')
    q=val.qh;
    m=val.mh;
elseif strcmp(info,'trajl')
    q=val.ql;
    m=val.ml;
elseif strcmp(info,'traje')
    q=val.qe;
    m=val.me;
elseif strcmp(info,'trajhe')
    q=val.qe;
    m=val.me;
elseif strcmp(info,'traji')
    q=val.qi;
    m=val.mi;
else
    error('Parameters error!');
end

value.time=data(:,1);
value.rx=slj.Physics.linear([1, 0],[val.nx, val.Lx],data(:,2));
value.vx=data(:,5);
value.ex=data(:,8);
value.bx=data(:,11);
if val.reset
    if val.ny>1
        value.ry=-slj.Physics.linear([1, 0],[val.ny, val.Ly],data(:,4));
    end
    value.rz=slj.Physics.linear([1, -val.Lz/2],[val.nz, val.Lz/2],data(:,3));
    value.vy=-data(:,7);
    value.vz=data(:,6);
    value.ez=data(:,9);
    value.ey=-data(:,10);
    value.bz=data(:,12);
    value.by=-data(:,13);
else
    if val.nz>1
        value.rz=slj.Physics.linear([1, 0],[val.nz, val.Lz],data(:,4));
    end
    value.ry=slj.Physics.linear([1, -val.Ly/2],[val.ny, val.Ly/2],data(:,3));
    value.vy=data(:,6);
    value.vz=data(:,7);
    value.ey=data(:,9);
    value.ez=data(:,10);
    value.by=data(:,12);
    value.bz=data(:,13);
end
value.k=data(:,14);
value.kappa=data(:,15);
w=data(1,16);
fd=slj.Particle(id, q, m, w, value);
fd=fd.calculation();
end

%% ======================================================================== %%
function fd = distribution_function(name, val)
%%
% @brief: read the distribution function
% @param: name - the file name
% @param: val - the member of Parameters object
% @return: fd - the Species type, including the particle information
%%
%% resolve parameters
term = strsplit(name,'_');
% resolve the time
time = char(term(2));
time=str2num(time(3:end))*val.w;
% resolve xrange
xrange=[0, 0];
range = char(term(3));
range = strsplit(char(range),'-');
tmp=char(range(1));
xrange(1)=str2num(char(tmp(2:end)))+1;
xrange(2)=str2num(char(range(2)));
% resolve yrange
yrange=[0, 0];
range = char(term(4));
range = strsplit(char(range),'-');
tmp=char(range(1));
yrange(1)=str2num(char(tmp(2:end)))+1;
yrange(2)=str2num(char(range(2)));
% resolve zrange
zrange=[0, 0];
range = char(term(5));
range = strsplit(char(range),'-');
tmp=char(range(1));
zrange(1)=str2num(char(tmp(2:end)))+1;
zrange(2)=str2num(char(range(2)));
range=[];
%% normalization
if val.dimension == 3
    range.x=val.lx(xrange);
    if val.reset
       range.y=val.ly(zrange); 
       range.z=val.lz(yrange); 
    else
       range.y=val.ly(yrange); 
       range.z=val.lz(zrange); 
    end
elseif val.dimension == 2
    range.x=val.lx(xrange);
    if val.reset
       range.z=val.lz(yrange); 
    else
       range.y=val.ly(yrange); 
    end
elseif val.dimension == 1
    range.x=val.lx(xrange);
else
    error('Parameters error!');
end
%% read the data
value=[];
value.id=slj.Parameters.read_binary_file([name,'_id.bsd'], 'uint64');
value.id=value.id';
prt=slj.Parameters.read_binary_file([name,'.bsd'],val.type);
nvar=7;
np=length(prt)/nvar;
prt=reshape(prt,[nvar,np]);
%% reshape the data
% velocity
value.vx=prt(1,:);
if val.reset
    value.vy=-prt(3,:);
    value.vz=prt(2,:);
else
    value.vy=prt(2,:);
    value.vz=prt(3,:);
end
% position
value.rx=slj.Physics.linear([1,val.lx(1)],[length(val.lx),val.lx(end)],prt(4,:));
if val.dimension == 3
    if val.reset
        value.ry=slj.Physics.linear([1,val.ly(1)],[length(val.ly),val.ly(end)],prt(6,:));
        value.rz=slj.Physics.linear([1,val.lz(1)],[length(val.lz),val.lz(end)],prt(5,:));
    else
        value.ry=slj.Physics.linear([1,val.ly(1)],[length(val.ly),val.ly(end)],prt(5,:));
        value.rz=slj.Physics.linear([1,val.lz(1)],[length(val.lz),val.lz(end)],prt(6,:));
    end
elseif val.dimension == 2
    if val.reset
        value.ry=prt(6,:);
        value.rz=slj.Physics.linear([1,val.lz(1)],[length(val.lz),val.lz(end)],prt(5,:));
    else
        value.ry=slj.Physics.linear([1,val.ly(1)],[length(val.ly),val.ly(end)],prt(5,:));
        value.rz=prt(6,:);
    end
elseif val.dimension == 1
    value.ry=prt(5,:);
    value.rz=prt(6,:);
end
%% weight
value.weight=prt(7,:);
fd = slj.Species(name, time, range, value);
end
