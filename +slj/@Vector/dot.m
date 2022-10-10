function fd = dot(lhs, rhs)
%%
% @info: writen by Liangjin Song on 20210918
% @breif: dot - fd = lhs dot rhs
% @param: lhs - left operator
% @param: rhs - right operator
% @return: fd - the result
%%
fd = lhs.x.*rhs.x + lhs.y.*rhs.y + lhs.z.*rhs.z;
fd = slj.Scalar(fd);
