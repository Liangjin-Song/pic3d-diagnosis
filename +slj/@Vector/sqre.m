function fd = sqre(obj)
%%
% @info: writen by Liangjin Song on 20210804
% @brief: sqre - Calculate the square of the modulus of a vector
% @param: obj - the Vector object
% @return: fd - the square of the mdulus, it is the Scalar class
%%
fd=obj.x.^2+obj.y.^2+obj.z.^2;
fd=slj.Scalar(fd);
end
