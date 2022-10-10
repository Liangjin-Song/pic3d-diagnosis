% An electromagnetic code for testing the boundary condition for PIC simulation
%% the default grid size is 1, and the time step dt is 1. 
%% ---------------written by Meng Zhou, July/28/2014 at Wuhan----------
nx=256;
ny=128;
np=nx*ny*20;
c=0.6;
nt=1000;
%%%spectify the EM pulse source properties
x0=50;
y0=50;   
vph=1;
omega=0.5;

%% initialization
bx=zeros(nx+2,ny+2);
by=zeros(nx+2,ny+2);
bz=zeros(nx+2,ny+2);
ex=zeros(nx+2,ny+2);
ey=zeros(nx+2,ny+2);
ez=zeros(nx+2,ny+2);
rp=zeros(np,2);
vp=zeros(np,3);
%%
tic
for mm=1:nt
  %% Maxwell equation
  for j=2:ny+1
      for i=2:nx+1
      bx(i,j)=bx(i,j)-c*(ez(i,j+1)-ez(i,j));
      by(i,j)=by(i,j)+c*(ez(i+1,j)-ez(i,j));
      bz(i,j)=bz(i,j)+c*(ex(i,j+1)-ex(i,j)-ey(i+1,j)+ey(i,j));
      ex(i,j)=ex(i,j)+c*(bz(i,j)-bz(i,j-1));
      ey(i,j)=ey(i,j)+c*(bz(i-1,j)-bz(i,j));
      ez(i,j)=ez(i,j)+c*(by(i,j)-by(i-1,j)-bx(i,j)+bx(i,j-1));
      end
  end
  %% boundary condition
   
  %% advance particles
   for k=1:np
       rp(k,1)=rp(k,1);
       rp(k,2)=rp(k,2);
       vp(k,1)=vp(k,1);
       vp(k,2)=vp(k,2);
       vp(k,3)=vp(k,3);
   end

end
toc


