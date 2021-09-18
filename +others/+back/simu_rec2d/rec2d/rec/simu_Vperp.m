function [vperpx,vperpy,vperpz]=simu_Vperp(Bx,By,Bz,Vx,Vy,Vz)
%calculate the perpendicular vectors of the given variable
%
%form:  [vperpx,vperpy,vpeprz]=simu_Vperp(Bx,By,Bz,Vx,Vy,Vz,Lx,Ly,[norm])
%
%input:
%     Bx,By,Bz is the three component of magnetic field
%     Vx,Vy,Vz is the three component of other field
%     Lx,Ly is the size of simulation box
%output:
%     vperpx,vperpy,vperpz is the three components of the perpendicular field
%%method:
%%      vperp=cross(cross(b,j),b)
%
%----------written by M.Zhou,2012, at SDCC-------------------------

ndx=length(Bx(1,:));
ndy=length(Bx(:,1));
nb=zeros(ndy,ndx,3);

%calculate the direction of magnetic field.
for i=1:ndy
    for j=1:ndx
        nb(i,j,1)=Bx(i,j)/sqrt(Bx(i,j).^2+By(i,j).^2+Bz(i,j).^2);
        nb(i,j,2)=By(i,j)/sqrt(Bx(i,j).^2+By(i,j).^2+Bz(i,j).^2);
        nb(i,j,3)=Bz(i,j)/sqrt(Bx(i,j).^2+By(i,j).^2+Bz(i,j).^2);
    end 
end
nb=reshape(nb,ndy*ndx,3);
Vx=reshape(Vx,ndy*ndx,1);
Vy=reshape(Vy,ndy*ndx,1);
Vz=reshape(Vz,ndy*ndx,1);
vtmp=[Vx,Vy,Vz];
%calculate the perpendicular vectors
vperp=cross(cross(nb,vtmp,2),nb,2);
vperpx=vperp(:,1);  vperpx=reshape(vperpx,ndy,ndx);
vperpy=vperp(:,2);  vperpy=reshape(vperpy,ndy,ndx);
vperpz=vperp(:,3);  vperpz=reshape(vperpz,ndy,ndx);
%

%




