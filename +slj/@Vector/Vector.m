classdef Vector
%%
% @info: writen by Liangjin Song on 20210425
% @breif: the Vector class representing the vector field
%%
properties (SetAccess = private)
    x;
    y;
    z;
end
%% ======================================================================== %%
%% constructor
methods (Access = public)
    function obj=Vector(value)
        obj.x=value.x;
        obj.y=value.y;
        obj.z=value.z;
    end
    function obj=normalize(obj, norm)
        obj.x=obj.x/norm;
        obj.y=obj.y/norm;
        obj.z=obj.z/norm;
    end
end

%% ======================================================================== %%
%% 2d field operator
methods (Access = public)
    lf=get_line2d(obj, x0, direction, prm, norm);
end

%% ======================================================================== %%
methods (Access = public)
end

%% ======================================================================== %%
end
