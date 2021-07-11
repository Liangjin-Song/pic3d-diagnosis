function data=load_data(indir,t,var)
%% writen by Liangjin Song on 20181214
% indir is the input directory
% t is the time
% var is a cell including variable name
%
% data is a structure including the data of the variable
%
% this funciton loads the indicated data
%%
cd(indir);

% the naumber of variable
nvar=length(var);
data=[];

if nvar==0
    return;
end

%% load data
for i=1:nvar
    name=char(var(i));
    if strcmp(name,'stream')
        data.stream=read_data(name,t);
    elseif strcmp(name,'Bx')
        data.bx=read_data(name,t);
    elseif strcmp(name,'By')
        data.by=read_data(name,t);
    elseif strcmp(name,'Bz')
        data.bz=read_data(name,t);
    elseif strcmp(name,'vxi')
        data.vxi=read_data(name,t);
    elseif strcmp(name,'vyi')
        data.vyi=read_data(name,t);
    elseif strcmp(name,'vzi')
        data.vzi=read_data(name,t);
    elseif strcmp(name,'vxe')
        data.vxe=read_data(name,t);
    elseif strcmp(name,'vye')
        data.vye=read_data(name,t);
    elseif strcmp(name,'vze')
        data.vze=read_data(name,t);
    elseif strcmp(name,'Densi')
        data.ni=read_data(name,t);
    elseif strcmp(name,'Dense')
        data.ne=read_data(name,t);
    elseif strcmp(name,'Ex')
        data.ex=read_data(name,t);
    elseif strcmp(name,'Ey')
        data.ey=read_data(name,t);
    elseif strcmp(name,'Ez')
        data.ez=read_data(name,t);
    elseif strcmp(name,'presi')
        data.presi=read_data(name,t);
    elseif strcmp(name,'prese')
        data.prese=read_data(name,t);
    end
end
