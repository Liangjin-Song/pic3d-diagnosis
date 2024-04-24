function fd = dot(obj, v)
%%
% @brief: calculate P \cdot V, where V is a Vector.
% @info: written by Liangjin Song on 20240424.
% @param: obj - left operand
% @param: v - right operand
% @return: fd - the result
%%
if ~isa(v, 'slj.Vector')
    error('Parameters error!');
end

fd.x = obj.xx .* v.x + obj.xy .* v.y + obj.xz .* v.z;
fd.y = obj.xy .* v.x + obj.yy .* v.y + obj.yz .* v.z;
fd.z = obj.xz .* v.x + obj.yz .* v.y + obj.zz .* v.z;
fd = slj.Vector(fd);
end