function fd = cross(lhs, rhs)
%%
% @info: writen by Liangjin Song on 20210921
% @brief: fd = lhs x rhs
% @param: lhs - left operator
% @param: rhs - right operator
% @return: fd - the result
%%
fd.x=lhs.y.*rhs.z-lhs.z.*rhs.y;
fd.y=lhs.z.*rhs.x-lhs.x.*rhs.z;
fd.z=lhs.x.*rhs.y-lhs.y.*rhs.x;
fd=slj.Vector(fd);
end
