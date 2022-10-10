%% compare the distribution function
% writen by Liangjin Song on 20210330
%%
clear;
%% parameters
indir2='E:\PIC\Cold-Ions\mie100\kinetic';
indir1='E:\PIC\Cold-Ions\mie100\data';

%% read the file list
list={dir(fullfile(fullfile(indir1),'*_id.bsd')).name}';
%% process each file
% the number of files
nf=length(list);
%% read data
for i=1:nf
    name=char(list(i));
    name=name(1:end-7);
    cd(indir1);
    d1=pic3d_read_data(name);
    cd(indir2);
    d2=pic3d_read_data(name);
    if ~isequal(d1.vx,d2.vx)
        error(name);
    end
    if ~isequal(d1.vy,d2.vy)
        error(name);
    end
    if ~isequal(d1.vz,d2.vz)
        error(name);
    end
    if ~isequal(d1.rx,d2.rx)
        error(name);
    end
    if ~isequal(d1.ry,d2.ry)
        error(name);
    end
    if ~isequal(d1.rz,d2.rz)
        error(name);
    end
end