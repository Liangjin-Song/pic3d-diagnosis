function stream(ss, lx, ly, number, color)
%%
% @info: writen by Liangjin Song on 20210504
% @brief: stream - 2-D contour plot of field
% @param: ss - the data for contour plot
% @param: lx - the vector in x direction
% @param: ly - the vector in y direction
% @param: number - the density of the lines
% @param: color - the line color and line style
%%
if nargin < 4
    number = 14;
end
if nargin < 5
    color = '-k';
end
if isa(ss,'slj.Scalar')
    ss=ss.value;
end
contour(lx, ly, ss, number, color);
axis on
set(gca,'fontsize',16,...
    'Xminortick','on','Yminortick','on','tickdir','out')
end
