function rec2d_current
%% calculate the electric current using the charge conservation method
%%
global x y vx vy vz 
global ajx ajy ajz
global parameter
global s0 s1 s2

%%
nx=parameter.nx;
ny=parameter.ny;
ajx=zeros(nx+3,ny+3);
ajy=zeros(nx+3,ny+3);
ajz=zeros(nx+3,ny+3);
ions=parameter.ions;
lecs=parameter.lecs;
mh=floor(size(x,1)/2);

xold=x-vx;
yold=y-vy;
%%-------------------------ion current-------------------------- 
q=parameter.qi;
%%    
for i=1:ions
  %%
  if floor(x(i))==floor(xold(i))&floor(y(i))==floor(yold(i)),
     rec2d_depsit(x(i),y(i),xold(i),yold(i),q,vz(i));
  
  elseif floor(x(i))==floor(xold(i)),
      ymid=0.5*(1+floor(y(i))+floor(yold(i)));
      xmid=xold(i)+(ymid-yold(i))/(y(i)-yold(i))*(x(i)-xold(i));
      w1=vz(i)*(ymid-yold(i))/(y(i)-yold(i));
      w2=vz(i)-w1;
      rec2d_depsit(x(i),y(i),xmid,ymid,q,w2);
      rec2d_depsit(xmid,ymid,xold(i),yold(i),q,w1);
      
  elseif floor(y(i))==floor(yold(i)),
      xmid=0.5*(1+floor(x(i))+floor(xold(i)));
      ymid=yold(i)+(xmid-xold(i))/(x(i)-xold(i))*(y(i)-yold(i));
      w1=vz(i)*(xmid-xold(i))/(x(i)-xold(i));
      w2=vz(i)-w1;
      rec2d_depsit(x(i),y(i),xmid,ymid,q,w2);
      rec2d_depsit(xmid,ymid,xold(i),yold(i),q,w1);
      
  else
      kx=0.5*(1+floor(xold(i))+floor(x(i)));
      ky=0.5*(1+floor(yold(i))+floor(y(i)));
      x1=(ky-yold(i))/(y(i)-yold(i))*(x(i)-xold(i))+xold(i);
      y1=(y(i)-yold(i))/(x(i)-xold(i))*(x1-xold(i))+yold(i);
      x2=kx;
      y2=(y(i)-yold(i))/(x(i)-xold(i))*(x2-xold(i))+yold(i);
      if abs(x1-xold(i))>abs(x2-xold(i)),
          tmpx=x1;tmpy=y1;
          x1=x2;  y1=y2;
          x2=tmpx; y2=tmpy;
      end
      w1=vz(i)*(x1-xold(i))/(x(i)-xold(i));
      w2=vz(i)*(x2-x1)/(x(i)-xold(i));
      w3=vz(i)-w1-w2;
      rec2d_depsit(x(i),y(i),x2,y2,q,w3);
      rec2d_depsit(x2,y2,x1,y1,q,w2);
      rec2d_depsit(x1,y1,xold(i),yold(i),q,w1);
  end
  %%
end

