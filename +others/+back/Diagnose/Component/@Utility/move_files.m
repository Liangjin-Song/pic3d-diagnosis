function move_files(from, to)
%% writen by Liangjin Song on 20210409
%% move files
%% from is a cell
%% to is a directory
%%
nfiles=length(from);
for i=1:nfiles
    movefile(char(from(i)), to);
end
