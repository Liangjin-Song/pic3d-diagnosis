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
    nx=prm.value.nx;
    if prm.value.reset
        % the plane is in the x-z plane
        nz=prm.value.nz;
    else
        % the plane is in the x-y plane
        nz=prm.value.ny;
    end
    for k=1:nz-1
        for i=1:nx-1
            fd(k,i)=obj.x(k,i+1)-obj.x(k,i)+obj.z(k+1,i)-obj.z(k,i);
        end
    end
    % boundary condition
    fd(:,nx)=fd(:,1);
    fd(nz,:)=fd(nz-1,:);
    fd=slj.Scalar(fd);
else
    error('Parameters error!');
end
end
