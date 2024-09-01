function value = resolve(obj)
%%
% @info: writen by Liangjin Song on 20210425
% @brief: resolve - read the parameters.dat file, extract the parameters
% @param: obj - the Parameters object
% @return: value - the structure containing the parameters
%%
value=[];
cd(obj.indir);

%% read the commom parameters
cmd='value=commom_paramaters(value, key, word);';
value=for_parameters(cmd, value);
if ~isfield(value, 'model')
    error('Parameters error: missing model parameter');
end
n1=0;
if value.nx == 1
    n1=n1+1;
end
if value.ny == 1
    n1=n1+1;
end
if value.nz == 1
    n1=n1+1;
end
if n1 == 0
    value.dimension=3;
elseif n1 == 1
    value.dimension=2;
elseif n1 == 2
    value.dimension=1;
else
    value.dimension=0;
end

%% extract the parameters according to the simulation model
if strcmp(value.model, 'rec3s-1harris')
    cmd='value=resolve_rec3s_1harris(value, key, word);';
    value=for_parameters(cmd, value);
    value=reset_system_size(value);
    value=length_scale(value);
elseif strcmp(value.model, 'wave-particle')
    cmd='value=resolve_wave_particle(value, key, word);';
    value=for_parameters(cmd, value);
    % value=length_scale(value);
    value.Lx=value.nx/value.debye;
    value.lx=linspace(0, value.Lx, value.nx);
    value.reset=false;
elseif strcmp(value.model, 'asym_rec_3s')
    cmd='value=resolve_asym_rec_3s(value, key, word);';
    value=for_parameters(cmd, value);
    value=reset_system_size(value);
    value=length_scale(value);
elseif strcmp(value.model, 'rec-2harris')
    cmd='value=resolve_rec_2harris(value, key, word);';
    value=for_parameters(cmd, value);
    value=reset_system_size(value);
    value=length_scale(value);
elseif strcmp(value.model, 'rec-1harris')
    cmd='value=resolve_rec_2harris(value, key, word);';
    value=for_parameters(cmd, value);
    value=reset_system_size(value);
    value=length_scale(value);
elseif strcmp(value.model, 'asym_rec_3s_slj') || strcmp(value.model, 'asym_rec_3s_slj2')
    cmd='value=resolve_asym_rec_3s_slj(value, key, word);';
    value=for_parameters(cmd, value);
    value.n0=(value.nts+value.ntm)/2;
    value=reset_system_size(value);
    value=length_scale(value);
elseif strcmp(value.model, 'turbulence')
    cmd='value=resolve_turbulence(value, key, word);';
    value=for_parameters(cmd, value);
    value=reset_system_size(value);
    value=length_scale(value, value.di);
elseif strcmp(value.model, 'asym-rec')
    cmd='value=resolve_asym_rec(value, key, word);';
    value=for_parameters(cmd, value);
    value=reset_system_size(value);
    value=length_scale(value);
elseif strcmp(value.model, 'rec-electron-current')
    cmd='value=resolve_rec_electron_current(value, key, word);';
    value=for_parameters(cmd, value);
    value=reset_system_size(value);
    value=length_scale(value);
elseif strcmp(value.model, 'shock')
    cmd='value=resolve_shock(value, key, word);';
    value=for_parameters(cmd, value);
    value=reset_system_size(value);
    value=length_scale(value);
else
    error(['Unrecognized model: ',value.model]);
end
end

%% ======================================================================== %%
function value=for_parameters(cmd, value)
%%
% @brief: read each line in the parameters.dat file in a loop
% @param: cmd - a string containing the command, it receive three parameters: value, key, word
% @param: value - the structure containing the parameters
% @return: value - the structure containing the parameters
%%
%% read the commom parameters
filename='parameters.dat';
fid=fopen(filename);
while ~feof(fid)
    line = fgetl(fid);
    dict = strsplit(line,'=');
    if length(dict) == 2
        % extract the parameters
        key=char(strtrim(string(dict(1))));
        word=char(strtrim(string(dict(2))));
        eval(cmd);
    end
end
fclose(fid);
end

%% ======================================================================== %%
function value=commom_paramaters(value, key, word)
%%
% @brief: read the public parameters
% @param: value - the structure containing the parameters
% @param: key - a string indicating the term
% @param: word - a string indicating the value
%%
if strcmp(key, 'simulation model')
    value.model=word;
elseif strcmp(key, 'boundary condition')
    value.boundary=resolve_boundary_condition(string(word));
elseif strcmp(key,'length in the x direction')
    value.nx=str2double(word);
elseif strcmp(key,'length in the y direction')
    value.ny=str2double(word);
elseif strcmp(key,'length in the z direction')
    value.nz=str2double(word);
elseif strcmp(key,'speed of light')
    value.c=str2double(word);
end
end

%% ======================================================================== %%
function bnd=resolve_boundary_condition(word)
%%
% @brief: extract the boundary condition
% @param: word - a string containing the boundary condition
% @return: bnd - a structure containing the boundary condition
%%
bnd=[];
tmp=strsplit(word,'(');
tmp=tmp(2);
tmp=strsplit(tmp,')');
tmp=strsplit(tmp(1),',');
bmp=strsplit(tmp(1),':');
bnd.x=char(strtrim(bmp(2)));
bmp=strsplit(tmp(2),':');
bnd.y=char(strtrim(bmp(2)));
bmp=strsplit(tmp(3),':');
bnd.z=char(strtrim(bmp(2)));
end

