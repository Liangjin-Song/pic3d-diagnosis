function fd = power(lhs, rhs)
%% writen by Liangjin Song on 20210326
% fd = lhs.^rhs
% the properties of fd are the same as lhs
%%
if ~isa(rhs,'double')
    error('Parameters error');
end
fd=Field();
fd.name=lhs.name;
fd.norm=lhs.norm;
fd.time=lhs.time;
fd.type=lhs.type;

if lhs.type == FieldType.Scalar
    fd.value=lhs.value.^rhs;
elseif lhs.type == FieldType.Vector
    fd.value.x=lhs.value.x.^rhs;
    fd.value.y=lhs.value.y.^rhs;
    fd.value.z=lhs.value.z.^rhs;
elseif lhs.type == FieldType.Tensor
    fd.value.xx=lhs.value.xx.^rhs;
    fd.value.xy=lhs.value.xy.^rhs;
    fd.value.xz=lhs.value.xz.^rhs;
    fd.value.yy=lhs.value.yy.^rhs;
    fd.value.yz=lhs.value.yz.^rhs;
    fd.value.zz=lhs.value.zz.^rhs;
else
    error('Parameters error');
end
