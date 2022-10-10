function lf=get_line2d(obj, x0, direction, prm, norm)
%%
% @info: writen by Liangjin Song on 20210521
% @brief: get_line2d - get a line from 2d field
% @param: obj - the Scalar object
% @param: x0 - the location of the line
% @param: direction - the direction of the line: 0 - cross, 1 - vertical
% @param: prm - the Parameters object
% @param: norm - normalized unit
% @return: lf - the field at the line
%%
lf=[];
fd=slj.Scalar(obj.x);
lf.lx=fd.get_line2d(x0, direction, prm, norm);
fd=slj.Scalar(obj.y);
lf.ly=fd.get_line2d(x0, direction, prm, norm);
fd=slj.Scalar(obj.z);
lf.lz=fd.get_line2d(x0, direction, prm, norm);
