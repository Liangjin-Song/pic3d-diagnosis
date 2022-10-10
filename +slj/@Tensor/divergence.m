function fd=divergence(obj, prm)
%%
% @info: writen by Liangjin Song on 20210831
% @brief: divergence - calculate the divergence of a tensor, nabla cdot P 
% @param: obj - the tensor object
% @param: prm - the Parameters
% @return: fd - fd = nabla cdot obj, and it is a Vector object
%%
if prm.value.dimension == 2
    v.x=obj.xx;
    v.y=obj.xy;
    v.z=obj.xz;
    v=slj.Vector(v);
    fdx=v.divergence(prm);
    v=[];
    v.x=obj.xy;
    v.y=obj.yy;
    v.z=obj.yz;
    v=slj.Vector(v);
    fdy=v.divergence(prm);
    v=[];
    v.x=obj.xz;
    v.y=obj.yz;
    v.z=obj.zz;
    v=slj.Vector(v);
    fdz=v.divergence(prm);
    fd.x=fdx.value;
    fd.y=fdy.value;
    fd.z=fdz.value;
    fd=slj.Vector(fd);
else
    error('Parameters error!');
end
end
