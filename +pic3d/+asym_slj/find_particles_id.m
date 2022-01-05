% center.x=0.1;
% center.y=1.2;
% bradius = 0.25;
% sradius = 0;
% id=spc.ring_particle_id(prm, 1, center, bradius, sradius);
% 
% vrange.xrange=[0.4, 0.8];
% vrange.yrange=[-0.9, -0.7];
% vrange.xrange=[-0.65, -0.43];
% vrange.yrange=[-1, -0.83];
vrange.xrange=[-100, 100];
vrange.yrange=[-0.43, -0.28];
vrange.zrange=[0.23, 0.38];
id=spc.rectangle_particle_id(prm, vrange);

in = find(ismember(spc.value.id, id) == 1);

% nid= length(id);
% in = zeros(nid, 1, 'uint64');
% for i=1:nid
%     in(i) = find(spc.value.id == id(i));
% end
