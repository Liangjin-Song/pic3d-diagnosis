function en = perpendicular_energy(obj, prm)
%% writen by Liangjin Song on 20210412
%% calculate the perpendicular energy
%%
wci=prm.value.wci;
%% magnetic field
bx=obj.value.bx;
by=obj.value.by;
bz=obj.value.bz;
b=sqrt(bx.^2+by.^2+bz.^2);
bx=bx./b;
by=by./b;
bz=bz./b;

%% perpendicular electric field
ex=obj.value.ex;
ey=obj.value.ey;
ez=obj.value.ez;
[ex, ey, ez]=cross(ex, ey, ez, bx, by, bz);
[ex, ey, ez]=cross(bx, by, bz, ex, ey, ez);

%% perpendicular velocity
[vx, vy, vz]=cross(obj.value.vx, obj.value.vy, obj.value.vz, bx, by, bz);
[vx, vy, vz]=cross(bx, by, bz, vx, vy, vz);

%% acceleration rate
rate=obj.q*(ex.*vx+ey.*vy+ez.*vz);
rate=(rate(2:end)+rate(1:end-1))/2;

%% the energy
nt=length(rate);
en=zeros(1, nt+1);
for i=2:nt+1
    en(i)=en(i-1)+rate(i-1)*0.02/wci;
end
end

%% ======================================================================== %%
function [cx, cy, cz]=cross(ax, ay, az, bx, by, bz)
    cx=ay.*bz-az.*by;
    cy=az.*bx-ax.*bz;
    cz=ax.*by-ay.*bx;
end

