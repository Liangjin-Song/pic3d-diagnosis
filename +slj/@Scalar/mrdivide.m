function fd = mrdivide(lhs, rhs)
%%
% @info: writen by Liangjin Song on 20210504
% @breif: mrdivide - fd = lhs ./ rhs
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
fd=lhs.value./rhs.value;
fd=slj.Scalar(fd);
end
