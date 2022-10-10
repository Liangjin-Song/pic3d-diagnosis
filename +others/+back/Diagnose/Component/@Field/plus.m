function fd = plus(lhs, rhs)
%% writen by Liangjin Song on 20210326
% fd=lhs+rhs
% the properties of fd are the same as lhs
%%
fd=Field();
fd.name=lhs.name;
fd.time=lhs.time;
fd.norm=lhs.norm;
fd.type=lhs.type;

if ~isa(lhs,'Field')
    lhs=Field(lhs);
end
if ~isa(rhs,'Field')
    rhs=Field(rhs);
end

if lhs.type == FieldType.Scalar
    fd.value=lhs.value+rhs.value;
elseif lhs.type == FieldType.Vector
    fd.value.x=lhs.value.x+rhs.value.x;
    fd.value.y=lhs.value.y+rhs.value.y;
    fd.value.z=lhs.value.z+rhs.value.z;
elseif lhs.type == FieldType.Tensor
    fd.value.xx=lhs.value.xx+rhs.value.xx;
    fd.value.xy=lhs.value.xy+rhs.value.xy;
    fd.value.xz=lhs.value.xz+rhs.value.xz;
    fd.value.yy=lhs.value.yy+rhs.value.yy;
    fd.value.yz=lhs.value.yz+rhs.value.yz;
    fd.value.zz=lhs.value.zz+rhs.value.zz;
else
    error('Parameters error!');
end
end
