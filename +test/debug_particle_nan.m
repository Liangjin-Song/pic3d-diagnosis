%% pic3d debug
indir='E:\PIC\Turbulence';

%% the process id
pid=500;
t=5;

k=zeros(1,pid);

for p=364:pid-1
    cd(indir);
    name=['prt_p',num2str(p),'_t',num2str(t)];
    fid=fopen([name,'_id.gdb'],'rb');
    prt_id=uint64(fread(fid,Inf,'uint64'));
    fclose(fid);
    fid=fopen([name,'.gdb'],'rb');
    prt=fread(fid,Inf,'float')';
    fclose(fid);
    np=length(prt)/7;
    prt=reshape(prt,np,7);
    k(p+1)=sum(prt(:,7),1);
end