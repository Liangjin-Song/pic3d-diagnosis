function fd = plus(obj, rhs)
%%
% @info: writen by Liangjin Song on 20221212
% @breif: plus - fd = lhs + rhs
% @param: obj - left operand
% @param: rhs - right operand
% @return: fd - the result
%%
fd.xx = obj.xx + rhs.xx;
fd.xy = obj.xy + rhs.xy;
fd.xz = obj.xz + rhs.xz;
fd.yy = obj.yy + rhs.yy;
fd.yz = obj.yz + rhs.yz;
fd.zz = obj.zz + rhs.zz;
fd = slj.Tensor(fd);
end

