function fd = subposition(obj, xrange, yrange, zrange)
%%
% @info: writen by Liangjin Song on 20210604
% @brief: subposition - get the subspecies according to the position
% @param: xrange - the position range in x direction
% @param: yrange - the position range in y direction
% @param: zrange - the position range in z direction
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

inx=find((obj.value.rx >= xrange(1)) & (obj.value.rx<=xrange(2)));
iny=find((obj.value.ry>=yrange(1)) & (obj.value.ry<=yrange(2)));
inz=find((obj.value.rz>=zrange(1)) & (obj.value.rz<=zrange(2)));
id=intersect(intersect(inx,iny),inz);
value.id=obj.value.id(id);
value.rx=obj.value.rx(id);
value.ry=obj.value.ry(id);
value.rz=obj.value.rz(id);
value.vx=obj.value.vx(id);
value.vy=obj.value.vy(id);
value.vz=obj.value.vz(id);
value.weight=obj.value.weight(id);
range.xrange=xrange;
range.yrange=yrange;
range.zrange=zrange;
fd=slj.Species(obj.name, obj.time, range, value);
end
