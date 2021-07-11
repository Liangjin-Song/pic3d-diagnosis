function move_trajectory_figures(obj)
%% writen by Liangjin Song on 20210409
%% move trajectory figures
%%
dir='E:\PIC\Cold-Ions\mie100\out\Trajectory';
to='14';
id='id.txt';
cd(dir);
cd(to);
id=importdata(id);
cd(dir);
if isa(id, 'double')
    id=Utility.add_char_around(string(uint64(id)), '*');
else
    id=Utility.add_char_around(string(uint64(id.data)), '*');
end
Utility.move_files(id,to);

