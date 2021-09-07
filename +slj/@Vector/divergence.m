function fd = divergence(obj, prm)
%%
% @info: writen by Liangjin Song on 20210831
% @brief: divergence - calculate the divergence of a Vector
% @param: obj - the Vector object
% @param: prm - the Parameters
% @return: fd - fd = nabla cdot obj, and it is a Scalar object
%%
fd=obj.x;
if prm.value.dimension == 2
    % the plane is in the x-z plane
    fd(1:end-1,1:end-1)=obj.x(1:end-1,2:end)-obj.x(1:end-1,1:end-1)+obj.z(2:end,1:end-1)-obj.z(1:end-1,1:end-1);
    fd(end,:)=fd(end-1,:);
    fd(:,end)=fd(:,end-1);
    fd=slj.Scalar(fd);
else
    error('Parameters error!');
end
end
