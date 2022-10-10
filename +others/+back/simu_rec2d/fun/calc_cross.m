function [cx,cy,cz]=calc_cross(ax,ay,az,bx,by,bz)
%% calculate a cross b
% writen by Liangjin Song on 20190531
%
cx=ay.*bz-az.*by;
cy=az.*bx-ax.*bz;
cz=ax.*by-ay.*bx;
