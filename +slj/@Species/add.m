function fd = add(obj, rhs)
%%
% @brief: add the tow Species
% @info: written by Liangjin Song on 20211220 at Nanchang University
% @param: rhs - another operation value
% @return: fd - the new Species
%%
value.id = [obj.value.id, rhs.value.id];
value.rx = [obj.value.rx, rhs.value.rx];
value.ry = [obj.value.ry, rhs.value.ry];
value.rz = [obj.value.rz, rhs.value.rz];
value.vx = [obj.value.vx, rhs.value.vx];
value.vy = [obj.value.vy, rhs.value.vy];
value.vz = [obj.value.vz, rhs.value.vz];
value.weight = [obj.value.weight, rhs.value.weight];
fd=slj.Species(obj.name, obj.time, obj.range, value);
end