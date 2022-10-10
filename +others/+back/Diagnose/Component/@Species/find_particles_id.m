function id = find_particles_id(obj, prm, vrange)
%% writen by Liangjin Song on 20210330
% find the particles id according the velocity
%%
%% normalization
if isa(prm,'Parameters')
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
