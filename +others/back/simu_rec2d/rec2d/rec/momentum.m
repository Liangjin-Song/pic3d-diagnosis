function [fconv,fpress,fen]=momentum(u,b,p,n,m,qe)
%calculate the electric field from momentum equation
%
%---------written by M.Zhou,May,2007, at SDCC----------------------
k=1; %the interval between two grids(useful if the data are recoreded
%      in compressed manner)
c=0.6;  % the light velocity
m=size(u,1);
n=size(u,2);
fconv=zeros(m,n,3);
fen=zeros(m,n,3);
fpress=zeros(m,n,3);
pxx=zeros(m,n);
pxy1=zeros(m,n);
pxy2=zeros(m,n);
pyz=zeros(m,n);
phivx_x=zeros(m,n);
phivx_y=zeros(m,n);
phivy_x=zeros(m,n);
phivy_y=zeros(m,n);
phivz_x=zeros(m,n);
phivz_y=zeros(m,n);
%-------first the convective term----------
for i=1:m
    for j=1:n
        fconv(i,j,1)=u(i,j,3)*b(i,j,2)-u(i,j,2)*b(i,j,3);
        fconv(i,j,2)=u(i,j,1)*b(i,j,3)-u(i,j,3)*b(i,j,1);
        fconv(i,j,3)=u(i,j,2)*b(i,j,1)-u(i,j,1)*b(i,j,2);
    end
end
%-------calculate the pressure term--------------
%first interpolate to half grid
pxx(1:m-1,:)=(p(1:m-1,:,1)+p(2:m,:,1))/2;
pxy1(:,1:n-1)=(p(:,1:n-1,2)+p(:,2:n,2))/2;
pxy2(1:m-1,:)=(p(1:m-1,:,2)+p(2:m,:,2))/2;
pxz(1:m-1,:)=(p(1:m-1,:,3)+p(2:m,:,3))/2;
pyy(:,1:n-1)=(p(:,1:n-1,4)+p(:,2:n,4))/2;
pyz(:,1:n-1)=(p(:,1:n-1,5)+p(:,2:n,5))/2;
%then solve the differential equation 
for i=2:m-1
    for j=2:n-1
        fpress(i,j,1)=pxx(i,j)-pxx(i-1,j)+pxy1(i,j)-pxy1(i,j-1);
        fpress(i,j,2)=pxy2(i,j)-pxy2(i-1,j)+pyy(i,j)-pyy(i,j-1);
        fpress(i,j,3)=pxz(i,j)-pxz(i-1,j)+pyz(i,j)-pyz(i,j-1);
    end
end
%-------calculate the inertial term(v.div(v))-------------
%first calculate the differential term
phivx_x(1:m-1,:)=u(2:m,:,1)-u(1:m-1,:,1);
phivx_y(:,1:n-1)=u(:,2:n,1)-u(:,1:n-1,1);
phivy_x(1:m-1,:)=u(2:m,:,2)-u(1:m-1,:,2);
phivy_y(:,1:n-1)=u(:,2:n,2)-u(:,1:n-1,2);
phivz_x(1:m-1,:)=u(2:m,:,3)-u(1:m-1,:,3);
phivz_y(:,1:n-1)=u(:,2:n,3)-u(:,1:n-1,3);
%
for i=2:m-1
    for j=2:n-1
        fen(i,j,1)=u(i,j,1)*phivx_x(i,j)+u(i,j,2)*phivx_y(i,j);
        fen(i,j,2)=u(i,j,1)*phivy_x(i,j)+u(i,j,2)*phivy_y(i,j);
        fen(i,j,3)=u(i,j,1)*phivz_x(i,j)+u(i,j,2)*phivz_y(i,j);
    end
end
%
fconv=fconv/c;
fpress=fpress./n/qe/k;
fen=fen.*m/qe/k;
