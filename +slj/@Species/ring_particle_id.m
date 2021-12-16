function id = ring_particle_id(obj, prm, vdir, center, bradius, sradius)
%%
% @info: writen by Liangjin Song on 20211207 at Nanchang University
% @brief: get the particles' id in a velocity ring
% @param: prm - The Parameters object, or the velocity normalization value
% @param: vdir - the velocity direction:
%                  1: y-z direction
%                  2: x-z direction
%                  3: x-y direction
% @param: center - the center of the ring
% @param: bradius - radius of big circle
% @param: sradius - radius of small circle
% @return: id - the particles' id in the rectangle
%%
%% normalization
if isa(prm,'slj.Parameters')
    norm=prm.value.vA;
else
    norm=prm;
end

%% velocity
if vdir == 1
    vx=obj.value.vy/norm;
    vy=obj.value.vz/norm;
elseif vdir == 2
    vx=obj.value.vx/norm;
    vy=obj.value.vz/norm;
else
    vx=obj.value.vx/norm;
    vy=obj.value.vy/norm;
end
vx=vx-center.x;
vy=vy-center.y;
r=sqrt(vx.^2 + vy.^2);

%% number of particles
np = length(obj.value.id);
id=zeros(np,1,'uint64')-1;
m=0;

%% find particles
for p = 1:np
    if r(p) >= sradius && r(p) <= bradius
        m=m+1;
        id(m)=obj.value.id(p);
    end
end
if m == 0
    id=[];
else
    id=id(1:m);
end