%% ======================================================================== %%
function value=reset_system_size(value)
%%
% @brief: swap ny and nz
% @param: value - the parameters structure containing system size
% @return: value - the parameters structure
%%
if value.dimension <= 3
    ny=value.nz;
    value.nz=value.ny;
    value.ny=ny;
    value.reset=true;
end
end

%% ======================================================================== %%
function value=length_scale(value, ds)
%%
% @brief: set the vector in three direction
% @param: value - the parameters structure containing system size
% @param: ds - the length scale should be normalized, default is ion inertial length
% @return: value - the parameters structure
%%
if nargin == 1
    ds=value.di;
end
if value.nx > 1
    value.Lx=value.nx/ds;
    value.lx=linspace(0, value.Lx, value.nx);
end
if value.ny > 1
    value.Ly=value.ny/ds;
    value.ly=linspace(0, value.Ly, value.ny);
end
if value.nz > 1
    value.Lz=value.nz/ds;
    value.lz=linspace(-value.Lz/2, value.Lz/2, value.nz);
end
end

%% ======================================================================== %%
function value=resolve_rec3s_1harris(value, key, word)
%%
% @brief: read the parameters of rec3s-1harris model
% @param: value - the structure containing the parameters
% @param: key - a string indicating the term
% @param: word - a string indicating the value
%%
if strcmp(key, 'simulation model') || strcmp(key, 'boundary condition') || strcmp(key,'length in the x direction') || strcmp(key,'length in the y direction') || strcmp(key,'length in the z direction') || strcmp(key,'speed of light')
elseif strcmp(key, 'mass ratio between light ion and electron')
    value.mle=str2double(word);
    value.mie=value.mle;
elseif strcmp(key, 'mass ratio between heavy ion and light ion')
    value.mhl=str2double(word);
elseif strcmp(key,'charge ratio between heavy ion and light ion')
    value.qhl=str2double(word);
elseif strcmp(key,'background density ratio between heavy ion and light ion')
    value.bhl=str2double(word);
elseif strcmp(key,'temperature ratio between light ion and electron')
    value.tle=str2double(word);
elseif strcmp(key,'temperature ratio between heavy ion and light ion')
    value.thl=str2double(word);
elseif strcmp(key,'beta value in the magneotsheath')
    value.betas=str2double(word);
elseif strcmp(key,'ratio between electron plasma frequency and electron gyrofrequency')
    value.rpg=str2double(word);
elseif strcmp(key,'magnetosphere electron temperature')
    value.tem=str2double(word);
elseif strcmp(key,'magnetosheath electron temperature')
    value.tes=str2double(word);
elseif strcmp(key,'asympotic magnetosphere magnetic field')
    value.bm=str2double(word);
elseif strcmp(key,'asympotic magnetosheath magnetic field')
    value.bs=str2double(word);
elseif strcmp(key,'guide field')
    value.bg=str2double(word);
elseif strcmp(key,'initial perturbation')
    value.perturb=str2double(word);
elseif strcmp(key,'heavy ion inertial length')
    value.dh=str2double(word);
elseif strcmp(key,'light ion inertial length')
    value.dl=str2double(word);
    value.di=value.dl;
elseif strcmp(key,'electron inertial length')
    value.de=str2double(word);
elseif strcmp(key,'halfthickness of current sheet')
    value.hcs=str2double(word);
elseif strcmp(key,'light ion density in magnetosphere side')
    value.nlm=str2double(word);
elseif strcmp(key,'density in magnetosphere side')
    value.nim=str2double(word);
elseif strcmp(key,'light ion density in magnetosheath side')
    value.nls=str2double(word);
elseif strcmp(key,'density in magnetosheath side')
    value.nis=str2double(word);
elseif strcmp(key,'number of light ion in current sheet')
    value.nlcs=str2double(word);
    value.n0=value.nlcs;
elseif strcmp(key,'number of particles in current sheet')
    value.n0=str2double(word);
elseif strcmp(key,'number of light ion per cell')
    value.ppcl=str2double(word);
elseif strcmp(key,'number of particles per cell')
    value.ppc=str2double(word);
elseif strcmp(key,'number of heavy ion per cell')
    value.ppch=str2double(word);
elseif strcmp(key,'number of particles representing unit density')
    value.coeff=str2double(word);
elseif strcmp(key,'density ratio between light ion background and Harris')
    value.rbh=str2double(word);
elseif strcmp(key,'density ratio between background and Harris')
    value.rbh=str2double(word);
elseif strcmp(key,'electron plasma frequency')
    value.fpe=str2double(word);
elseif strcmp(key,'electron gyrofrequency')
    value.fce=str2double(word);
elseif strcmp(key,'light ion plasma frequency')
    value.fpl=str2double(word);
    value.fpi=value.fpl;
elseif strcmp(key,'light ion gyrofrequency')
    value.fcl=str2double(word);
    value.wci=value.fcl;
    value.w=value.wci;
elseif strcmp(key,'heavy ion plasma frequency')
    value.fph=str2double(word);
