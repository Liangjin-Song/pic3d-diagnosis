classdef Parameters
%% writen by Liangjin Song on 20210321
% the Parameters class, read the parameters from the parameters.dat file
%%
properties (SetAccess = private)
    value;
end
%% ======================================================================== %%
methods (Access = public)
    %% constructor
    %% the input/output directory
    function obj=Parameters(indir, outdir)
        obj.value.indir=indir;
        obj.value.outdir=outdir;
        obj.value = resolve(obj);
        obj.value = scale(obj);
        obj.value.type='float';
    end
end

%% ======================================================================== %%
methods
    % get the parameters
    function value = get.value(obj)
        value=obj.value;
    end
end

%% ======================================================================== %%
%% read data
methods (Access = public)
    fd = read_data(obj, varargin);
end

methods (Access = private)
    fd=read_binary_file(obj, filename);
    fd=reshape_field(obj, fd, type);
    fd=read_particle_distribution(obj, name);
    fd=read_particle_trajectory(obj, name);
end

methods (Access = private)
    fd=read_field(obj,name,time);
    fd=read_vector(obj,name);
    fd=read_spectrum(obj, name, time);
end

%% ======================================================================== %%
%% resolve the parameters
methods (Access = private)
    value = resolve(obj);
    value = matching(obj,key,word);
end

%% ======================================================================== %%
%% set the length scale
methods (Access = private)
    value = scale(obj);
end

%% ======================================================================== %%
end

