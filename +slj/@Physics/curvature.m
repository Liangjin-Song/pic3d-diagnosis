function [curv, R] = curvature(prm, B)
%%
% @info: writen by Liangjin Song on 20211201
% @brief: curvature - calculate the curvature and radius of curvature
% @param: prm - the Parameters object
% @param: B - the magnetic field, which is a vector
% @return: curv - the curvature, which is a Vector, and defined as
%                   (b dot nabla)b
% @return: R - the curvature radius, which is a Scalar, R=1/curv
% the curvature is defined as 
%       curv = (\vec{b} \cdot \nabla ) \vec{b}
%       \vec{b} is the magnetic unit vector
%%
%% the magnetic unit vector, b
bb=B.sqrt();
b.x=B.x./bb.value;
b.y=B.y./bb.value;
b.z=B.z./bb.value;
b=slj.Vector(b);

%% the curvature, (b dot nabla)b
curv.x=cv_component(b.x, b, prm);
curv.y=cv_component(b.y, b, prm);
curv.z=cv_component(b.z, b, prm);
curv=slj.Vector(curv);

%% the curvature radius
R=curv.sqrt();
R=1./R.value;
R=slj.Scalar(R);
end

function fd = cv_component(fd, b, prm)
%%
% @info: writen by Liangjin Song on 20211201
% @brief: curvature - calculate the curvature component
% @param: fd - the magnetic unit vector component
% @param: b - the magnetic unit vector
% @param: prm - the Parameters object
% @return: cv - the curvature component
%%
fd=slj.Scalar(fd);
fd=fd.gradient(prm);
fd=b.dot(fd);
fd=fd.value;
end