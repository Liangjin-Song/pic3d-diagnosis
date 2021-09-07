function fd=divergence(obj, prm)
%%
% @info: writen by Liangjin Song on 20210831
% @brief: divergence - calculate the divergence of a tensor, nabla cdot P 
% @param: obj - the tensor object
% @param: prm - the Parameters
% @return: fd - fd = nabla cdot obj, and it is a Vector object
%%
fd.x=obj.xx;
fd.y=obj.yy;
fd.z=obj.zz;
if prm.value.dimension == 2
    % the plane is in the x-z plane
    fd.x(1:end-1, 1:end-1)=obj.xx(1:end-1,2:end)-obj.xx(1:end-1,1:end-1)+obj.xz(2:end,1:end-1)-obj.xz(1:end-1,1:end-1);
    fd.y(1:end-1, 1:end-1)=obj.xy(1:end-1,2:end)-obj.xy(1:end-1,1:end-1)+obj.yz(2:end,1:end-1)-obj.yz(1:end-1,1:end-1);
    fd.z(1:end-1, 1:end-1)=obj.xz(1:end-1,2:end)-obj.xz(1:end-1,1:end-1)+obj.zz(2:end,1:end-1)-obj.zz(1:end-1,1:end-1);
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
