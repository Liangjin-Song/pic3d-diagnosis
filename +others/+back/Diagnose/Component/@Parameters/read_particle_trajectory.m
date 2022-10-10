function fd = read_particle_trajectory(obj, name)
%% writen by Liangjin Song on 20210408
% read the particle trajectory
%%
fd=Particle();
info=split(name,'_');
id=char(info(2));
fd.id=uint64(str2num(id(3:end)));
info=char(info(1));

if strcmp(info, 'trajh')
    fd.type=SpeciesType.Heavy_Ion;
    fd.q=obj.value.qh;
    fd.m=obj.value.mh;
elseif strcmp(info,'trajl')
    fd.type=SpeciesType.Ion;
    fd.q=obj.value.ql;
    fd.m=obj.value.ml;
elseif strcmp(info,'traje')
    fd.type=SpeciesType.Electron;
    fd.q=obj.value.qe;
    fd.m=obj.value.me;
elseif strcmp(info,'trajhe')
    fd.type=SpeciesType.Electron_with_Heavy_Ion;
    fd.q=obj.value.qe;
    fd.m=obj.value.me;
elseif strcmp(info,'traji')
    fd.type=SpeciesType.Ion;
    fd.q=obj.value.qi;
    fd.m=obj.value.mi;
else
    error('Parameters error!');
end

cd(obj.value.indir);
value=load([name,'.dat']);
fd.value.time=value(:,1);
fd.value.rx=position(obj.value.lx,value(:,2));
fd.value.rz=position(obj.value.lz,value(:,3));
if obj.value.ny > 1
    fd.value.ry=position(obj.value.ly,-value(4));
end
fd.value.vx=value(:,5);
fd.value.vz=value(:,6);
fd.value.vy=-value(:,7);
fd.value.ex=value(:,8);
fd.value.ez=value(:,9);
fd.value.ey=-value(:,10);
fd.value.bx=value(:,11);
fd.value.bz=value(:,12);
fd.value.by=-value(:,13);
fd.value.k=value(:,14);
fd.value.kappa=value(:,15);
fd=fd.calculation();
end

%% ======================================================================== %%
function pm=position(mr,pr)
    k=(mr(end)-mr(1))/(length(mr)-1);
    pm=k*(pr-1)+mr(1);
end