elseif strcmp(key,'heavy ion gyrofrequency')
    value.fch=str2double(word);
elseif strcmp(key,'mass of electron')
    value.me=str2double(word);
elseif strcmp(key,'charge of electron')
    value.qe=str2double(word);
elseif strcmp(key,'mass of light ion')
    value.ml=str2double(word);
    value.mi=value.ml;
elseif strcmp(key,'charge of light ion')
    value.ql=str2double(word);
    value.qi=value.ql;
elseif strcmp(key,'mass of heavy ion')
    value.mh=str2double(word);
elseif strcmp(key,'charge of heavy ion')
    value.qh=str2double(word);
elseif strcmp(key,'electron thermal velocity')
    value.veth=str2double(word);
elseif strcmp(key,'light ion thermal velocity')
    value.vlth=str2double(word);
elseif strcmp(key,'heavy ion thermal velocity')
    value.vhth=str2double(word);
elseif strcmp(key,'debye length')
    value.debye=str2double(word);
elseif strcmp(key,'heavy ion lamor radius')
    value.rlh=str2double(word);
elseif strcmp(key,'light ion lamor radius')
    value.rll=str2double(word);
elseif strcmp(key,'electron lamor radius')
    value.rle=str2double(word);
elseif strcmp(key,'electron alfven speed')
    value.vAe=str2double(word);
elseif strcmp(key,'light ion alfven speed')
    value.vAl=str2double(word);
    value.vA=value.vAl;
elseif strcmp(key,'magnetosheath ion alfven speed')
    value.vA=str2double(word);
elseif strcmp(key,'heavy ion alfven speed')
    value.vAh=str2double(word);
else
    error(['Unrecognized key: ',char(key)]);
end
end

%% ======================================================================== %%
function value=resolve_wave_particle(value, key, word)
%%
% @brief: read the parameters of wave-particle model
% @param: value - the structure containing the parameters
% @param: key - a string indicating the term
% @param: word - a string indicating the value
%%
if strcmp(key, 'simulation model') || strcmp(key, 'boundary condition') || strcmp(key,'length in the x direction') || strcmp(key,'length in the y direction') || strcmp(key,'length in the z direction') || strcmp(key,'speed of light')
elseif strcmp(key, 'mass ratio between ion and electron')
    value.mie=str2double(word);
elseif strcmp(key, 'temperature ratio between ion and electron')
    value.tie=str2double(word);
elseif strcmp(key,'ratio between electron plasma frequency and electron gyrofrequency')
    value.rpg=str2double(word);
elseif strcmp(key,'beta value')
    value.beta=str2double(word);
elseif strcmp(key,'magnetic field')
elseif strcmp(key,'ion inertial length')
    value.di=str2double(word);
elseif strcmp(key,'electron inertial length')
    value.de=str2double(word);
elseif strcmp(key, 'number density of plasma')
    value.np=str2double(word);
elseif strcmp(key,'number of particles per cell')
    value.ppc=str2double(word);
elseif strcmp(key,'number of particles representing unit density')
    value.coeff=str2double(word);
elseif strcmp(key,'electron plasma frequency')
    value.fpe=str2double(word);
elseif strcmp(key,'electron gyrofrequency')
    value.fce=str2double(word);
    value.w=value.fce;
elseif strcmp(key,'ion plasma frequency')
    value.fpi=str2double(word);
elseif strcmp(key,'ion gyrofrequency')
    value.wci=str2double(word);
elseif strcmp(key,'mass of electron')
    value.me=str2double(word);
elseif strcmp(key,'charge of electron')
    value.qe=str2double(word);
elseif strcmp(key,'mass of ion')
    value.mi=str2double(word);
elseif strcmp(key,'charge of ion')
    value.qi=str2double(word);
elseif strcmp(key,'electron thermal velocity')
    value.veth=str2double(word);
elseif strcmp(key,'ion thermal velocity')
    value.vith=str2double(word);
elseif strcmp(key,'debye length')
    value.debye=str2double(word);
elseif strcmp(key,'ion lamor radius')
    value.rli=str2double(word);
elseif strcmp(key,'electron lamor radius')
    value.rle=str2double(word);
elseif strcmp(key,'ion alfven speed')
    value.vA=str2double(word);
else
    error(['Unrecognized key: ',char(key)]);
end
end

%% ======================================================================== %%
function value=resolve_asym_rec_3s(value, key, word)
%%
% @brief: read the parameters of asym_rec_3s model
% @param: value - the structure containing the parameters
% @param: key - a string indicating the term
% @param: word - a string indicating the value
%%
if strcmp(key, 'simulation model') || strcmp(key, 'boundary condition') || strcmp(key,'length in the x direction') || strcmp(key,'length in the y direction') || strcmp(key,'length in the z direction') || strcmp(key,'speed of light')
elseif strcmp(key, 'mass ratio between light ion and electron')
    value.mle=str2double(word);
    value.mie=value.mle;
elseif strcmp(key, 'mass ratio between heavy ion and light ion')
    value.mhl=str2double(word);
elseif strcmp(key,'charge ratio between heavy ion and light ion')
    value.qhl=str2double(word);
elseif strcmp(key,'temperature ratio between light ion and electron')
    value.tle=str2double(word);
