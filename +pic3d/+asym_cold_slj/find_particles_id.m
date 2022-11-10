% center.x=0.1;
% center.y=1.2;
% bradius = 0.25;
% sradius = 0;
% id=spc.ring_particle_id(prm, 1, center, bradius, sradius);
% 
vrange.xrange=[0.78,0.99];
vrange.yrange=[-100, 100];
vrange.zrange=[-0.53, 0.08];
idf=spc.rectangle_particle_id(prm, vrange);

in = find(ismember(spc.value.id, idf) == 1);
id = spc.value.id(in(randi(length(idf),1, 100)))';
% nid= length(id);
% in = zeros(nid, 1, 'uint64');
% for i=1:nid
%     in(i) = find(spc.value.id == id(i));
% end
