function K=calc_bulk_kinetic_energy_relativity(m0,n,vx,vy,vz,c)
%% calculate the bulk kinetic energy density 
% writen by Liangjin Song on 20190517 
%
% m0 is the mass of a species of particle at rest
% n is the density of the species of particle 
% vx, vy, vz is the bulk velocity of the species of particle 
% c is the light speed
%
% K is the bulk kinetic energy density 
%%
v2=vx.^2+vy.^2+vz.^2;
c2=c*c;

ndx=size(v2,2);
ndy=size(v2,1);
K=zeros(ndy,ndx);

for x=1:ndx
    for y=1:ndy
        m=m0/sqrt(1-v2(y,x)/c2); % relativity modification for mass
        K(y,x)=0.5*m*n(y,x)*v2(y,x);
    end
end
