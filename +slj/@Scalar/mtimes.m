function fd = mtimes(lhs, rhs)
%%
% @info: writen by Liangjin Song on 20210504
% @breif: mtimes - fd = lhs .* rhs
% @param: lhs - left operand
% @param: rhs - right operand
% @return: fd - the result
%%
if isa(lhs,'double')
    lhs=slj.Scalar(lhs);
end
if isa(rhs,'double')
    rhs=slj.Scalar(rhs);
end

if isa(rhs, 'slj.Vector')
    fd.x=lhs.value.*rhs.x;
    fd.y=lhs.value.*rhs.y;
    fd.z=lhs.value.*rhs.z;
    fd=slj.Vector(fd);
else
    fd=lhs.value.*rhs.value;
    fd=slj.Scalar(fd);
end
end
