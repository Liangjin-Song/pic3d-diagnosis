function fd = subvelocity(obj, xrange, yrange, zrange)
%%
% @info: writen by Liangjin Song on 20210604
% @brief: subvelocity - get the subspecies according to the velocity 
% @param: xrange - the velocity range in x direction
% @param: yrange - the velocity range in y direction
% @param: zrange - the velocity range in z direction
% @return: fd - the new Species
%%
if xrange(1)>=xrange(2)
    error('Parameters error!');
end
if yrange(1)>=yrange(2)
    error('Parameters error!');
end
if zrange(1)>=zrange(2)
    error('Parameters error!');
end
np=length(obj.value.id);
value.id=[];
value.rx=[];
value.ry=[];
value.rz=[];
value.vx=[];
value.vy=[];
value.vz=[];
value.weight=[];
for i=1:np
    if obj.value.vx(i)>=xrange(1) && obj.value.vx(i)<=xrange(2)
        if obj.value.vy(i)>=yrange(1) && obj.value.vy(i)<=yrange(2)
            if obj.value.vz(i)>=zrange(1) && obj.value.vz(i)<=zrange(2)
                value.id=[value.id, obj.value.id(i)];
                value.rx=[value.rx, obj.value.rx(i)];
                value.ry=[value.ry, obj.value.ry(i)];
                value.rz=[value.rz, obj.value.rz(i)];
                value.vx=[value.vx, obj.value.vx(i)];
                value.vy=[value.vy, obj.value.vy(i)];
                value.vz=[value.vz, obj.value.vz(i)];
                value.weight=[value.weight, obj.value.weight(i)];
            end
        end
    end
end
range.xrange=xrange;
range.yrange=yrange;
range.zrange=zrange;
fd=slj.Species(obj.name, obj.time, range, value);
end
