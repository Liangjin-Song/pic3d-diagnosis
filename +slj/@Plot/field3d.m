function field3d(fd, lx, ly, lz, sx, sy, sz, extra)
%%
% @info: writen by Liangjin Song on 20210607
% @brief: plot the 3D field
% @param: fd - the array containing the field information
% @param: lx - the vector in x direction
% @param: ly - the vector in y direction
% @param: lz - the vector in z direction
% @param: sx - the slice in x direction
% @param: sy - the slice in y direction
% @param: sz - the slice in z direction
% @param: extra - a structure containing the figure's information
%%
% the coordinate metrix
[XX, YY, ZZ]=meshgrid(lx,ly,lz);
slice(XX,YY,ZZ,fd,sx,sy,sz,'linear');
colorbar;shading flat;
% set the figure
if nargin == 8
    slj.Plot.set_field_figure(extra);
end
end
