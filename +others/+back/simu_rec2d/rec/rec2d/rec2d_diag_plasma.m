function mstart=rec2d_diag_plasma(nt,mstart)
%%
global parameter
global x y vx vy vz
global s0 s1 s2
%%
wci=parameter.wci;
tfield=parameter.tfield;
nx=parameter.nx;
ny=parameter.ny;
ions=parameter.ions;
lecs=parameter.lecs;
mh=floor(size(x,1)/2);
%%
nfield=floor(tfield/wci)+1;
if nt>=nfield(mstart)&nt-1<nfield(mstart),
    
%% ----------output ions--------------------
rho=zeros(nx+3,ny+3);
flwx=zeros(nx+3,ny+3);
flwy=zeros(nx+3,ny+3);
flwz=zeros(nx+3,ny+3);
%%
  for n=1:ions
   j=floor(y(n));
   i=floor(x(n));
   dx=x(n)-i;
   dy=y(n)-j;
   
   rho(i,j)    = rho(i,j)    + (1-dx)*(1-dy);
   rho(i+1,j)  = rho(i+1,j)  + dx*(1-dy);
   rho(i,j+1)  = rho(i,j+1)  + (1-dx)*dy;
   rho(i+1,j+1)= rho(i+1,j+1)+ dx*dy;
   
   flwx(i,j)    = flwx(i,j)    + vx(n)*(1-dx)*(1-dy);
   flwx(i+1,j)  = flwx(i+1,j)  + vx(n)*dx*(1-dy);
   flwx(i,j+1)  = flwx(i,j+1)  + vx(n)*(1-dx)*dy;
   flwx(i+1,j+1)= flwx(i+1,j+1)+ vx(n)*dx*dy;
   
   flwy(i,j)    = rho(i,j)    + vy(n)*(1-dx)*(1-dy);
   flwy(i+1,j)  = rho(i+1,j)  + vy(n)*dx*(1-dy);
   flwy(i,j+1)  = rho(i,j+1)  + vy(n)*(1-dx)*dy;
   flwy(i+1,j+1)= rho(i+1,j+1)+ vy(n)*dx*dy;
   
   flwz(i,j)    = rho(i,j)    + vz(n)*(1-dx)*(1-dy);
   flwz(i+1,j)  = rho(i+1,j)  + vz(n)*dx*(1-dy);
   flwz(i,j+1)  = rho(i,j+1)  + vz(n)*(1-dx)*dy;
   flwz(i+1,j+1)= rho(i+1,j+1)+ vz(n)*dx*dy;
    
  end
  nfi=rho(2:nx+1,2:ny+1)';
  flwxi=flwx(2:nx+1,2:ny+1)';
  flwyi=flwy(2:nx+1,2:ny+1)';
  flwzi=flwz(2:nx+1,2:ny+1)';
    

%% ----------output electrons--------------------
rho=zeros(nx+3,ny+3);
flwx=zeros(nx+3,ny+3);
flwy=zeros(nx+3,ny+3);
flwz=zeros(nx+3,ny+3);
%%
  for n=mh+1:mh+lecs
   j=floor(y(n));
   i=floor(x(n));
   dx=x(n)-i;
   dy=y(n)-j;
   
   rho(i,j)    = rho(i,j)    + (1-dx)*(1-dy);
   rho(i+1,j)  = rho(i+1,j)  + dx*(1-dy);
   rho(i,j+1)  = rho(i,j+1)  + (1-dx)*dy;
   rho(i+1,j+1)= rho(i+1,j+1)+ dx*dy;
   
   flwx(i,j)    = flwx(i,j)    + vx(n)*(1-dx)*(1-dy);
   flwx(i+1,j)  = flwx(i+1,j)  + vx(n)*dx*(1-dy);
   flwx(i,j+1)  = flwx(i,j+1)  + vx(n)*(1-dx)*dy;
   flwx(i+1,j+1)= flwx(i+1,j+1)+ vx(n)*dx*dy;
   
   flwy(i,j)    = rho(i,j)    + vy(n)*(1-dx)*(1-dy);
   flwy(i+1,j)  = rho(i+1,j)  + vy(n)*dx*(1-dy);
   flwy(i,j+1)  = rho(i,j+1)  + vy(n)*(1-dx)*dy;
   flwy(i+1,j+1)= rho(i+1,j+1)+ vy(n)*dx*dy;
   
   flwz(i,j)    = rho(i,j)    + vz(n)*(1-dx)*(1-dy);
   flwz(i+1,j)  = rho(i+1,j)  + vz(n)*dx*(1-dy);
   flwz(i,j+1)  = rho(i,j+1)  + vz(n)*(1-dx)*dy;
   flwz(i+1,j+1)= rho(i+1,j+1)+ vz(n)*dx*dy;
    
  end
  nfe=rho(2:nx+1,2:ny+1)';
  flwxe=flwx(2:nx+1,2:ny+1)';
  flwye=flwy(2:nx+1,2:ny+1)';
  flwze=flwz(2:nx+1,2:ny+1)';
%% output the data in *mat file
%%
    time=num2str(tfield(mstart),'%06.2f');
    time=[time(1:3),'_',time(5:6)];
    eval(['nfi_',time,'=nfi;'])
    eval(['flwxi_',time,'=flwxi;'])
    eval(['flwyi_',time,'=flwyi;'])
    eval(['flwzi_',time,'=flwzi;'])
    eval(['nfe_',time,'=nfe;'])
    eval(['flwxe_',time,'=flwxe;'])
    eval(['flwye_',time,'=flwye;'])
    eval(['flwze_',time,'=flwze;'])
    %%
    mstart=mstart+1;
    if exist('plasma.mat','file')==0,
        save('plasma.mat',['nfi_',time],['flwxi_',time],['flwyi_',time],['flwzi_',time],...
            ['nfe_',time],['flwxe_',time],['flwye_',time],['flwze_',time]);
    else
        save('plasma.mat','-append',['nfi_',time],['flwxi_',time],['flwyi_',time],...
            ['flwzi_',time],['nfe_',time],['flwxe_',time],['flwye_',time],['flwze_',time]);
    end
    %%
end

return
end
        
        





    
