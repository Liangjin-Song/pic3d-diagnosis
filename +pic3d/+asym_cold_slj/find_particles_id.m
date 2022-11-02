% center.x=0.1;
% center.y=1.2;
% bradius = 0.25;
% sradius = 0;
% id=spc.ring_particle_id(prm, 1, center, bradius, sradius);
% 
vrange.xrange=[-100,100];
vrange.yrange=[-1.19, -0.84];
vrange.zrange=[-0.13, 0.43];
idf=spc.rectangle_particle_id(prm, vrange);

in = find(ismember(spc.value.id, idf) == 1);
id = spc.value.id(in(randi(length(idf),1, 100)))';
% nid= length(id);
% in = zeros(nid, 1, 'uint64');
% for i=1:nid
%     in(i) = find(spc.value.id == id(i));
% end
