function exist_directory(dir)
%% writen by Liangjin Song on 20210409
% check whether the folder exists, if not existing, create it, or escape.
%%

if exist(dir,'dir')==0
	mkdir(dir);
end

