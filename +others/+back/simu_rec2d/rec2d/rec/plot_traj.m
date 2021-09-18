function plot_traj(traj,dr,Lx,Ly,dt,t1,t2)
%plot the trajectory of the specific particle 
%s1 is the start time, while s2 is the end time.

%obtain the data
xx=traj(:,2)*dr;
zz=traj(:,3)*dr;
zz=zz-Ly/2;
mj=length(xx);
%%
n1=floor(t1/dt)+1;
n2=floor(t2/dt);
if n2>mj, n2=mj; end
xx=xx(n1:n2);
zz=zz(n1:n2);
N=length(xx);
%%
xt=zeros(100,N);
zt=zeros(100,N);
kk=zeros(100,1);
%
xt(1,1)=xx(1);
zt(1,1)=zz(1);
mm=1;
kk(mm)=1;
for j=2:N
  if abs(xx(j)-xx(j-1))>Lx/2||abs(zz(j)-zz(j-1))>Ly/2
    mm=mm+1;
    kk(mm)=1;
    xt(mm,kk(mm))=xx(j);
    zt(mm,kk(mm))=zz(j);
  else
      kk(mm)=kk(mm)+1;
      xt(mm,kk(mm))=xx(j);
      zt(mm,kk(mm))=zz(j);
  end
end
  %
  mm
  plot(xx(1),zz(1),'r+')
  hold on
  for i=1:mm
      plot(xt(i,1:kk(i)),zt(i,1:kk(i)))
  end
  plot(xx(N),zz(N),'ro')
  axis([0 Lx -Ly/2 Ly/2])
 
  
  
 