%%------------------electron current-------------------------- 
q=parameter.qe;
%%    
for i=mh+1:mh+lecs
  %%
  if floor(x(i))==floor(xold(i))&floor(y(i))==floor(yold(i)),
     rec2d_depsit(x(i),y(i),xold(i),yold(i),q,vz(i));
  
  elseif floor(x(i))==floor(xold(i)),
      ymid=0.5*(1+floor(y(i))+floor(yold(i)));
      xmid=xold(i)+(ymid-yold(i))/(y(i)-yold(i))*(x(i)-xold(i));
      w1=vz(i)*(ymid-yold(i))/(y(i)-yold(i));
      w2=vz(i)-w1;
      rec2d_depsit(x(i),y(i),xmid,ymid,q,w2);
      rec2d_depsit(xmid,ymid,xold(i),yold(i),q,w1);
      
  elseif floor(y(i))==floor(yold(i)),
      xmid=0.5*(1+floor(x(i))+floor(xold(i)));
      ymid=yold(i)+(xmid-xold(i))/(x(i)-xold(i))*(y(i)-yold(i));
      w1=vz(i)*(xmid-xold(i))/(x(i)-xold(i));
      w2=vz(i)-w1;
      rec2d_depsit(x(i),y(i),xmid,ymid,q,w2);
      rec2d_depsit(xmid,ymid,xold(i),yold(i),q,w1);
      
  else
      kx=0.5*(1+floor(xold(i))+floor(x(i)));
      ky=0.5*(1+floor(yold(i))+floor(y(i)));
      x1=(ky-yold(i))/(y(i)-yold(i))*(x(i)-xold(i))+xold(i);
      y1=(y(i)-yold(i))/(x(i)-xold(i))*(x1-xold(i))+yold(i);
      x2=kx;
      y2=(y(i)-yold(i))/(x(i)-xold(i))*(x2-xold(i))+yold(i);
      if abs(x1-xold(i))>abs(x2-xold(i)),
          tmpx=x1;tmpy=y1;
          x1=x2;  y1=y2;
          x2=tmpx; y2=tmpy;
      end
      w1=vz(i)*(x1-xold(i))/(x(i)-xold(i));
      w2=vz(i)*(x2-x1)/(x(i)-xold(i));
      w3=vz(i)-w1-w2;
      rec2d_depsit(x(i),y(i),x2,y2,q,w3);
      rec2d_depsit(x2,y2,x1,y1,q,w2);
      rec2d_depsit(x1,y1,xold(i),yold(i),q,w1);
  end
  %%
end
%% boundary condtion
%% periodic in the X direction and conducting boundary at Y direction
ajx(nx+1,:)=ajx(nx+1,:)+ajx(1,:);
ajx(2,:)=ajx(2,:)+ajx(nx+2,:);
ajx(1,:)=ajx(nx+1,:);
ajx(nx+2,:)=ajx(nx+2,:);
%%
ajy(2,:)=ajy(2,:)+ajy(nx+2,:);
ajy(3,:)=ajy(3,:)+ajy(nx+3,:);
ajy(nx+1,:)=ajy(nx+1,:)+ajy(1,:);
ajy(1,:)=ajy(nx+1,:);
ajy(nx+2,:)=ajy(2,:);
%%
ajz(2,:)=ajz(2,:)+ajz(nx+2,:);
ajz(3,:)=ajz(3,:)+ajz(nx+3,:);
ajz(nx+1,:)=ajz(nx+1,:)+ajz(1,:);
ajz(1,:)=ajz(nx+1,:);
ajz(nx+2,:)=ajz(2,:);

%%  smooth the current
wajx=ajx; 
wajy=ajy;
wajz=ajz;
ajx(2:nx+1,3:ny+1)=s0*wajx(2:nx+1,3:ny+1)+s1*wajx(1:nx,3:ny+1)+...
                   s1*wajx(3:nx+2,3:ny+1)+s1*wajx(2:nx+1,2:ny)+...
                   s1*wajx(2:nx+1,4:ny+2)+s2*wajx(3:nx+2,4:ny+2)+...
                   s2*wajx(3:nx+2,2:ny)+s2*wajx(1:nx,4:ny+2)+...
                   s2*wajx(1:nx,2:ny);
 %%
 ajy(2:nx+1,3:ny)=s0*wajy(2:nx+1,3:ny)+s1*wajy(1:nx,3:ny)+...
                   s1*wajy(3:nx+2,3:ny)+s1*wajy(2:nx+1,2:ny-1)+...
                   s1*wajy(2:nx+1,4:ny+1)+s2*wajy(3:nx+2,4:ny+1)+...
                   s2*wajy(3:nx+2,2:ny-1)+s2*wajy(1:nx,4:ny+1)+...
                   s2*wajy(1:nx,2:ny-1);
   %%
 ajz(2:nx+1,3:ny+1)=s0*wajz(2:nx+1,3:ny+1)+s1*wajz(1:nx,3:ny+1)+...
                   s1*wajz(3:nx+2,3:ny+1)+s1*wajz(2:nx+1,2:ny)+...
                   s1*wajz(2:nx+1,4:ny+2)+s2*wajz(3:nx+2,4:ny+2)+...
                   s2*wajz(3:nx+2,2:ny)+s2*wajz(1:nx,4:ny+2)+...
                   s2*wajz(1:nx,2:ny);
               







  

