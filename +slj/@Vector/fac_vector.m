function [para, perp] = fac_vector(obj, B)
%%
% @info: writen by Liangjin Song on 20211201 at Nanchang University
% @brief: transform the vector to the field-aligned coordinate
% @param: obj - the Vector object
% @param: B - the magnetic field, which is a Vector
% @return: para - components parallel to the magnetic field, 
%               which is a Vector
% @return: perp - components perpendicular to the magnetic field, 
%               which is a Vector
%%
%% the magnetic unit vector, b
bb=B.sqrt();
b.x=B.x./bb.value;
b.y=B.y./bb.value;
b.z=B.z./bb.value;
b=slj.Vector(b);

%% components parallel to the magnetic field
bb = obj.dot(b);
para.x=b.x.*bb.value;
para.y=b.y.*bb.value;
para.z=b.z.*bb.value;
para = slj.Vector(para);

%% components perpendicular to the magnetic field
perp = b.cross(obj);
perp = perp.cross(b);
end