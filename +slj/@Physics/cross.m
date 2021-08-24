function fd = cross(A, B)
%%
% @info: writen by Liangjin Song on 20210809
% @brief: cross - calculate A cross B
% @param: A - a Vector object
% @param: B - a Vector object
% @return: fd - fd=AxB
%%
fd.x=A.y.*B.z-A.z.*B.y;
fd.y=A.z.*B.x-A.x.*B.z;
fd.z=A.x.*B.y-A.y.*B.x;
fd = slj.Vector(fd);
end