elseif strcmp(key,'temperature ratio between heavy ion and light ion')
    value.thl=str2double(word);
elseif strcmp(key,'ratio between electron plasma frequency and electron gyrofrequency')
    value.rpg=str2double(word);
elseif strcmp(key,'magnetosphere electron temperature')
    value.tem=str2double(word);
elseif strcmp(key,'magnetosheath electron temperature')
    value.tes=str2double(word);
elseif strcmp(key,'magnetosphere light ion temperature')
    value.tlm=str2double(word);
elseif strcmp(key,'magnetosheath light ion temperature')
    value.tls=str2double(word);
elseif strcmp(key,'magnetosphere heavy ion temperature')
    value.thm=str2double(word);
elseif strcmp(key,'asympotic magnetosphere magnetic field')
    value.bm=str2double(word);
elseif strcmp(key,'asympotic magnetosheath magnetic field')
    value.bs=str2double(word);
elseif strcmp(key,'guide field')
    value.bg=str2double(word);
elseif strcmp(key,'initial perturbation')
    value.perturb=str2double(word);
elseif strcmp(key,'heavy ion inertial length')
    value.dh=str2double(word);
elseif strcmp(key,'light ion inertial length')
    value.dl=str2double(word);
    value.di=value.dl;
elseif strcmp(key,'electron inertial length')
    value.de=str2double(word);
elseif strcmp(key,'halfthickness of current sheet')
    value.hcs=str2double(word);
elseif strcmp(key,'total ion density in magnetosphere side')
    value.ntm=str2double(word);
elseif strcmp(key,'total ion density in magnetosheath side')
    value.nts=str2double(word);
elseif strcmp(key,'light ion density in magnetosphere side')
    value.nlm=str2double(word);
elseif strcmp(key,'light ion density in magnetosheath side')
    value.nls=str2double(word);
elseif strcmp(key,'heavy ion density in magnetosphere side')
    value.nhm=str2double(word);
elseif strcmp(key,'number of light ion per cell')
    value.ppc=str2double(word);
elseif strcmp(key,'number of particles representing unit density')
    value.coeff=str2double(word);
elseif strcmp(key,'electron plasma frequency')
    value.fpe=str2double(word);
elseif strcmp(key,'electron gyrofrequency')
    value.fce=str2double(word);
elseif strcmp(key,'light ion plasma frequency')
    value.fpl=str2double(word);
    value.fpi=value.fpl;
elseif strcmp(key,'light ion gyrofrequency')
    value.fcl=str2double(word);
    value.wci=value.fcl;
    value.w=value.wci;
elseif strcmp(key,'heavy ion plasma frequency')
    value.fph=str2double(word);
elseif strcmp(key,'heavy ion gyrofrequency')
    value.fch=str2double(word);
elseif strcmp(key,'mass of electron')
    value.me=str2double(word);
elseif strcmp(key,'charge of electron')
    value.qe=str2double(word);
elseif strcmp(key,'mass of light ion')
    value.ml=str2double(word);
    value.mi=value.ml;
elseif strcmp(key,'charge of light ion')
    value.ql=str2double(word);
    value.qi=value.ql;
elseif strcmp(key,'mass of heavy ion')
    value.mh=str2double(word);
elseif strcmp(key,'charge of heavy ion')
    value.qh=str2double(word);
elseif strcmp(key,'electron thermal velocity')
    value.veth=str2double(word);
elseif strcmp(key,'light ion thermal velocity')
    value.vlth=str2double(word);
elseif strcmp(key,'heavy ion thermal velocity')
    value.vhth=str2double(word);
elseif strcmp(key,'debye length')
    value.debye=str2double(word);
elseif strcmp(key,'heavy ion lamor radius')
    value.rlh=str2double(word);
elseif strcmp(key,'light ion lamor radius')
    value.rll=str2double(word);
elseif strcmp(key,'electron lamor radius')
    value.rle=str2double(word);
elseif strcmp(key,'light ion alfven speed')
    value.vAl=str2double(word);
    value.vA=value.vAl;
else
    error(['Unrecognized key: ',char(key)]);
end
end

function value=resolve_rec_2harris(value, key, word)
%%
% @brief: read the parameters of rec_2harris model
% @param: value - the structure containing the parameters
% @param: key - a string indicating the term
% @param: word - a string indicating the value
%%
if strcmp(key, 'simulation model') || strcmp(key, 'boundary condition') || strcmp(key,'length in the x direction') || strcmp(key,'length in the y direction') || strcmp(key,'length in the z direction') || strcmp(key,'speed of light')
elseif strcmp(key, 'mass ratio between ion and electron')
    value.mie=str2double(word);
elseif strcmp(key,'temperature ratio between ion and electron')
    value.tie=str2double(word);
elseif strcmp(key,'beta value in the magneotsheath')
    value.betas=str2double(word);
elseif strcmp(key,'ratio between electron plasma frequency and electron gyrofrequency')
    value.rpg=str2double(word);
elseif strcmp(key,'magnetosphere electron temperature')
    value.tem=str2double(word);
elseif strcmp(key,'magnetosheath electron temperature')
    value.tes=str2double(word);
elseif strcmp(key,'asympotic magnetosphere magnetic field')
    value.bm=str2double(word);
