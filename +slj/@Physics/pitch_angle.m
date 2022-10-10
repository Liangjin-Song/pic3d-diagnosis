function angle = pitch_angle(bx, by, bz, vx, vy, vz)
%%
% @info: writen by Liangjin Song on 20220914
% @brief: pitch_angle - calculate the pitch angel
% @param: bx, by, bz -- the magnetic field
% @param: vx, vy, vz -- the velocity
% @param: angle -- the pitch angle, the range is 0-180
%%
%% the unit vector of magnetic field
b = sqrt(bx.^2 + by.^2 + bz.^2);
bx = bx./b;
by = by./b;
bz = bz./b;
%% the unit vector of velocity
v = sqrt(vx.^2 + vy.^2 + vz.^2);
vx = vx./v;
vy = vy./v;
vz = vz./v;
%% the angle of between the two vectors
cosa = bx.*vx + by.*vy + bz.*vz;
cosa = acos(cosa);
angle = rad2deg(cosa);
end