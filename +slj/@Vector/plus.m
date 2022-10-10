function fd = plus(lhs, rhs)
%%
% @info: writen by Liangjin Song on 20210504
% @breif: plus - fd = lhs + rhs
% @param: lhs - left operand
% @param: rhs - right operand
% @return: fd - the result
%%
if isa(rhs,'double')
    rhs=slj.Scalar(rhs);
end

if isa(rhs,'slj.Scalar')
    fd.x=lhs.x+rhs.value;
    fd.y=lhs.y+rhs.value;
    fd.z=lhs.z+rhs.value;
    fd=slj.Vector(fd);
elseif isa(rhs, 'slj.Vector')
    fd.x=lhs.x+rhs.x;
    fd.y=lhs.y+rhs.y;
    fd.z=lhs.z+rhs.z;
    fd=slj.Vector(fd);
else
    error('Parameters error!');
end
end
