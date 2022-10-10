classdef Species
%% writen by Liangjin Song on 20210329
% the particles' information
%%
properties (Access = public)
    name;
    species;
    time;
    xrange;
    yrange;
    zrange;
    value;
end
%% ======================================================================== %%
methods (Access = public)
    %% constructor
    function obj=Species()
        obj.name=[];
        obj.species=[];
        obj.time=[];
        obj.xrange=[];
        obj.yrange=[];
        obj.zrange=[];
        obj.value=[];
    end
end

%% ======================================================================== %%
%% get the distribution function
methods (Access = public)
    dst = distribution_function(obj, prm);
end

%% ======================================================================== %%
methods (Access = public)
    id = find_particles_id(obj, prm, vrange);
end

%% ======================================================================== %%
end
