function fd=read_particle_distribution(obj, name)
%% writen by Liangjin Song on 20210329
% read particle distribution
%%
%% read data
fd=Species();
type=obj.value.type;
obj.value.type='uint64';
fd.value.id=read_binary_file(obj, [name,'_id.bsd']);
fd.value.id=fd.value.id';
obj.value.type=type;
prt=read_binary_file(obj, [name,'.bsd']);
prt=reshape_particle(prt,6);
fd.value.vx=prt(1,:);
fd.value.vy=-prt(3,:);
fd.value.vz=prt(2,:);
fd.value.rx=prt(4,:);
fd.value.ry=-prt(6,:);
fd.value.rz=prt(5,:);

%% resolve the name
[fd.name, fd.species] = resolve_particle_species(name);

%% resolve the time
fd.time.step = resolve_particle_time_step(name);
fd.time.normalized = fd.time.step*obj.value.wci;

%% resolve the xrange
fd.xrange.grids = resolve_particle_xrange(name);
fd.xrange.normalized=obj.value.lx(fd.xrange.grids);

%% resolve the zrange
fd.zrange.grids = resolve_particle_zrange(name);
fd.zrange.normalized=obj.value.lz(fd.zrange.grids);

%% resolve the yrange
if obj.value.ny > 1
    fd.yrange.grids = resolve_particle_yrange(name);
    fd.yrange.normalized=obj.value.ly(fd.yrange.grids);
end

end

%% ======================================================================== %%
%% reshape particle
function data=reshape_particle(data,nvar)
% the particle number
np=length(data)/nvar;
data=reshape(data,[nvar,np]);
end

%% ======================================================================== %%
%% resolve particle species
function [name, species] = resolve_particle_species(name)
if contains(name,'PVe')
    name='Ve';
    species=SpeciesType.Electron;
elseif contains(name,'PVi')
    name='Vi';
    species=SpeciesType.Ion;
elseif contains(name,'PVl')
    name='Vi';
    species=SpeciesType.Light_Ion;
elseif contains(name,'PVh')
    if contains(name,'PVhe')
        name='Ve';
        species=SpeciesType.Electron_with_Heavy_Ion;
    else
        name='Vic';
        species=SpeciesType.Heavy_Ion;
    end
end
end

%% ======================================================================== %%
%% resolve time
function ts = resolve_particle_time_step(name)
name = strsplit(name,'_');
time = char(name(2));
ts=str2num(time(3:end));
end

%% ======================================================================== %%
%% resolve xrange
function xrange=resolve_particle_xrange(name)
xrange=[0, 0];
name = strsplit(name,'_');
range = char(name(3));
range = strsplit(char(range),'-');
tmp=char(range(1));
xrange(1)=str2num(char(tmp(2:end)));
xrange(2)=str2num(char(range(2)));
end

%% resolve yrange
function zrange=resolve_particle_zrange(name)
zrange=[0, 0];
name = strsplit(name,'_');
range = char(name(4));
range = strsplit(char(range),'-');
tmp=char(range(1));
zrange(1)=str2num(char(tmp(2:end)));
zrange(2)=str2num(char(range(2)));
end

%% resolve yrange
function yrange=resolve_particle_yrange(name)
yrange=[0, 0];
name = strsplit(name,'_');
range = char(name(5));
range = strsplit(char(range),'-');
tmp=char(range(1));
yrange(1)=str2num(char(tmp(2:end)));
yrange(2)=str2num(char(range(2)));
end
