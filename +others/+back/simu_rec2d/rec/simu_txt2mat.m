%% save the *.txt data to the *.mat data for the simulation data
clear all
%%
dirr='G:\HallEM\size_80_40\Bg=2.0L=0.8\';
outdir=dirr;
%%
cd(dirr)
filenames0=dir;
%%
for ii=1:length(filenames0);
    if  ~strcmp(filenames0(ii).name,'.') && ~strcmp(filenames0(ii).name,'..')
        name1=filenames0(ii).name;
        nn=length(name1);
        if strcmp(name1(nn-2:nn),'txt')==1, 
        varname=[name1(1:nn-7),'_',name1(nn-5:nn-4)];
        tmp=load(name1);
        eval([varname,'=tmp;']);
        fname=[outdir,varname];
        save(fname,varname);
        clear(varname)
        end
    end
end
%%

        
         