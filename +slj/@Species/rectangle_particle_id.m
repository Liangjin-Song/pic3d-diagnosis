function id = rectangle_particle_id(obj, prm, vrange)
%%
% @info: writen by Liangjin Song on 20211207 at Nanchang University
% @brief: get the particles' id in a velocity rectangle
% @param: prm - The Parameters object, or the velocity normalization value
% @param: vrange - the velocity range in three direction
% @return: id - the particles' id in the rectangle
%%
%% normalization
if isa(prm,'slj.Parameters')
    norm=prm.value.vA;
else
    norm=prm;
end
vx=obj.value.vx/norm;
vy=obj.value.vy/norm;
vz=obj.value.vz/norm;

%% number of particles
np = length(obj.value.id);
id=zeros(np,1,'uint64')-1;
m=0;
%% find particles
for p = 1:np
    if vx(p) >= vrange.xrange(1) && vx(p) <= vrange.xrange(2)
        if vy(p) >= vrange.yrange(1) && vy(p) <= vrange.yrange(2)
            if vz(p) >= vrange.zrange(1) && vz(p) <= vrange.zrange(2)
                m=m+1;
                id(m)=obj.value.id(p);
            end
        end
    end
end
if m == 0
    id=[];
else
    id=id(1:m);
end