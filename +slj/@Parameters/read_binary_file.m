function fd = read_binary_file(filename, datatype)
%%
% @info: writen by Liangjin Song on 20210425
% @brief: read_binary_file - read the *.bsd file
% @param: filename - the file name of the binary file
% @param: datatype - the data type of the binary file
% @return: fd - the 1-D data of the binary file
%%
fid=fopen(filename,'rb');
if strcmp(datatype,'uint64')
    fd=uint64(fread(fid,Inf,datatype));
else
    fd=fread(fid,Inf,datatype);
end
fclose(fid);
end
