function plot_traj(traj,dk,i,s1,s2,dr,dt)
%plot the trajectory of the specific particle 
%dk is the number of particles be traced.
%s1 is the start time, while s2 is the end time.
N=s2-s1+1;
Lx=128.;
Ly=128.;
%obtain the data
xx=traj((s1-1)*dk+i:dk:(s2-1)*dk+i,1).*dr;
yy=traj((s1-1)*dk+i:dk:(s2-1)*dk+i,2).*dr;
vx=traj((s1-1)*dk+i:dk:(s2-1)*dk+i,3);
vy=traj((s1-1)*dk+i:dk:(s2-1)*dk+i,4);
vz=traj((s1-1)*dk+i:dk:(s2-1)*dk+i,5);
xt=zeros(100,N);
yt=zeros(100,N);
kk=zeros(100,1);
%
xt(1,1)=xx(1);
yt(1,1)=yy(1);
mm=1;
kk(mm)=1;
for j=2:N
  if abs(xx(j)-xx(j-1))>5.||abs(yy(j)-yy(j-1))>5.
    mm=mm+1;
    kk(mm)=1;
    xt(mm,kk(mm))=xx(j);
    yt(mm,kk(mm))=yy(j);
  else
      kk(mm)=kk(mm)+1;
      xt(mm,kk(mm))=xx(j);
      yt(mm,kk(mm))=yy(j);
  end
end
  %
  %xt=xt.*dx;
  %yt=yt.*dy;
  plot(xx(1),yy(1),'ro')
  hold on
  for i=1:mm
      plot(xt(i,1:kk(i)),yt(i,1:kk(i)))
  end
  plot(xx(N),yy(N),'r+')
  axis([0 Lx 0 Ly])
  %plot three component of velocity
  tt=s1*dt:dt:s2*dt;
  figure
  plot(tt,vx);
  figure
  plot(tt,vy);
  figure
  plot(tt,vz);