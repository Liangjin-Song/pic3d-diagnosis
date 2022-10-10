function fd=filter2d(obj, n)
%%
% @info: writen by Liangjin Song on 20210922
% @brief: filter2d - smoothing the 2d field
% @param: obj - the Vector object
% @param: n - the smoothing times
% @return obj - smoothed field
%%
x=slj.Scalar(obj.x);
x=x.filter2d(n);
y=slj.Scalar(obj.y);
y=y.filter2d(n);
z=slj.Scalar(obj.z);
z=z.filter2d(n);
fd.x=x.value;
fd.y=y.value;
fd.z=z.value;
fd=slj.Vector(fd);
