function value = resolve(obj)
%% writen by Liangjin Song on 20210325
% resolve the parameters
%%
cd(obj.value.indir);
%% open the file
filename='parameters.dat';
fid=fopen(filename);
while ~feof(fid)
    line = fgetl(fid);
    dict = strsplit(line,'=');
    if length(dict) == 2
        obj.value = matching(obj,strtrim(string(dict(1))),strtrim(string(dict(2))));
    end
end
fclose(fid);
value=obj.value;
end