elseif strcmp(key,'asympotic magnetosheath magnetic field')
    value.bs=str2double(word);
elseif strcmp(key,'guide field')
    value.bg=str2double(word);
elseif strcmp(key,'initial perturbation')
    value.perturb=str2double(word);
elseif strcmp(key,'ion inertial length')
    value.di=str2double(word);
elseif strcmp(key,'electron inertial length')
    value.de=str2double(word);
elseif strcmp(key,'halfthickness of current sheet')
    value.hcs=str2double(word);
elseif strcmp(key,'density in magnetosphere side')
    value.nim=str2double(word);
elseif strcmp(key,'density in magnetosheath side')
    value.nis=str2double(word);
elseif strcmp(key,'number of particles in current sheet')
    value.n0=str2double(word);
elseif strcmp(key,'number of particles per cell')
    value.ppc=str2double(word);
elseif strcmp(key,'number of particles representing unit density')
    value.coeff=str2double(word);
elseif strcmp(key,'density ratio between background and Harris')
    value.rbh=str2double(word);
elseif strcmp(key,'ratio of initial bulk velocity between ion and electron')
    value.rvtie=str2double(word);
elseif strcmp(key,'electron plasma frequency')
    value.fpe=str2double(word);
elseif strcmp(key,'electron gyrofrequency')
    value.fce=str2double(word);
elseif strcmp(key,'ion plasma frequency')
    value.fpi=str2double(word);
elseif strcmp(key,'ion gyrofrequency')
    value.fci=str2double(word);
    value.wci=value.fci;
    value.w=value.wci;
elseif strcmp(key,'mass of electron')
    value.me=str2double(word);
elseif strcmp(key,'charge of electron')
    value.qe=str2double(word);
elseif strcmp(key,'mass of ion')
    value.mi=str2double(word);
elseif strcmp(key,'charge of ion')
    value.qi=str2double(word);
elseif strcmp(key,'electron thermal velocity')
    value.veth=str2double(word);
elseif strcmp(key,'ion thermal velocity')
    value.vith=str2double(word);
elseif strcmp(key,'debye length')
    value.debye=str2double(word);
elseif strcmp(key,'ion lamor radius')
    value.rli=str2double(word);
elseif strcmp(key,'electron lamor radius')
    value.rle=str2double(word);
elseif strcmp(key,'magnetosheath ion alfven speed')
    value.vA=str2double(word);
else
    error(['Unrecognized key: ',char(key)]);
end
end


%% ======================================================================== %%
function value=resolve_asym_rec_3s_slj(value, key, word)
%%
% @brief: read the parameters of asym_rec_3s_slj model
% @param: value - the structure containing the parameters
% @param: key - a string indicating the term
% @param: word - a string indicating the value
%%
if strcmp(key, 'simulation model') || strcmp(key, 'boundary condition') || strcmp(key,'length in the x direction') || strcmp(key,'length in the y direction') || strcmp(key,'length in the z direction') || strcmp(key,'speed of light')
elseif strcmp(key, 'mass ratio between light ion and electron')
    value.mle=str2double(word);
    value.mie=value.mle;
elseif strcmp(key, 'mass ratio between heavy ion and light ion')
    value.mhl=str2double(word);
elseif strcmp(key,'charge ratio between heavy ion and light ion')
    value.qhl=str2double(word);
elseif strcmp(key,'temperature ratio between light ion and electron')
    value.tle=str2double(word);
elseif strcmp(key,'temperature ratio between heavy ion and light ion')
    value.thl=str2double(word);
elseif strcmp(key,'ratio between electron plasma frequency and electron gyrofrequency')
    value.rpg=str2double(word);
elseif strcmp(key,'magnetosphere electron temperature')
    value.tem=str2double(word);
elseif strcmp(key,'magnetosheath electron temperature')
    value.tes=str2double(word);
elseif strcmp(key,'magnetosphere light ion temperature')
    value.tlm=str2double(word);
elseif strcmp(key,'magnetosheath light ion temperature')
    value.tls=str2double(word);
elseif strcmp(key,'magnetosphere heavy ion temperature')
    value.thm=str2double(word);
elseif strcmp(key,'asympotic magnetosphere magnetic field')
    value.bm=str2double(word);
elseif strcmp(key,'asympotic magnetosheath magnetic field')
    value.bs=str2double(word);
elseif strcmp(key,'guide field')
    value.bg=str2double(word);
elseif strcmp(key,'initial perturbation')
    value.perturb=str2double(word);
elseif strcmp(key,'heavy ion inertial length')
    value.dh=str2double(word);
elseif strcmp(key,'light ion inertial length')
    value.dl=str2double(word);
    value.di=value.dl;
elseif strcmp(key,'electron inertial length')
    value.de=str2double(word);
elseif strcmp(key,'halfthickness of current sheet')
    value.hcs=str2double(word);
elseif strcmp(key,'total ion density in magnetosphere side')
    value.ntm=str2double(word);
elseif strcmp(key,'total ion density in magnetosheath side')
    value.nts=str2double(word);
elseif strcmp(key,'light ion density in magnetosphere side')
    value.nlm=str2double(word);
elseif strcmp(key,'light ion density in magnetosheath side')
    value.nls=str2double(word);
