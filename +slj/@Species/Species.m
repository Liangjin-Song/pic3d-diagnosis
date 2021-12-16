classdef Species
%%
% @info: writen by Liangjin Song on 20210502
% @brief: the particles' information about the distribution function
%%
properties (SetAccess = private)
    name;
    time;
    range;
    value;
end
%% ======================================================================== %%
%% constructor
methods (Access = public)
    function obj = Species(name, time, range, value)
        obj.name=name;
        obj.time=time;
        obj.range=range;
        obj.value=value;
    end
end

%% ======================================================================== %%
%% generate the distribution
methods (Access = public)
    fd = dstv(obj, varargin);
    fd = dstrv(obj, ri, vi, norm, prcr);
    fd = dstrvv(obj, ri, vi, norm, prcr);
end

%% ======================================================================== %%
%% get the sub species
methods (Access = public)
    fd = subposition(obj, xrange, yrange, zrange);
    fd = subvelocity(obj, xrange, yrange, zrange);
end

%% find the particles' ID
methods (Access = public)
    id = rectangle_particle_id(obj, prm, vrange);
    id = ring_particle_id(obj, prm, vdir, center, lradius, sradius);
end

%% ======================================================================== %%
end
