function fd = rdivide(lhs, rhs)
%% writen by Liangjin Song on 20210326
% fd=lhs./rhs
% the properties of fd are the same as lhs
%%
if ~isa(rhs,'Field')
    rhs=Field(rhs);
    rhs.type=FieldType.Scalar;
end

if (lhs.type == FieldType.Scalar) && (rhs.type == FieldType.Scalar)
    fd=scalar_scalar(lhs,rhs);
elseif (lhs.type == FieldType.Vector) && (rhs.type == FieldType.Scalar)
    fd=vector_scalar(lhs,rhs);
elseif (lhs.type == FieldType.Vector) && (rhs.type == FieldType.Vector)
    fd=vector_vector(lhs,rhs);
elseif (lhs.type == FieldType.Tensor) && (rhs.type == FieldType.Scalar)
    fd=tensor_scalar(lhs,rhs);
elseif (lhs.type == FieldType.Tensor) && (rhs.type == FieldType.Tensor)
    fd=tensor_tensor(lhs,rhs);
else
    error('Parameters error');
end
end

%% ======================================================================== %%
%% Scalar .* Scalar
function fd=scalar_scalar(ls, rs)
    fd=Field();
    fd.name=ls.name;
    fd.time=ls.time;
    fd.norm=ls.norm;
    fd.type=ls.type;
    fd.value=ls.value./rs.value;
end

%% ======================================================================== %%
%% Vector .* Scalar
function fd=vector_scalar(ls, rs)
    fd=Field();
    fd.name=ls.name;
    fd.time=ls.time;
    fd.norm=ls.norm;
    fd.type=ls.type;
    fd.value.x=ls.value.x./rs.value;
    fd.value.y=ls.value.y./rs.value;
    fd.value.z=ls.value.z./rs.value;
end

%% ======================================================================== %%
%% Tensor .* Scalar
function fd=tensor_scalar(ls, rs)
    fd=Field();
    fd.name=ls.name;
    fd.time=ls.time;
    fd.norm=ls.norm;
    fd.type=ls.type;
    fd.value.xx=ls.value.xx./rs.value;
    fd.value.xy=ls.value.xy./rs.value;
    fd.value.xz=ls.value.xz./rs.value;
    fd.value.yy=ls.value.yy./rs.value;
    fd.value.yz=ls.value.yz./rs.value;
    fd.value.zz=ls.value.zz./rs.value;
end

%% ======================================================================== %%
%% Vector .* Vector
function fd=vector_vector(ls, rs)
    fd=Field();
    fd.name=ls.name;
    fd.time=ls.time;
    fd.norm=ls.norm;
    fd.type=ls.type;
    fd.value.x=ls.value.x./rs.value.x;
    fd.value.y=ls.value.y./rs.value.y;
    fd.value.z=ls.value.z./rs.value.z;
end

%% ======================================================================== %%
%% Tensor .* Tensor
function fd=tensor_tensor(ls, rs)
    fd=Field();
    fd.name=ls.name;
    fd.time=ls.time;
    fd.norm=ls.norm;
    fd.type=ls.type;
    fd.value.xx=ls.value.xx./rs.value.xx;
    fd.value.xy=ls.value.xy./rs.value.xy;
    fd.value.xz=ls.value.xz./rs.value.xz;
    fd.value.yy=ls.value.yy./rs.value.yy;
    fd.value.yz=ls.value.yz./rs.value.yz;
    fd.value.zz=ls.value.zz./rs.value.zz;
end

