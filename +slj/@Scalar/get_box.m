function fd = get_box(obj, prm, xx, yy, zz)
%%
% @info: writen by Liangjin Song on 20210823
% @breif: get_box - select a box from the field
% @param: obj - the Scalar object
% @param: prm - the Parameters object
% @param: xx - the xrange of the box
% @param: yy - the yrange of the box
% @param: zz - the zrange of the box
% @return: fd - the box
%%
if prm.value.dimension == 1
    value=obj.value(xx);
elseif prm.value.dimension == 2
    value=obj.value(yy, xx);
else
    value=obj.value(yy, xx, zz);
end
fd=slj.Scalar(value);
end
