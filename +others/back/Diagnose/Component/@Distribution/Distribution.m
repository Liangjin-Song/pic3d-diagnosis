classdef Distribution
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
    function obj=Distribution()
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
end
