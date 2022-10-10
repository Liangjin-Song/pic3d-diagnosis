function [para, perp]=field_aligned_coordinate_system(P,B)
%% change to field aligned coordinate system
% writen by Liangjin Song on 20201217
% P is the tensor
% B is the magnetic field
%%

bxx=B.x.*B.x;
byy=B.y.*B.y;
bzz=B.z.*B.z;
bxy=B.x.*B.y;
bxz=B.x.*B.z;
byz=B.y.*B.z;

para=P.xx.*bxx+P.yy.*byy+P.zz.*bzz+2*(P.xy.*bxy+P.xz.*bxz+P.yz.*byz);

bxx=(1-bxx)/2;
byy=(1-byy)/2;
bzz=(1-bzz)/2;
bxy=-bxy/2;
bxz=-bxz/2;
byz=-byz/2;

perp=P.xx.*bxx+P.yy.*byy+P.zz.*bzz+2*(P.xy.*bxy+P.xz.*bxz+P.yz.*byz);
