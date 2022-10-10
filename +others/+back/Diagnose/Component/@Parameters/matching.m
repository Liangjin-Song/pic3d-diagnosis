function value = matching(obj,key,word)
%% writen by Liangjin Song on 20210325
% match the parameters
%%
value=obj.value;
if contains(key,'simulation model')
    value.model=word;
elseif contains(key,'boundary condition')
    value.boundary=resolve_boundary_condition(word);
elseif contains(key,'length in the x direction')
    value.nx=str2num(word);
elseif contains(key,'length in the y direction')
    value.nz=str2num(word);
elseif contains(key,'length in the z direction')
    value.ny=str2num(word);
elseif contains(key,'speed of light')
    value.c=str2num(word);
elseif contains(key,'mass ratio between ion and electron')
    value.mie=str2num(word);
elseif contains(key,'mass ratio between light ion and electron')
    value.mle=str2num(word);
    value.mie=value.mle;
elseif contains(key,'mass ratio between heavy ion and light ion')
    value.mhl=str2num(word);
elseif contains(key,'charge ratio between heavy ion and light ion')
    value.qhl=str2num(word);
elseif contains(key,'background density ratio between heavy ion and light ion')
    value.bhl=str2num(word);
elseif contains(key,'temperature ratio between light ion and electron')
    value.tle=str2num(word);
elseif contains(key,'temperature ratio between ion and electron')
    value.tie=str2num(word);
elseif contains(key,'temperature ratio between heavy ion and light ion')
    value.thl=str2num(word);
elseif contains(key,'beta value in the magneotsheath')
    value.betas=str2num(word);
elseif contains(key,'ratio between electron plasma frequency and electron gyrofrequency')
    value.rpg=str2num(word);
elseif contains(key,'magnetosphere electron temperature')
    value.tem=str2num(word);
elseif contains(key,'magnetosheath electron temperature')
    value.tes=str2num(word);
elseif contains(key,'asympotic magnetosphere magnetic field')
    value.bm=str2num(word);
elseif contains(key,'asympotic magnetosheath magnetic field')
    value.bs=str2num(word);
elseif contains(key,'guide field')
    value.bg=str2num(word);
elseif contains(key,'initial perturbation')
    value.perturb=str2num(word);
elseif contains(key,'heavy ion inertial length')
    value.dh=str2num(word);
elseif contains(key,'ion inertial length')
    value.di=str2num(word);
    if contains(key,'light ion inertial length')
        value.dl=str2num(word);
        value.di=value.dl;
    end
elseif contains(key,'electron inertial length')
    value.de=str2num(word);
elseif contains(key,'halfthickness of current sheet')
    value.hcs=str2num(word);
elseif contains(key,'light ion density in magnetosphere side')
    value.nlm=str2num(word);
elseif contains(key,'density in magnetosphere side')
    value.nim=str2num(word);
elseif contains(key,'light ion density in magnetosheath side')
    value.nls=str2num(word);
elseif contains(key,'density in magnetosheath side')
    value.nis=str2num(word);
elseif contains(key,'number of light ion in current sheet')
    value.nlcs=str2num(word);
    value.n0=value.nlcs;
elseif contains(key,'number of particles in current sheet')
    value.n0=str2num(word);
elseif contains(key,'number of light ion per cell')
    value.ppcl=str2num(word);
elseif contains(key,'number of particles per cell')
    value.ppc=str2num(word);
elseif contains(key,'number of heavy ion per cell')
    value.ppch=str2num(word);
elseif contains(key,'number of particles representing unit density')
    value.coeff=str2num(word);
elseif contains(key,'density ratio between light ion background and Harris')
    value.rbh=str2num(word);
elseif contains(key,'density ratio between background and Harris')
    value.rbh=str2num(word);
elseif contains(key,'electron plasma frequency')
    value.fpe=str2num(word);
elseif contains(key,'electron gyrofrequency')
    value.fce=str2num(word);
elseif contains(key,'light ion plasma frequency')
    value.fpl=str2num(word);
    value.fpi=value.fpl;
elseif contains(key,'ion plasma frequency')
    value.fpi=str2num(word);
elseif contains(key,'light ion gyrofrequency')
    value.fcl=str2num(word);
    value.wci=value.fcl;
elseif contains(key,'ion gyrofrequency')
    value.wci=str2num(word);
elseif contains(key,'heavy ion plasma frequency')
    value.fph=str2num(word);
elseif contains(key,'heavy ion gyrofrequency')
    value.fch=str2num(word);
elseif contains(key,'mass of electron')
    value.me=str2num(word);
elseif contains(key,'charge of electron')
    value.qe=str2num(word);
elseif contains(key,'mass of light ion')
    value.ml=str2num(word);
    value.mi=value.ml;
elseif contains(key,'mass of ion')
    value.mi=str2num(word);
elseif contains(key,'charge of light ion')
    value.ql=str2num(word);
    value.qi=value.ql;
elseif contains(key,'charge of ion')
    value.qi=str2num(word);
elseif contains(key,'mass of heavy ion')
    value.mh=str2num(word);
elseif contains(key,'charge of heavy ion')
    value.qh=str2num(word);
elseif contains(key,'electron thermal velocity')
    value.veth=str2num(word);
elseif contains(key,'light ion thermal velocity')
    value.vlth=str2num(word);
elseif contains(key,'heavy ion thermal velocity')
    value.vhth=str2num(word);
elseif contains(key,'ion thermal velocity')
    value.vith=str2num(word);
elseif contains(key,'debye length')
    value.debye=str2num(word);
elseif contains(key,'heavy ion lamor radius')
    value.rlh=str2num(word);
elseif contains(key,'light ion lamor radius')
    value.rll=str2num(word);
elseif contains(key,'ion lamor radius')
    value.rli=str2num(word);
elseif contains(key,'electron lamor radius')
    value.rle=str2num(word);
elseif contains(key,'electron alfven speed')
    value.vAe=str2num(word);
elseif contains(key,'light ion alfven speed')
    value.vAl=str2num(word);
    value.vA=value.vAl;
elseif contains(key,'magnetosheath ion alfven speed')
    value.vA=str2num(word);
elseif contains(key,'heavy ion alfven speed')
    value.vAh=str2num(word);
else
    error(['Unrecognized key: ',char(key)]);
end
end

%% ======================================================================== %%
function bnd=resolve_boundary_condition(word)
    bnd=[];
    tmp=strsplit(word,'(');
    tmp=tmp(2);
    tmp=strsplit(tmp,')');
    tmp=strsplit(tmp(1),',');
    bmp=strsplit(tmp(1),':');
    bnd.x=strtrim(bmp(2));
    bmp=strsplit(tmp(2),':');
    bnd.y=strtrim(bmp(2));
    bmp=strsplit(tmp(3),':');
    bnd.z=strtrim(bmp(2));
end
