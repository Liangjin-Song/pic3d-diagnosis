function [fd, lp] = pitch(obj, prm, B, pcs)
%%
% @brief: get the pitch angle distribution
% @info: written by Liangjin Song on 20211221 at Nanchang University
% @param: prm --- the Parameters Object
% @param: B --- the magnetic field, which is a Vector
% @param: pcs --- the precision, the default is 100
% @return: fd --- the pitch angle distribution
% @return: lp --- the range of the angle
%%
if nargin == 3
    pcs = 100;
end

%% the space
lp = linspace(0, 180, pcs);
fd = zeros(1, pcs);

%% the particles' position index
px = obj.value.rx;
px = (prm.value.nx - 1).*px./prm.value.Lx + 1;
px = round(px);
pz = obj.value.rz;
pz = (prm.value.nz - 1).*pz./prm.value.Lz + 1;
pz = round(pz);



%% get the pitch angle
np = length(obj.value.id);
for i = 1:np
    bx = B.x(pz(i), px(i));
    by = B.y(pz(i), px(i));
    bz = B.z(pz(i), px(i));
    b = sqrt(bx.^2 + by.^2 + bz.^2);
    bx = bx./b;
    by = by./b;
    bz = bz./b;
    vx=obj.value.vx(i);
    vy=obj.value.vy(i);
    vz=obj.value.vz(i);
    v = sqrt(vx.^2 + vy.^2 + vz.^2);
    vx = vx./v;
    vy = vy./v;
    vz = vz./v;
    cosa = bx.*vx + by.*vy + bz.*vz;
    cosa = acos(cosa);
    p = (pcs - 1)*cosa/pi + 1;
    a = floor(p);
    b = ceil(p);
    fd(a) = fd(a) + (b-p) * obj.value.weight(i);
    fd(b) = fd(b) + (p-a) * obj.value.weight(i);
end


