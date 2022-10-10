function mstart=rec2d_diag_energy(nt,mstart)
%%
global parameter
global bx by bz ex ey ez
global x y vx vy vz
%%
wci=parameter.wci;
tfield=parameter.tfield;
nx=parameter.nx;
ny=parameter.ny;
c=parameter.lightspeed;
mi=parameter.mi;
me=parameter.me;
ions=parameter.ions;
lecs=parameter.lecs;
mh=floor(size(x,1)/2);
%%
%%
nfield=floor(tfield/wci)+1;
if nt>=nfield(mstart)&nt-1<nfield(mstart),
 
  %%
  ee=sum(sum(ex(2:nx+1,2:ny+1).^2+ey(2:nx+1,2:ny+1).^2+ez(2:nx+1,2:ny+1).^2));
  em=sum(sum(bx(2:nx+1,2:ny+1).^2+by(2:nx+1,2:ny+1).^2+bz(2:nx+1,2:ny+1).^2));    
  ee=0.5*ee;
  em=0.5*c^2*em;
  
  eki=sum(c/sqrt(c^2-vx(1:ions).^2-vy(1:ions).^2-vz(1:ions).^2)-1);
  eki=eki*mi*c^2;
  eke=sum(c/sqrt(c^2-vx(mh+1:mh+lecs).^2-vy(mh+1:mh+lecs).^2-vz(mh+1:mh+lecs).^2)-1);
  eke=eke*me*c^2;
  %%
    ene=zeros(5,1);
    ene(1)=ee;
	ene(2)=em;
	ene(3)=eki;
	ene(4)=eke;
	ene(5)=ee+em+eki+eke;
    %%
    mstart=mstart+1;
    time=num2str(tfield(mstart),'%06.2f');
    time=[time(1:3),'_',time(5:6)];
    eval(['ene_',time,'=ene;'])
    if exist('energy.mat','file')==0,
        save('energy.mat',['ene_',time]);
    else
        save('energy.mat','-append',['ene_',time]);
    end
    %%
end

return
end
        
        





    
