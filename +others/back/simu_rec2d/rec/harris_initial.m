%% test the initial condition of Harris current sheet for PIC simulation
%% basic parameters
b0=1.;
c=0.6;
lz=0.5;
np=100000;
%%
nz=256;
zmin=-6;
zmax=6;
dz=(zmax-zmin)/nz;
z=zmin:dz:zmax;
%%
%%
bx=b0*tanh(z/lz);
by=0;
bz=0;
%%
jy=diff(bx)./diff(z);
plot(z(1:end-1),jy);
%%
rand('state',0);
ar=rand(np,1);
for i=1:np
   zp=harris_allocation(ar);
   vx=vrand;
   vy=vrand+vd;
   vz=vrand;
end

%%