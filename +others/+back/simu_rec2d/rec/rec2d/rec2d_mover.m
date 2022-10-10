function rec2d_mover(tag)
%% 
%% advance particles velocity and position using Lorentz equation and 
%% Newton motion equation.
%%
global bx by bz ex ey ez parameter
global x y vx vy vz
%%
mh=floor(size(x,1)/2);
nx=parameter.nx;
ny=parameter.ny;
qmi=parameter.qi/parameter.mi;
qme=parameter.qe/parameter.me;
if strcmp(tag,'ion')==1, qm=0.5*qmi; n1=1;
else qm=0.5*qme; n1=mh+1; 
end
%%
c=parameter.lightspeed;
npt=parameter.npt;
%%
exf=zeros(nx+3,ny+3);
eyf=zeros(nx+3,ny+3);
bxf=zeros(nx+3,ny+3);
byf=zeros(nx+3,ny+3);
bzf=zeros(nx+3,ny+3);
exf(2:nx+2,2:ny+2)=(ex(2:nx+2,2:ny+2)+ex(1:nx+1,2:ny+2))/2;
eyf(2:nx+2,2:ny+2)=(ey(2:nx+2,2:ny+2)+ey(2:nx+2,1:ny+1))/2;
bxf(2:nx+2,2:ny+2)=(bx(2:nx+2,2:ny+2)+bx(2:nx+2,1:ny+1))/2;
byf(2:nx+2,2:ny+2)=(by(2:nx+2,2:ny+2)+by(1:nx+1,2:ny+2))/2;
bzf(2:nx+2,2:ny+2)=(bz(2:nx+2,2:ny+2)+bz(1:nx+1,2:ny+2)...
                    +bz(2:nx+2,1:ny+1)+bz(2:nx+2,2:ny+2))/4;

for n=n1:n1+npt-1
     %%
      i=floor(x(n));
      dx=x(n)-i;
      j=floor(y(n));
      dy=y(n)-j;
      s11=(1-dx)*(1-dy);
      s21=dx*(1-dy);
      s12=(1-dx)*dy;
      s22=dx*dy;
  %% E-component interpolations:
     ex0=exf(i,j)*s11+exf(i+1,j)*s21+exf(i,j+1)*s12+exf(i+1,j+1)*s22;
     ex0=ex0*qm;
     %%
     ey0=eyf(i,j)*s11+eyf(i+1,j)*s21+eyf(i,j+1)*s12+eyf(i+1,j+1)*s22;
     ey0=ey0*qm;
     %%
     ez0=ez(i,j)*s11+ez(i+1,j)*s21+ez(i,j+1)*s12+ez(i+1,j+1)*s22;
     ez0=ez0*qm;

%%   B-component interpolations:
      bx0=bxf(i,j)*s11+bxf(i+1,j)*s21+bxf(i,j+1)*s12+bxf(i+1,j+1)*s22;
      bx0=bx0*qm;
      %%
      by0=byf(i,j)*s11+byf(i+1,j)*s21+byf(i,j+1)*s12+byf(i+1,j+1)*s22;
      by0=by0*qm;
      %%
      bz0=bzf(i,j)*s11+bzf(i+1,j)*s21+bzf(i,j+1)*s12+bzf(i+1,j+1)*s22;
      bz0=bz0*qm;
%%%%
 %% First half electric acceleration, with relativity's gamma
      g=c/sqrt(c^2-vx(n)^2-vy(n)^2-vz(n)^2);
      u0=g*vx(n)+ex0;
      v0=g*vy(n)+ey0;
      w0=g*vz(n)+ez0;
  %% First half magnetic rotation, with relativity's gamma:
      g=c/sqrt(c^2+u0^2+v0^2+w0^2);
      bx0=g*bx0;
      by0=g*by0;
      bz0=g*bz0;
      f=2/(1.+bx0*bx0+by0*by0+bz0*bz0);
      u1=(u0+v0*bz0-w0*by0)*f;
      v1=(v0+w0*bx0-u0*bz0)*f;
      w1=(w0+u0*by0-v0*bx0)*f;
 %%  Second half mag. rot'n & el. acc'n:
      u0=u0+v1*bz0-w1*by0+ex0;
      v0=v0+w1*bx0-u1*bz0+ey0;
      w0=w0+u1*by0-v1*bx0+ez0;
 %%  Relativity's gamma
      g=c/sqrt(c^2+u0^2+v0^2+w0^2);
      vx(n)=g*u0;
      vy(n)=g*v0;
      vz(n)=g*w0;
      
end
   
   %% Position advance:
    x=x+vx;
    y=y+vy;

return
end
    


