%% delete the low version of MMS data
% writen by Liangjin Song on 20210115
%%
% clear;
%% directory to save mms data
mmsdir='F:\mms'; %mms1/fpi/brst/l2/des-moms/2016/02/02'
%% get the cdf files' name and their version
% [name,version]=separate_version(getcdf(mmsdir));
%% find and delete low version data
nf=length(name);
% the index that the files should be deleted
index=[]; 
for i=1:nf
    index=[index;low_version(i,name,version)];
end
index(index==0)=[];
index=unique(index);
%% delete the data
nf=length(index);
for i=1:nf
    delete([char(name(index(i))),'_v',char(version(index(i))),'.cdf']);
end

%% ************************************************************ function ********************************************** %%
%% get all the cdf files in the directory
function cdflist=getcdf(mmsdir)
%% get all the path
path=regexp(genpath(mmsdir),';','split');
%% find all the cdf files
np=length(path)-1;
cdflist={};
for i=1:np
    subdir=char(path(i));
    cdf=dir(fullfile(fullfile(subdir),'*.cdf'));
    cdf={cdf.name}';
    nf=length(cdf);
    for n=1:nf
        cdflist=[cdflist;fullfile(subdir,char(cdf(n)))];
    end
end
end
%% separate the version number
function [name, version]=separate_version(cdflist)
nf=length(cdflist);
name={};
version={};
for i=1:nf
    cdf=char(cdflist(i));
    cdf=cdf(1:end-4);
    cdf=regexp(cdf,'_v','split');
    name=[name;cdf(1)];
    version=[version;cdf(2)];
end
end
%% convert the version number to a number
function s=delete_dot(ss)
s=abs(char(ss));
s(s==abs('.'))=[];
s=str2double(char(s));
end
%% compare the version,return the low version index
function index=cmp_version(m,n,version)
cm=delete_dot(version(m));
cn=delete_dot(version(n));
if cm==cn
    index=0;
elseif cm<cn
    index=m;
elseif cm>cn
    index=n;
end
end
%% find the low version data
function index=low_version(current,name,version)
index=[];
if contains(char(version(current)), '_p')
    return;
end
for i=1:current-1
    %% Skips the characters with the _p field
    if contains(char(version(i)), '_p')
        continue;
    end
    if strcmp(char(name(i)),char(name(current)))
        low=cmp_version(current,i,version);
        if low==0 || low==current
            index=low;
        else
            index=[index;low];
        end
    end
end
end