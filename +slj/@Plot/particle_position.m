function id = particle_position(prm, id, dstname, time)
%%
% @brief: plot the particles' position in real space 
% @info: written by Liangjin Song on 20211220 at Nanchang University
% @param: prm - the Parameters object
% @param: id - the particles' id that should plot
% @param: dstname - the distribution function name
% @param: time - the time that the particles should be plotted.
% @return: id - the particles' id that are actually drawn
%%
%% select the particles' id
spcs = prm.read(dstname);
id = intersect(id, spcs.value.id);

%% the particles' index
% nid= length(id);
% in = zeros(nid, 1, 'uint64');
% for i=1:nid
    % in(i) = find(spcs.value.id == id(i));
% end
in = find(ismember(spcs.value.id, id) == 1);

%% plot the particles' position
ss = prm.read('stream', time);
slj.Plot.stream(ss, prm.value.lx, prm.value.lz, 20);
hold on
plot(spcs.value.rx(in), spcs.value.rz(in), '*r');
end