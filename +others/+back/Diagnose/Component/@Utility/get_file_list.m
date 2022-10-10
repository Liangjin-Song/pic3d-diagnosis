function list=get_file_list(ch)
%% writen by Liangjin Song on 20210408
% get the file list according ch
%%
list={dir(fullfile(ch)).name}';
