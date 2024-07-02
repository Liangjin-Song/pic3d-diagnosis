function fd = read_binary(name)
%% read the binary
fid = fopen(name, 'rb');
fd=fread(fid,Inf,'float');
fclose(fid);
end
