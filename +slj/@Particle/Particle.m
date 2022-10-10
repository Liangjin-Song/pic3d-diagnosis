classdef Particle
%%
% @info: writen by Liangjin Song on 20210501
% @brief: the Particle class associated with the particle's trajectory
%%
properties (SetAccess = private)
    id;
    q;
    m;
    weight;
    value;
end
%% ======================================================================== %%
%% constructor
methods (Access = public)
    function obj=Particle(id, q, m, w, value)
        obj.id=id;
        obj.q=q;
        obj.m=m;
        obj.weight=w;
        obj.value=value;
    end
    function obj=command(obj, cmd)
        eval(cmd);
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