elseif strcmp(key,'heavy ion density in magnetosphere side')
    value.nhm=str2double(word);
elseif strcmp(key,'number of ions per cell')
    value.ppc=str2double(word);
elseif strcmp(key,'number of particles representing unit density')
    value.coeff=str2double(word);
elseif strcmp(key,'total density ratio between the real and the model distribution')
    value.knn=str2double(word);
elseif strcmp(key,'electron plasma frequency')
    value.fpe=str2double(word);
elseif strcmp(key,'electron gyrofrequency')
    value.fce=str2double(word);
elseif strcmp(key,'light ion plasma frequency')
    value.fpl=str2double(word);
    value.fpi=value.fpl;
elseif strcmp(key,'light ion gyrofrequency')
    value.fcl=str2double(word);
    value.wci=value.fcl;
    value.w=value.wci;
elseif strcmp(key,'heavy ion plasma frequency')
    value.fph=str2double(word);
elseif strcmp(key,'heavy ion gyrofrequency')
    value.fch=str2double(word);
elseif strcmp(key,'mass of electron')
    value.me=str2double(word);
elseif strcmp(key,'charge of electron')
    value.qe=str2double(word);
elseif strcmp(key,'mass of light ion')
    value.ml=str2double(word);
    value.mi=value.ml;
elseif strcmp(key,'charge of light ion')
    value.ql=str2double(word);
    value.qi=value.ql;
elseif strcmp(key,'mass of heavy ion')
    value.mh=str2double(word);
elseif strcmp(key,'charge of heavy ion')
    value.qh=str2double(word);
elseif strcmp(key,'electron thermal velocity')
    value.veth=str2double(word);
elseif strcmp(key,'light ion thermal velocity')
    value.vlth=str2double(word);
elseif strcmp(key,'heavy ion thermal velocity')
    value.vhth=str2double(word);
elseif strcmp(key,'debye length')
    value.debye=str2double(word);
elseif strcmp(key,'heavy ion lamor radius')
    value.rlh=str2double(word);
elseif strcmp(key,'light ion lamor radius')
    value.rll=str2double(word);
elseif strcmp(key,'electron lamor radius')
    value.rle=str2double(word);
elseif strcmp(key,'light ion alfven speed')
    value.vAl=str2double(word);
    value.vA=value.vAl;
elseif strcmp(key,'distance between heavy ion and current sheet')
    value.dcc=str2double(word);
elseif strcmp(key, 'the driven velocity in the magnetosheath side')
    value.driven=str2double(word);
else
    error(['Unrecognized key: ',char(key)]);
end
end

%% ======================================================================== %%
function value=resolve_turbulence(value, key, word)
%%
% @brief: read the parameters of turbulence model
% @param: value - the structure containing the parameters
% @param: key - a string indicating the term
% @param: word - a string indicating the value
%%
if strcmp(key, 'simulation model') || strcmp(key, 'boundary condition') || strcmp(key,'length in the x direction') || strcmp(key,'length in the y direction') || strcmp(key,'length in the z direction') || strcmp(key,'speed of light')
elseif strcmp(key, 'mass ratio between ion and electron')
    value.mie=str2double(word);
elseif strcmp(key, 'temperature ratio between ion and electron')
    value.tie=str2double(word);
elseif strcmp(key,'ratio between electron plasma frequency and electron gyrofrequency')
    value.rpg=str2double(word);
elseif strcmp(key,'beta value')
    value.beta=str2double(word);
elseif strcmp(key,'electron temperature')
    value.te=str2double(word);
elseif strcmp(key,'magnetic field')
elseif strcmp(key,'ion inertial length')
    value.di=str2double(word);
elseif strcmp(key,'electron inertial length')
    value.de=str2double(word);
elseif strcmp(key, 'number density of plasma')
    value.np=str2double(word);
    value.n0=value.np;
elseif strcmp(key,'number of particles per cell')
    value.ppc=str2double(word);
elseif strcmp(key,'number of particles representing unit density')
    value.coeff=str2double(word);
elseif strcmp(key,'electron plasma frequency')
    value.fpe=str2double(word);
elseif strcmp(key,'electron gyrofrequency')
    value.fce=str2double(word);
    value.w=value.fce;
elseif strcmp(key,'ion plasma frequency')
    value.fpi=str2double(word);
elseif strcmp(key,'ion gyrofrequency')
    value.wci=str2double(word);
elseif strcmp(key,'mass of electron')
    value.me=str2double(word);
elseif strcmp(key,'charge of electron')
    value.qe=str2double(word);
elseif strcmp(key,'mass of ion')
    value.mi=str2double(word);
elseif strcmp(key,'charge of ion')
    value.qi=str2double(word);
elseif strcmp(key,'electron thermal velocity')
    value.veth=str2double(word);
elseif strcmp(key,'ion thermal velocity')
    value.vith=str2double(word);
elseif strcmp(key,'debye length')
    value.debye=str2double(word);
elseif strcmp(key,'ion lamor radius')
    value.rli=str2double(word);
elseif strcmp(key,'electron lamor radius')
    value.rle=str2double(word);
elseif strcmp(key,'ion alfven speed')
    value.vA=str2double(word);
