%% find the particles id
clear;
indir='E:\PIC\Cold-Ions\data';
outdir='E:\PIC\Cold-Ions\out';

name='PVh_ts28800_x561-581_y385-395_z0-1';
cd(indir);
pve=pic3d_read_data(name);
id=zeros(1,6);
id(1)=pve.id(get_max(pve.vx));
id(2)=pve.id(get_max(pve.vy));
id(3)=pve.id(get_max(pve.vz));
id(4)=pve.id(get_min(pve.vx));
id(5)=pve.id(get_min(pve.vy));
id(6)=pve.id(get_min(pve.vz));

function pid=get_max(v)
[~,pid]=max(v);
end
function pid=get_min(v)
[~,pid]=min(v);
end