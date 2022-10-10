function trajectory_overview(obj)
%% writen by Liangjin Song on 20210412
%% plot the parameters of trajectory
%%
cd(obj.prm.value.indir);
%% get the file list of particle trajectory files
% list=Utility.get_file_list('traj*');
% list={'1606861246'};
list=load('E:\PIC\Cold-Ions\mie100\kinetic\g1.txt');
list=uint64(list);
nlist=length(list);


%% treatment for each file
for i=1:nlist
    name=num2str(list(i));
    % name=name(1:end-4);
    name=['trajh_id',name];
    obj.trajectory_survey(name);
    % obj.trajectory_stream_avi(name);
    % disp([num2str(i),'     ',name]);
end