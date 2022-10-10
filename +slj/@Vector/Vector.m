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
    fd = sqre(obj);
    fd = sqrt(obj);
end

%% ======================================================================== %%
%% field operation
methods (Access = public)
    fd = curl(obj, prm);
    fd = divergence(obj, prm);
    fd = dot(lhs, rhs);
    fd = cross(lhs, rhs);
    fd = filter2d(obj,n);
    
    [para, perp] = fac_vector(obj, B);
end

%% ======================================================================== %%
%% operator overload
methods (Access = public)
    fd = plus(lhs, rhs);
end

%% ======================================================================== %%
end
