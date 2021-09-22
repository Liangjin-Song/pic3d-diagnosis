%% find the particles id
%{
indir='E:\PIC\Cold-Ions\data';

name='PVh_ts28800_x781-871_y361-481_z0-1';
norm=0.025;
cd(indir)
pve=pic3d_read_data(name);
pve.vx=pve.vx/norm;
pve.vy=pve.vy/norm;
pve.vz=pve.vz/norm;
%}
np=length(pve.id);

pid=[];
for i=1:np
    if pve.vx(i)>1.5
%         if pve.vy(i)>0
            pid=[pid,pve.id(i)];
%         end
    end
end