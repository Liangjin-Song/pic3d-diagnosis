% center.x=0.1;
% center.y=1.2;
% bradius = 0.25;
% sradius = 0;
% id=spc.ring_particle_id(prm, 1, center, bradius, sradius);
% 
vrange.xrange=[0.17, 0.58];
vrange.yrange=[-0.07, 0.53];
vrange.zrange=[-100, 100];
idf=spc.rectangle_particle_id(prm, vrange);

in = find(ismember(spc.value.id, idf) == 1);

% nid= length(id);
% in = zeros(nid, 1, 'uint64');
% for i=1:nid
%     in(i) = find(spc.value.id == id(i));
% end
