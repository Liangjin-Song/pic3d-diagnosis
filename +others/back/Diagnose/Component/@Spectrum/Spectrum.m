classdef Spectrum
%% writen by Liangjin Song on 20210406
% the spectrum class
%%
properties
    time;
    value;
    type;
end

%% ======================================================================== %%
methods (Access = public)
    function obj=Spectrum()
        obj.time=[];
        obj.value=[];
        obj.type=[];
    end
end

%% ======================================================================== %%
end

