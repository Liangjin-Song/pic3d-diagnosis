function v = linear_interp_2d(px, pz, fd)
%% 
% @info: writen by Liangjin Song on 20220914
% @brief: linear_interp_2d - Linearly interpolate the field to px pz
% @param: px, pz -- Horizontal and vertical coordinates
% @param: fd - field
% @return: the value of the field at px, pz
%%
%% the grids
ax = floor(px);
az = floor(pz);

%% the value of the field
f1 = fd(az, ax);
f2 = fd(az, ax + 1);
f3 = fd(az + 1, ax + 1);
f4 = fd(az + 1, ax);

%% the weight
w1 = (1 - px + ax) .* (1 - pz + az);
w2 = (px - ax) .* (1 - pz + az);
w3 = (px - ax) .* (pz - az);
w4 = (1 - px + ax) .* (pz - az);

%% the value
v = f1 .* w1 + f2 .* w2 + f3 .* w3 + f4 .* w4;
end