function fd = gradient(obj, prm)
%%
% @info: writen by Liangjin Song on 20210831
% @brief: gradient - calculate the gradient of a Scalar
% @param: obj - the Scalar object
% @param: prm - the Parameters
% @return: fd - fd = nabla obj, and it is a Vector object
%%
fd.x=obj.value;
fd.y=obj.value;
fd.z=obj.value;
if prm.value.dimension == 2
    % the plane is in the x-z plane
    fd.x(1:end-1,1:end-1)=obj.value(1:end-1,2:end)-obj.value(1:end-1,1:end-1);
    fd.y(:,:)=0;
    fd.z(1:end-1,1:end-1)=obj.value(2:end,1:end-1)-obj.value(1:end-1,1:end-1);
    % boundary
    fd.x(end,:)=fd.x(end-1,:);
    fd.y(end,:)=fd.y(end-1,:);
    fd.z(end,:)=fd.z(end-1,:);
    fd.x(:,end)=fd.x(:,end-1);
    fd.y(:,end)=fd.y(:,end-1);
    fd.z(:,end)=fd.z(:,end-1);
    fd=slj.Vector(fd);
else
    error('Parameters error!');
end
end
