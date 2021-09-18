function [E_par,nb]=simu_Epara(Bx,By,Bz,Ex,Ey,Ez)
%plot the parallel field 
%
%form:  E_par=plot_Epara(Bx,By,Bz,Ex,Ey,Ez,Lx,Ly,[norm])
%
%input:
%     Bx,By,Bz is the three component of magnetic field
%     Ex,Ey,Ez is the three component of other field
%     Lx,Ly is the size of simulation box
%output:
%     E_par is the parallel field
%
%----------written by M.Zhou,2006, at SDCC-------------------------
%%----------modified by M.Zhou, 2013 at SDCC-----------------------
%%
ndx=length(Bx(1,:));
ndy=length(Bx(:,1));
nb=zeros(ndy,ndx,3);
E_par=zeros(ndy,ndx);
%calculate the direction of magnetic field.
for i=1:ndy
    for j=1:ndx
        nb(i,j,1)=Bx(i,j)/sqrt(Bx(i,j).^2+By(i,j).^2+Bz(i,j).^2);
        nb(i,j,2)=By(i,j)/sqrt(Bx(i,j).^2+By(i,j).^2+Bz(i,j).^2);
        nb(i,j,3)=Bz(i,j)/sqrt(Bx(i,j).^2+By(i,j).^2+Bz(i,j).^2);
    end 
end
%calculate the parallel electric field
for i=1:ndy
    for j=1:ndx
    E_par(i,j)=Ex(i,j)*nb(i,j,1)+Ey(i,j)*nb(i,j,2)+Ez(i,j)*nb(i,j,3);
    end 
end
%

%




