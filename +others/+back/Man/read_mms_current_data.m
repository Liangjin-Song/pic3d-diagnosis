function data=read_mms_current_data(filename)
%% read mms current data from a text file
% writen by Liangjin Song on 20200718

% open file
fid=fopen(filename);
data=textscan(fid,'%s %s %f %f');
fclose(fid);

% add the negative sign, because of the error dealing when calculating the electron current in IDL
data{4}=-data{4};

