function h=overview(fd, ss, lx, ly, norm, extra)
%%
% @info: writen by Liangjin Song on 20210504
% @brief: overview - plot the field and the stream line
% @param: fd - the field data
% @param: ss - the stream data
% @param: lx - the vector in x direction
% @param: ly - the vector in y direction
% @param: norm - the normalization of the field
% @param: extra - a structure containing the figure's information
% @return: h - the handle of the colorbar
%%
if isa(fd, 'slj.Scalar')
    fd=fd.value;
end
if isa(ss,'slj.Scalar')
    ss=ss.value;
end
fd=fd/norm;
if norm == 0
    error('Parameters error!');
end
h=slj.Plot.field2d(fd, lx, ly, extra);
range=caxis;
hold on;
slj.Plot.stream(ss, lx, ly);
caxis(range);
if nargin == 6
    slj.Plot.set_field_figure(extra);
end
end