elseif strcmp(key,'the perturbation')
    value.perturb=str2double(word);
else
    error(['Unrecognized key: ',char(key)]);
end
end


%% ======================================================================== %%
function value=resolve_asym_rec(value, key, word)
%%
% @brief: read the parameters of asym-rec model
% @param: value - the structure containing the parameters
% @param: key - a string indicating the term
% @param: word - a string indicating the value
%%
if strcmp(key, 'simulation model') || strcmp(key, 'boundary condition') || strcmp(key,'length in the x direction') || strcmp(key,'length in the y direction') || strcmp(key,'length in the z direction') || strcmp(key,'speed of light')
elseif strcmp(key, 'mass ratio between ion and electron')
    value.mie=str2double(word);
elseif strcmp(key,'temperature ratio between ion and electron')
    value.tie=str2double(word);
elseif strcmp(key,'beta value in the magneotsheath')
    value.betas=str2double(word);
elseif strcmp(key,'ratio between electron plasma frequency and electron gyrofrequency')
    value.rpg=str2double(word);
elseif strcmp(key,'magnetosphere electron temperature')
    value.tem=str2double(word);
elseif strcmp(key,'magnetosheath electron temperature')
    value.tes=str2double(word);
elseif strcmp(key,'asympotic magnetosphere magnetic field')
    value.bm=str2double(word);
elseif strcmp(key,'asympotic magnetosheath magnetic field')
    value.bs=str2double(word);
elseif strcmp(key,'guide field')
    value.bg=str2double(word);
elseif strcmp(key,'initial perturbation')
    value.perturb=str2double(word);
elseif strcmp(key,'magnetosheath magnetic field turbulence')
    value.perturb=str2double(word);
elseif strcmp(key,'ion inertial length')
    value.di=str2double(word);
elseif strcmp(key,'electron inertial length')
    value.de=str2double(word);
elseif strcmp(key,'halfthickness of current sheet')
    value.hcs=str2double(word);
elseif strcmp(key,'density in magnetosphere side')
    value.nim=str2double(word);
elseif strcmp(key,'density in magnetosheath side')
    value.nis=str2double(word);
elseif strcmp(key,'number of particles in current sheet')
    value.n0=str2double(word);
elseif strcmp(key,'number of particles per cell')
    value.ppc=str2double(word);
elseif strcmp(key,'number of particles representing unit density')
    value.coeff=str2double(word);
elseif strcmp(key,'total density ratio between the real and the model distribution')
    value.knn=str2double(word);
elseif strcmp(key,'density ratio between background and Harris')
    value.rbh=str2double(word);
elseif strcmp(key,'electron plasma frequency')
    value.fpe=str2double(word);
elseif strcmp(key,'electron gyrofrequency')
    value.fce=str2double(word);
elseif strcmp(key,'ion plasma frequency')
    value.fpi=str2double(word);
elseif strcmp(key,'ion gyrofrequency')
    value.fci=str2double(word);
    value.wci=value.fci;
    value.w=value.wci;
elseif strcmp(key, 'the bulk velocity ratio between ions and electrons')
    value.rvie=str2double(word);
elseif strcmp(key,'mass of electron')
    value.me=str2double(word);
elseif strcmp(key,'charge of electron')
    value.qe=str2double(word);
elseif strcmp(key,'mass of ion')
    value.mi=str2double(word);
elseif strcmp(key,'charge of ion')
    value.qi=str2double(word);
elseif strcmp(key,'electron thermal velocity')
    value.veth=str2double(word);
elseif strcmp(key,'ion thermal velocity')
    value.vith=str2double(word);
elseif strcmp(key,'debye length')
    value.debye=str2double(word);
elseif strcmp(key,'ion lamor radius')
    value.rli=str2double(word);
elseif strcmp(key,'electron lamor radius')
    value.rle=str2double(word);
elseif strcmp(key,'magnetosheath ion alfven speed')
    value.vA=str2double(word);
else
    error(['Unrecognized key: ',char(key)]);
end
end

%% ======================================================================== %%
function value=resolve_rec_electron_current(value, key, word)
%%
% @brief: read the parameters of asym-rec model
% @param: value - the structure containing the parameters
% @param: key - a string indicating the term
% @param: word - a string indicating the value
%%
if strcmp(key, 'simulation model') || strcmp(key, 'boundary condition') || strcmp(key,'length in the x direction') || strcmp(key,'length in the y direction') || strcmp(key,'length in the z direction') || strcmp(key,'speed of light')
elseif strcmp(key, 'mass ratio between ion and electron')
    value.mie=str2double(word);
elseif strcmp(key,'temperature ratio between ion and electron')
    value.tie=str2double(word);
elseif strcmp(key,'beta value in the magneotsheath')
    value.betas=str2double(word);
elseif strcmp(key,'ratio between electron plasma frequency and electron gyrofrequency')
    value.rpg=str2double(word);
elseif strcmp(key,'magnetosphere electron temperature')
    value.tem=str2double(word);
elseif strcmp(key,'magnetosheath electron temperature')
    value.tes=str2double(word);
elseif strcmp(key,'asympotic magnetosphere magnetic field')
    value.bm=str2double(word);
elseif strcmp(key,'asympotic magnetosheath magnetic field')
    value.bs=str2double(word);
