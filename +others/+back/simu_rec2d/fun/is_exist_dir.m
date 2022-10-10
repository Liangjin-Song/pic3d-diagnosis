function is_exist_dir(dir)
%% writen by Liangjin Song on 20181226
% check whether the folder exists, if not existing, create it, or escape.
%%

if exist(dir,'dir')==0
	mkdir(dir);
end
