classdef Parameters
%%
% @info: writen by Liangjin Song on 20210425
% @brief: the Parameters class, read the parameters from the parameters.dat file
%%
properties (SetAccess = private)
    indir;
    outdir;
    value;
end
%% ======================================================================== %%
%% constructor
methods (Access = public)
    %% the input/output directory
    function obj=Parameters(indir, outdir)
        obj.indir=indir;
        obj.outdir=outdir;
        obj.value=resolve(obj);
        obj.value.type='float';
    end
end

%% ======================================================================== %%
%% extract the parameters
methods (Access = private)
    value = resolve(obj);
end

%% ======================================================================== %%
%% read simulation data
methods (Access = public)
    fd = read(obj, varargin);
end
methods (Access = private, Static)
    fd = read_binary_file(filename, datatype);
    fd = read_field(value, name, time);
    fd = read_vector(value, name);
end

%% ======================================================================== %%
end
