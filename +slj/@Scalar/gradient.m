function fd = gradient(obj, prm)
%%
% @info: writen by Liangjin Song on 20210831
% @brief: gradient - calculate the gradient of a Scalar
% @param: obj - the Scalar object
% @param: prm - the Parameters
% @return: fd - fd = nabla obj, and it is a Vector object
%%
if prm.value.dimension == 2
    % the plane is in the x-z plane
    nx=size(obj.value,2);
    nz=size(obj.value,1);
    fd.x=zeros(nz,nx);
    fd.y=zeros(nz,nx);
    fd.z=zeros(nz,nx);
    for k=1:nz-1
        for i=1:nx-1
            fd.x(k,i)=obj.value(k,i+1)-obj.value(k,i);
            fd.z(k,i)=obj.value(k+1,i)-obj.value(k,i);
        end
    end
    % boundary
    fd.x(:,nx)=fd.x(:,1);
    fd.z(:,nx)=fd.z(:,1);
    fd.x(nz,:)=fd.x(nz-1,:);
    fd.z(nz,:)=fd.z(nz-1,:);
else
    error('Parameters error!');
end

fd=slj.Vector(fd);
end
