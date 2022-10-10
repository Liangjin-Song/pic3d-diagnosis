classdef Particle
%% writen by Liangjin Song on 20210408
% the Particle class, the data is from the traj file
%%
properties
    id;
    type;
    q;
    m;
    value;
end
%% ======================================================================== %%
methods (Access = public)
    function obj=Particle()
        obj.id=[];
        obj.type=[];
        obj.q=[];
        obj.m=[];
        obj.value=[];
    end
end

%% ======================================================================== %%
methods (Access = public)
    obj = calculation(obj);
end

%% ======================================================================== %%
%% normalization
methods (Access = public)
    obj = norm_energy(obj, norm);
    obj = norm_electric_field(obj, norm);
    obj = norm_velocity(obj, norm);
end

%% ======================================================================== %%
%% calculation of acceleration
methods (Access = public)
    fermi = Fermi_acceleration(obj, wci);
    en = Fermi_energy(obj, prm);
    en = parallel_electric(obj, prm);
    en = betatron_acceleration(obj, wci);
    en = betatron_energy(obj, prm);
    en = perpendicular_energy(obj, prm);
    en = acceleration_rate(obj, prm);
    en = acceleration_direction(obj, prm);
end

methods (Access = public, Static)
    row = work_rate(en, wci);
    fd=filter1d(fd);
end

%% ======================================================================== %%
end
