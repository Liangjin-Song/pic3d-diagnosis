function fd = curl(obj, prm)
%%
% @info: writen by Liangjin Song on 20210811
% @brief: curl - calculate the curl of a Vector
% @param: obj - the Vector object
% @param: prm - the Parameters
% @return: fd - fd = nabla times obj, and it is a Vector object
%%
fd=obj;
if prm.value.dimension == 1
    % the value is in the x-direction
    fd.x(:)=0;
    fd.y(1:end-1)=obj.z(1:end-1)-obj.z(2:end);
    fd.z(1:end-1)=obj.y(2:end)-obj.y(1:end-1);
    % boundary
    fd.y(end)=obj.z(end)-obj.z(1);
    fd.z(end)=obj.y(1)-obj.y(end);
elseif prm.value.dimension == 2
    % the plane is in the x-z plane
    fd.x(1:end-1,1:end-1)=obj.y(1:end-1,1:end-1)-obj.y(2:end,1:end-1);
    fd.y(1:end-1,1:end-1)=obj.x(2:end,1:end-1)-obj.x(1:end-1,1:end-1)-obj.z(1:end-1,2:end)+obj.z(1:end-1,1:end-1);
    fd.z(1:end-1,1:end-1)=obj.y(1:end-1,2:end)-obj.y(1:end-1,1:end-1);
    % boundary
    fd.x(end,:)=fd.x(end-1,:);
    fd.y(end,:)=fd.y(end-1,:);
    fd.z(end,:)=fd.z(end-1,:);
    fd.x(:,end)=fd.x(:,end-1);
    fd.y(:,end)=fd.y(:,end-1);
    fd.z(:,end)=fd.z(:,end-1);
else
    error('Parameters error!');
end
end
