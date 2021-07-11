function fd = cross(obj, rhs)
%% writen by Liangjin Song on 20210329
% calculate obj cross rhs
%%

if obj.type ~= FieldType.Vector && rhs.type ~= FieldType.Vector
    error('Parameters error!');
end
fd = Field();
fd.time=obj.time;
fd.type=obj.type;
fd.norm=obj.norm;
% obj cross rhs
fd.value.x=obj.value.y.*rhs.value.z-obj.value.z.*rhs.value.y;
fd.value.y=obj.value.z.*rhs.value.x-obj.value.x.*rhs.value.z;
fd.value.z=obj.value.x.*rhs.value.y-obj.value.y.*rhs.value.x;
end
