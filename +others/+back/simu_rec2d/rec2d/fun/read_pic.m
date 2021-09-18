function data=read_pic(filename,tp,nx,ny,nz)
%% writen by Liangjin Song on 20190925
% read the binary data of pic simualtion
%
% filename is the file name, and it is a string.
% tp is the type of the data, and it is a string, such as 'float' or 'double'
% line row high are the three-dimensional box size
%%

range=[ny,nx,nz];
fid=fopen(filename,'rb');
data=fread(fid,Inf,tp);
fclose(fid);
data=reshape(data,range);

%{
fd=zeros(nx,ny,nz);
for k=1:nz
    fd(:,:,k)=data(:,:,k)';
end
%}
