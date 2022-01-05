function exist_directory(dir)
%% 
% @info: writen by Liangjin Song on 20210409 at Nanchang University
% @brief: check whether the folder exists, if not existing, create it, or escape.
% @param: dir -- the directory name
%%
if exist(dir,'dir')==0
	mkdir(dir);
end
end