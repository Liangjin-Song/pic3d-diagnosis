function rec2d_initial
%% initialize the field and particle 
%%
global bx by bz
global ex ey ez
global x y vx vy vz
global parameter
global ions lecs
%%
%% -----------Harris current sheet----------------
c=parameter.lightspeed;
nx=parameter.nx;
ny=parameter.ny;
npt=parameter.npt;
b0=parameter.b0;
di=parameter.di;
w0=parameter.w0;
bratio=parameter.bratio;
bg=parameter.bg;
vti=parameter.vti;
vte=parameter.vte;
vdi=parameter.vdi;
vde=parameter.vde;
%% create arrays
bx=zeros(nx+3,ny+3);
by=zeros(nx+3,ny+3);
bz=zeros(nx+3,ny+3);
ex=zeros(nx+3,ny+3);
ey=zeros(nx+3,ny+3);
ez=zeros(nx+3,ny+3);
x=zeros(npt*3,1);
y=zeros(npt*3,1);
vx=zeros(npt*3,1);
vy=zeros(npt*3,1);
vz=zeros(npt*3,1);
mh=floor(size(x,1)/2);
%%
yy0=(ny+2)/2;
yh=1.5:ny+3.5;
bx=ones(nx+3,1)*b0*tanh((yh-yy0)/w0);
bz=ones(nx+3,ny+3)*bg;
%%
%%
%%  --------------add initial perturbation-------------------
psi0=parameter.psi0*b0*di;
cxx=2.0*pi/nx;
cyy=pi/ny;
b0xx=-pi*psi0/ny;
b0yy=2.0*pi*psi0/nx;         
%%
for j=2:ny+1
for i=2:nx+1
%% add the perturbation to the current sheet    
fyy=cyy*(j-2.)-0.5*pi;
fxx=cxx*(i-2.)-pi;
bx(i,j)=bx(i,j) +b0xx*cos(fxx)*sin(fyy);
by(i,j)=by(i,j) +b0yy*sin(fxx)*cos(fyy);
end
end
%%
%% --------------------particle initialization----------------------
rand('twister',2);  %set the initial state of the random number generator
%% 
npc0=floor(npt*(1.-bratio));   %number of Harris sheet particles
npb0=floor(npt*bratio);   %number of background particles
npt0=npc0+npb0;
parameter.npt=npt0;
%% ---------------Harris current sheet particles first---------------
dxx=nx/npc0;
rr=2:ny/1000:ny+2;
ff=sech((rr(1:end-1)+ny/2000-ny/2-2)/w0).^2;
ff=ff/sum(ff);
dist=zeros(1001,1);
dist(1)=0;
for k=2:1001
    dist(k)=dist(k-1)+ff(k-1);
end
%
%%
for i=1:npc0
  xx=2+dxx*(i-0.5);
  ind=find(dist<rand);
  ind=ind(end);
  yy=(rr(ind)+rr(ind+1))/2;
% set the velocities
%% find the angle of the magnetic field
  bxr=b0*tanh((yy-yy0)/w0);
  sthetab = bxr / sqrt( bg*bg +bxr*bxr);
  cthetab = bg / sqrt( bg*bg +bxr*bxr);
%% find parallel velocity component Vx1
   vxi1 = vti*(sum(rand(12,1))-6);
   vxe1 = vte*(sum(rand(12,1))-6);
%% find perpendicular velocity components Vy1 and Vz1:
   vyi1 = vti*(sum(rand(12,1))-6);
   vzi1 = vti*(sum(rand(12,1))-6);
   vye1 = vte*(sum(rand(12,1))-6);
   vze1 = vte*(sum(rand(12,1))-6);
   %%
	x(i)=xx;
	y(i)=yy;
    lecs=lecs+1;
	x(mh+i)=x(i);
	y(mh+i)=y(i);  
%% transform from Vx1-Vy1-Vz1 into Vx-Vy-Vz:
	vx(i) = vxi1*sthetab - vyi1*cthetab;
	vz(i) = vxi1*cthetab + vyi1*sthetab-vdi; 
	vy(i) = vzi1;
    g=c/sqrt(c^2+vx(i)^2+vy(i)^2+vz(i)^2);
	vx(i)=vx(i)*g;
	vy(i)=vy(i)*g;
	vz(i)=vz(i)*g;
%% 
	vx(mh+i) = vxe1*sthetab - vye1*cthetab;
	vz(mh+i) = vxe1*cthetab + vye1*sthetab+vde; 
	vy(mh+i) = vze1;
    g=c/sqrt(c^2+vx(mh+i)^2+vy(mh+i)^2+vz(mh+i)^2);
	vx(mh+i)=vx(mh+i)*g;
	vy(mh+i)=vy(mh+i)*g;
	vz(mh+i)=vz(mh+i)*g;
    %%
end
%%
%% -------------background particles------------------------
dxx=nx/npb0;
for i=npc0+1:npc0+npb0
  xx=2+dxx*(i-npc0-0.5);
  yy=2+ny*rand;
% set the velocities
%% find the angle of the magnetic field
  bxr=b0*tanh((yy-yy0)/w0);
  sthetab = bxr / sqrt( bg*bg +bxr*bxr);
  cthetab = bg / sqrt( bg*bg +bxr*bxr);
%% find parallel velocity component Vx1
   vxi1 = vti*(sum(rand(12,1))-6);
   vxe1 = vte*(sum(rand(12,1))-6);
%% find perpendicular velocity components Vy1 and Vz1:
   vyi1 = vti*(sum(rand(12,1))-6);
   vzi1 = vti*(sum(rand(12,1))-6);
   vye1 = vte*(sum(rand(12,1))-6);
   vze1 = vte*(sum(rand(12,1))-6);
   %%
	x(i)=xx;
	y(i)=yy;
	x(mh+i)=x(i);
	y(mh+i)=y(i);  
%% transform from Vx1-Vy1-Vz1 into Vx-Vy-Vz:
	vx(i) = vxi1*sthetab - vyi1*cthetab;
	vz(i) = vxi1*cthetab + vyi1*sthetab; 
	vy(i) = vzi1;
    g=c/sqrt(c^2+vx(i)^2+vy(i)^2+vz(i)^2);
	vx(i)=vx(i)*g;
	vy(i)=vy(i)*g;
	vz(i)=vz(i)*g;
%% 
	vx(mh+i) = vxe1*sthetab - vye1*cthetab;
	vz(mh+i) = vxe1*cthetab + vye1*sthetab; 
	vy(mh+i) = vze1;
    g=c/sqrt(c^2+vx(mh+i)^2+vy(mh+i)^2+vz(mh+i)^2);
	vx(mh+i)=vx(mh+i)*g;
	vy(mh+i)=vy(mh+i)*g;
	vz(mh+i)=vz(mh+i)*g;
    %%
end
ions=npt0;
lecs=npt0;
parameter.ions=ions;
parameter.lecs=lecs;

return
end 

    






