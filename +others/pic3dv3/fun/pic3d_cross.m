function A=pic3d_cross(B, C)
%% calculate B cross C
% writen by Liangjin Song on 20201230
%%

A.x=B.y.*C.z-B.z.*C.y;
A.y=B.z.*C.x-B.x.*C.z;
A.z=B.x.*C.y-B.y.*C.x;