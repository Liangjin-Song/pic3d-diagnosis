function mstart=rec2d_diag_field(nt,mstart)
%%
global parameter
global bx by bz ex ey ez
%%
wci=parameter.wci;
tfield=parameter.tfield;
nx=parameter.nx;
ny=parameter.ny;
%%
%%
nfield=floor(tfield/wci)+1;
if nt>=nfield(mstart)&nt-1<nfield(mstart),
    
    exf=0.5*(ex(2:nx+1,2:ny+1)'+ex(1:nx,2:ny+1)');
    eyf=0.5*(ey(2:nx+1,2:ny+1)'+ey(2:nx+1,1:ny)');
    ezf=ez(2:nx+1,2:ny+1)';
    bxf=0.5*(bx(2:nx+1,2:ny+1)'+bx(2:nx+1,1:ny)');
    byf=0.5*(by(2:nx+1,2:ny+1)'+by(1:nx,2:ny+1)');
    bzf=0.25*(bz(2:nx+1,2:ny+1)'+bz(1:nx,2:ny+1)'+...
              bz(2:nx+1,1:ny)'+bz(1:nx,1:ny)');
%% output the data in *mat file
%%
    time=num2str(tfield(mstart),'%06.2f');
    time=[time(1:3),'_',time(5:6)];
    eval(['exf_',time,'=exf;'])
    eval(['eyf_',time,'=eyf;'])
    eval(['ezf_',time,'=ezf;'])
    eval(['bxf_',time,'=bxf;'])
    eval(['byf_',time,'=byf;'])
    eval(['bzf_',time,'=bzf;'])
    %%
    mstart=mstart+1;
    if exist('field.mat','file')==0,
        save('field.mat',['exf_',time],['eyf_',time],['ezf_',time],['bxf_',time],...
            ['byf_',time],['bzf_',time]);
    else
        save('field.mat','-append',['exf_',time],['eyf_',time],['ezf_',time],...
            ['bxf_',time],['byf_',time],['bzf_',time]);
    end
    %%
end

return
end
        
        





    
