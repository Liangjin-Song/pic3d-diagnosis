function y = linear(point1, point2, x)
%%
% @info: writen by Liangjin Song on 20210502
% @brief: linear - get the point in the line determined by point1 and point1
% @param: point1 - a vector including two elements, used to determine the line
% @param: point2 - another vector including two elements, used to determine the line
% @param: x - the x position of the point on the line
% @return: y - the y position of the point on the line
%%
%% get the value
x0=point1(1);
y0=point1(2);
x1=point2(1);
y1=point2(2);
k=(y1-y0)/(x1-x0);
y=k*(x-x0)+y0;
end
