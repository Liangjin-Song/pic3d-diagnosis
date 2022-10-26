%-----Test particle simulation.---------
%----originally Written by M.Zhou, Oct,28,2007, at SDCC-------------------
%%--------modified by M. Zhou, Junly 7 2022-------------------------------
%
clear
%----set some parameters, dr=1, dt=1.----------------
qm=-1;  %charge and mass ratio
c=10;    %light speed, though seems useless here, it 
%constrain the velocity of particles.
fc=0.01;   %cyclotron frequency

%% initialize the electromagnetic field model
model='EMwave';
b0=fc/abs(qm);
bini=[b0,0*b0,0.0*b0];
eini=[0,0,0*b0,0];
hx=40;
hz=10;
kv=2*pi/10*[1,0,0];
freq=0.008;
dphi=pi/2;
bw=[0,0.01*b0,0.01*b0];
ew=[0.*b0,0.02*b0,0.02*b0];
%set the total time steps and number of particles
nt=10000;   %total time steps
np=1;  %number of  particles
%set the initial position and velocity of particles
vpara=-0.02;   %parallel velocity
vperp=0.1;  %perpendicular velocity
%%
rp=zeros(np,3);
vp=zeros(np,3);
for i=1:np
    rp(i,1)=100;
    rp(i,2)=0;
    rp(i,3)=50;
    %
    [br,er]=emfield_new(bini,eini,rp(i,:),model,[hx,hz,kv,freq,dphi],bw,ew,0);
    nb=br./sqrt(dot(br,br));
    n0=rand(1,3);
    n0=n0/sqrt(dot(n0,n0));
    nperp1=cross(nb,n0);  nperp1=nperp1/sqrt(dot(nperp1,nperp1));
    nperp2=cross(nb,nperp1); nperp2=nperp2/sqrt(dot(nperp2,nperp2));
    vp(i,1)=vpara*dot(nb,[1 0 0])+vperp*dot(nperp1,[1 0 0])+vperp*dot(nperp2,[1 0 0]);
    vp(i,2)=vpara*dot(nb,[0 1 0])+vperp*dot(nperp1,[0 1 0])+vperp*dot(nperp2,[0 1 0]);
    vp(i,3)=vpara*dot(nb,[0 0 1])+vperp*dot(nperp1,[0 0 1])+vperp*dot(nperp2,[0 0 1]);
end
%record its position and velocity
ppx=zeros(nt+1,np);
ppy=zeros(nt+1,np);
ppz=zeros(nt+1,np);
vx=zeros(nt+1,np);
vy=zeros(nt+1,np);
vz=zeros(nt+1,np);
ppx(1,:)=rp(:,1)';
ppy(1,:)=rp(:,2)';
ppz(1,:)=rp(:,3)';
vx(1,:)=vp(:,1)';
vy(1,:)=vp(:,2)';
vz(1,:)=vp(:,3)';
%start repeated run
for it=1:nt
    %push the particles in each time step
      for j=1:np
          %obtain the mangetic and electric field on the particles
          [br,er]=emfield_new(bini,eini,rp(j,:),model,[hx,hz,kv,freq,dphi],bw,ew,it);
          %advance the velocity
          g=c/sqrt(c^2-dot(vp(j,:),vp(j,:)));   %relativity factor
          %g=1;
          vp(j,:)=vp(j,:)*g+er/2;
          g=c/sqrt(c^2+dot(vp(j,:),vp(j,:)));
          br=br*g;
          boris=2/sqrt(1+dot(br,br));
          v1=boris*(vp(j,:)+cross(vp(j,:),br)/2);
          vp(j,:)=vp(j,:)+cross(v1,br)/2+er/2;
          g=c/sqrt(c^2+dot(vp(j,:),vp(j,:)));
          vp(j,:)=vp(j,:)*g;
          %advance the position
          rp(j,:)=rp(j,:)+vp(j,:);
      %
      ppx(it+1,:)=rp(:,1)';
      ppy(it+1,:)=rp(:,2)';
      ppz(it+1,:)=rp(:,3)';
      vx(it+1,:)=vp(:,1)';
      vy(it+1,:)=vp(:,2)';
      vz(it+1,:)=vp(:,3)';
      end
end
%%
%%
energy=zeros(nt+1,np);
for k=1:np
    energy(:,k)=c./sqrt(c^2-vx(:,k).^2-vy(:,k).^2-vz(:,k).^2)-1.0;
end

%====================plot the trajectory of particles=====================
figure
plot3(ppx(1,:),ppy(1,:),ppz(1,:),'g+','markersize',10)
hold on
plot3(ppx,ppy,ppz,'r.')
xlim=1.2*max(abs(ppx));
ylim=1.2*max(abs(ppy));
zlim=1.2*max(abs(ppz));
% axis([-xlim xlim -ylim ylim -zlim zlim])
box on
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
%%
figure
plot(vx)


