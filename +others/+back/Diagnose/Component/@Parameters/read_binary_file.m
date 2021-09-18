function fd=read_binary_file(obj, filename)
%% writen by Liangjin Song on 20210326
% read the binary file
%%
fid=fopen(filename,'rb');
if strcmp(obj.value.type,'uint64')
    fd=uint64(fread(fid,Inf,obj.value.type));
else
    fd=fread(fid,Inf,obj.value.type);
end
fclose(fid);
end
