classdef Tensor
%%
% @info: writen by Liangjin Song on 20210425
% @breif: the Vector class representing the tensor field
%%
properties (SetAccess = private)
    xx;
    xy;
    xz;
    yy;
    yz;
    zz;
end
%% ======================================================================== %%
%% constructor
methods (Access = public)
    function obj = Tensor(value)
        obj.xx=value.xx;
        obj.xy=value.xy;
        obj.xz=value.xz;
        obj.yy=value.yy;
        obj.yz=value.yz;
        obj.zz=value.zz;
    end
    function obj=normalize(obj, norm)
        obj.xx=obj.xx/norm;
        obj.xy=obj.xy/norm;
        obj.xz=obj.xz/norm;
        obj.yy=obj.yy/norm;
        obj.yz=obj.yz/norm;
        obj.zz=obj.zz/norm;
    end
end


%% ======================================================================== %%
%% Tensor operation
methods (Access = public)
    function fd = scalar(obj)
        fd = (obj.xx+obj.yy+obj.zz)/3;
        fd = slj.Scalar(fd);
    end
    fd=divergence(obj, prm);
    fd = fac_tensor(obj, B, prm);
    fd = reshape_old(obj, prm);
end


%% ======================================================================== %%
%% operation +
methods (Access = public)
    fd = plus(obj, rhs);
end


%% ======================================================================== %%
end
