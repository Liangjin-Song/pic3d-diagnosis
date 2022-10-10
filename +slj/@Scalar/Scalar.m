classdef Scalar 
%%
% @info: writen by Liangjin Song on 20210425
% @breif: the Scalar class representing the scalar field
%%
properties (SetAccess = private)
    value;
end
%% ======================================================================== %%
methods (Access = public)
    %% constructor
    function obj=Scalar(value)
        obj.value=value;
    end
    function obj=normalize(obj, norm)
        obj.value=obj.value/norm;
    end
end

%% ======================================================================== %%
%% operator overload
methods (Access = public)
    fd = plus(lhs, rhs);
    fd = minus(lhs, rhs);
    fd = uminus(fd);
    fd = mtimes(lhs, rhs);
    fd = mrdivide(lhs, rhs);
end

%% ======================================================================== %%
%% 2d field operator
methods (Access = public)
    lf = get_line2d(obj, x0, direction, prm, norm);
    obj = filter2d(obj, n);
end

%% ======================================================================== %%
%% some utility
methods (Access = public)
    fd = get_box(obj, xx, yy, zz);
end

%% ======================================================================== %%
%% gradient
methods (Access = public)
    fd = gradient(obj, prm);
end

%% ======================================================================== %%
end
