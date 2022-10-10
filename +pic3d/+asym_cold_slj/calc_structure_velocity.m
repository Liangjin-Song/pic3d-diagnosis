function [vx, vz] = calc_structure_velocity(fd2, fd1, di, dt, xrange, yrange)
%%
% @brief: calc_structure_velocity -- calculate the velocity of a structure
% @info: writen by Liangjin Song on 20220419 at Nanchang University
% @param: fd2 -- the field at next time step
% @param: fd1 -- the field at previous time step
% @param: dt -- the interval between the two step
% @param: xrange, yrange -- select the range from the field
% @return: vx, vz -- the velocity
%%

%% the subfield
fd1 = fd1(yrange(1):yrange(2), xrange(1):xrange(2));
fd2 = fd2(yrange(1):yrange(2), xrange(1):xrange(2));

%% the position
M = max(max(fd1));
[r1, c1] = find(fd1 == M);

M = max(max(fd2));
[r2, c2] = find(fd2 == M);

dx = c2 - c1;
dz = r2 - r1;

%% the velocity
vx = dt*dx/(di);
vz = dt*dz/(di);
end