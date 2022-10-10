function [fd, id] = subspecies(obj, id)
%%
% @brief: selecting the particles according the particles' id
% @info: written by Liangjin Song on 20211220 at Nanchang University
% @param: id - the particles' id that should be selected from the Species. 
% @return: fd - the new Species
%%
%% make sure to include the given id
id = intersect(id, obj.value.id);

%% the particles' index
% nid=length(id);
% in = zeros(nid, 1, 'uint64');
% for i=1:nid
    % in(i) = find(obj.value.id == id(i));
% end
in = find(ismember(obj.value.id, id) == 1);

%% construct the new Species
value.id=obj.value.id(in);
value.rx=obj.value.rx(in);
value.ry=obj.value.ry(in);
value.rz=obj.value.rz(in);
value.vx=obj.value.vx(in);
value.vy=obj.value.vy(in);
value.vz=obj.value.vz(in);
value.weight=obj.value.weight(in);
range.xrange=[min(value.rx), max(value.rx)];
range.yrange=[min(value.ry), max(value.ry)];
range.zrange=[min(value.rz), max(value.rz)];
fd=slj.Species(obj.name, obj.time, range, value);
end