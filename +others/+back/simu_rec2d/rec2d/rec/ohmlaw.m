function [fconv,fhall,fpress]=ohmlaw(u,b,jc,p,n,e)
%calculate all the term of the generalized ohm's law
%
%  [fconv,fhall,fpress]=ohmlaw(ui,b,jc,p,n,e)
%
%input:
%     ui is the ion bulk velocity
%     b is the magnetic field
%     jc is the current density
%     p is the electron pressure,they are (Pxx,Pxy,Pxz,Pyy,Pyz)
%     n is the electron density
%     e is the electron charge
%output:
%     fconv is the convective term
%     fhall is the hall term
%     fpress is the electron pressure term
%all the above vectors have three components (the pressure have five
% components )
%
%--------------written by M.Zhou, April, 2007, SDCC----------------
k=1; %the interval between two grids(useful if the data are recoreded
%      in compressed manner)
c=0.6;  % the light velocity
m=size(u,1);
n=size(u,2);
fconv=zeros(m,n,3);
fhall=zeros(m,n,3);
fpress=zeros(m,n,3);
pxx=zeros(m,n);
pxy1=zeros(m,n);
pxy2=zeros(m,n);
pyz=zeros(m,n);
%
for i=1:m
    for j=1:n
        fconv(i,j,1)=u(i,j,3)*b(i,j,2)-u(i,j,2)*b(i,j,3);
        fconv(i,j,2)=u(i,j,1)*b(i,j,3)-u(i,j,3)*b(i,j,1);
        fconv(i,j,3)=u(i,j,2)*b(i,j,1)-u(i,j,1)*b(i,j,2);
        fhall(i,j,1)=jc(i,j,2)*b(i,j,3)-jc(i,j,3)*b(i,j,2);
        fhall(i,j,2)=jc(i,j,3)*b(i,j,1)-jc(i,j,1)*b(i,j,3);
        fhall(i,j,3)=jc(i,j,1)*b(i,j,2)-jc(i,j,2)*b(i,j,1);
    end
end
%calculate the pressure term
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
%
fconv=fconv/c;
fhall=fhall./n/c;
fpress=-fpress./n/e/k;



