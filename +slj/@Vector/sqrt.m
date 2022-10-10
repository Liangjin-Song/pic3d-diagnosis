function fd = sqrt(obj)
%%
% @info: writen by Liangjin Song on 20210804
% @brief: sqre - Calculate the modulus of a vector
% @param: obj - the Vector object
% @return: fd - the mdulus, it is the Scalar class
%%
fd=sqrt(obj.x.^2+obj.y.^2+obj.z.^2);
fd=slj.Scalar(fd);
end