elseif strcmp(key,'guide field')
    value.bg=str2double(word);
elseif strcmp(key,'initial perturbation')
    value.perturb=str2double(word);
elseif strcmp(key,'ion inertial length')
    value.di=str2double(word);
elseif strcmp(key,'electron inertial length')
    value.de=str2double(word);
elseif strcmp(key,'halfthickness of current sheet')
    value.hcs=str2double(word);
elseif strcmp(key,'density in magnetosphere side')
    value.nim=str2double(word);
elseif strcmp(key,'density in magnetosheath side')
    value.nis=str2double(word);
elseif strcmp(key,'number of particles in current sheet')
    value.n0=str2double(word);
elseif strcmp(key,'number of particles per cell')
    value.ppc=str2double(word);
elseif strcmp(key,'number of particles representing unit density')
    value.coeff=str2double(word);
elseif strcmp(key,'density ratio between background and Harris')
    value.rbh=str2double(word);
elseif strcmp(key,'drift velocity ratio between ion and electron in current')
    value.rvtie=str2double(word);
elseif strcmp(key,'electron plasma frequency')
    value.fpe=str2double(word);
elseif strcmp(key,'electron gyrofrequency')
    value.fce=str2double(word);
elseif strcmp(key,'ion plasma frequency')
    value.fpi=str2double(word);
elseif strcmp(key,'ion gyrofrequency')
    value.fci=str2double(word);
    value.wci=value.fci;
    value.w=value.wci;
elseif strcmp(key,'mass of electron')
    value.me=str2double(word);
elseif strcmp(key,'charge of electron')
    value.qe=str2double(word);
elseif strcmp(key,'mass of ion')
    value.mi=str2double(word);
elseif strcmp(key,'charge of ion')
    value.qi=str2double(word);
elseif strcmp(key,'electron thermal velocity')
    value.veth=str2double(word);
elseif strcmp(key,'ion thermal velocity')
    value.vith=str2double(word);
elseif strcmp(key,'debye length')
    value.debye=str2double(word);
elseif strcmp(key,'ion lamor radius')
    value.rli=str2double(word);
elseif strcmp(key,'electron lamor radius')
    value.rle=str2double(word);
elseif strcmp(key,'magnetosheath ion alfven speed')
    value.vA=str2double(word);
else
    error(['Unrecognized key: ',char(key)]);
end
end


%% ======================================================================== %%
function value=resolve_shock(value, key, word)
%%
% @brief: read the parameters of rec_2harris model
% @param: value - the structure containing the parameters
% @param: key - a string indicating the term
% @param: word - a string indicating the value
%%
if strcmp(key, 'simulation model') || strcmp(key, 'boundary condition') || strcmp(key,'length in the x direction') || strcmp(key,'length in the y direction') || strcmp(key,'length in the z direction') || strcmp(key,'speed of light')
elseif strcmp(key, 'mass ratio between ion and electron')
    value.mie=str2double(word);
elseif strcmp(key,'temperature ratio between ion and electron')
    value.tie=str2double(word);
elseif strcmp(key,'ratio between electron plasma frequency and electron gyrofrequency')
    value.rpg=str2double(word);
elseif strcmp(key,'beta value')
    value.beta=str2double(word);
elseif strcmp(key,'magnetic field')
    value.b0=str2double(word);
elseif strcmp(key,'shock angle')
    value.theta=str2double(word);
elseif strcmp(key,'drift velocity')
    value.vdf=str2double(word);
elseif strcmp(key,'electron temperature')
    value.te=str2double(word);
elseif strcmp(key,'ion inertial length')
    value.di=str2double(word);
elseif strcmp(key,'electron inertial length')
    value.de=str2double(word);
elseif strcmp(key,'number density of plasma')
    value.n0=str2double(word);
elseif strcmp(key,'number of particles per cell')
    value.ppc=str2double(word);
elseif strcmp(key,'number of particles representing unit density')
    value.coeff=str2double(word);
elseif strcmp(key,'electron plasma frequency')
    value.fpe=str2double(word);
elseif strcmp(key,'electron gyrofrequency')
    value.fce=str2double(word);
elseif strcmp(key,'ion plasma frequency')
    value.fpi=str2double(word);
elseif strcmp(key,'ion gyrofrequency')
    value.fci=str2double(word);
    value.wci=value.fci;
    value.w=value.wci;
elseif strcmp(key,'mass of electron')
    value.me=str2double(word);
elseif strcmp(key,'charge of electron')
    value.qe=str2double(word);
elseif strcmp(key,'mass of ion')
    value.mi=str2double(word);
elseif strcmp(key,'charge of ion')
    value.qi=str2double(word);
elseif strcmp(key,'electron thermal velocity')
    value.veth=str2double(word);
elseif strcmp(key,'ion thermal velocity')
    value.vith=str2double(word);
elseif strcmp(key,'debye length')
    value.debye=str2double(word);
elseif strcmp(key,'ion lamor radius')
    value.rli=str2double(word);
elseif strcmp(key,'electron lamor radius')
    value.rle=str2double(word);
elseif strcmp(key,'ion alfven speed')
    value.vA=str2double(word);
else
    error(['Unrecognized key: ',char(key)]);
end
end