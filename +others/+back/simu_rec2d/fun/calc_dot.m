function vdot=calc_dot(ax,ay,az,bx,by,bz)
%% calculate A dot B
% writen by Liangjin Song on 20190603
% ax, ay, az, bx, by, bz are two vectors 
%
% vdot is the A dot B
%%
vdot=ax.*bx+ay.*by+az.*bz;
