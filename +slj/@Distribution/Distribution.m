classdef Distribution
%%
% @info: writen by Liangjin Song on 20210603
% @brief: the distribution function
%%
properties (Access = public)
    time;
    range;
    ll;
    value;
end
%% ======================================================================== %%
%% constructor
methods (Access = public)
    function obj=Distribution(time, range, ll, value)
        obj.time=time;
        obj.range=range;
        obj.ll=ll;
        obj.value=value;
    end
end

%% ======================================================================== %%
%% get the integration of the distribution function
methods (Access = public)
    fd = intgrtv(obj, dir);
end

%% ======================================================================== %%
end
