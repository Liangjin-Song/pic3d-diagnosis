%% organize MMS data files in batches
% writen by Liangjin Song on 20201219
%
% read the list of cdf files in the folder, and move the files to the corresponding folder according to the file name
%%
%%
% the directory where the cdf files are stored
mmsdir='E:\Test\mms_test';

%% read the list of cdf files
cdflist={dir(fullfile(fullfile(mmsdir),'*.cdf')).name}';

%% process each file
% the number of cdf files
ncdf=length(cdflist);
% directory delimiter
dlmt='\';
for i=1:ncdf
    %% make sure the directory exists
    cd(mmsdir);
    filename=char(cdflist(i));
    path=get_path(filename,dlmt);
    cd(mmsdir);
    movefile(filename,path);
end
cd(mmsdir);

%% ************************************************************ function ********************************************** %%
%% check if the folder exists, if not, creat a new folder
function name=exist_dir(name)
    if exist(name,'dir')==0
        mkdir(name);
    end
    cd(name);
end

%% creat the corresponding directories according to the filename
function path=get_path(filename,dlmt)
    %% split the file name according to according to '_'
    matches=regexp(filename,'_','split');
    
    %% check if it is a mms data file
    if length(matches) < 6
        error(['Error: the file ''',filename,''' is not a mms data file.']);
    end
    
    %% get the corresponding path
    path='';
    for i=1:5
        pattern=exist_dir(char(matches(i)));
        path=[path,pattern,dlmt];
    end
    
    % year and month
    date=char(matches(6));
    path=[path,exist_dir(date(1:4)),dlmt];
    path=[path,exist_dir(date(5:6)),dlmt];
    
    % deal with the brst data, add the folder of the day
    if strcmp(char(matches(3)),'brst')
        path=[path,exist_dir(date(7:8)),dlmt];
    end
end
