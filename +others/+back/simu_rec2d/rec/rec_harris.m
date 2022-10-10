%% plot the initial field for a Harris equilibrium and an imposed
%% perturbation
clear all

nx=512;
nz=256;
xx=1:nx;
zz=1:nz;
%%
hs=10;
di=20;
L=5*di;
eta=di/2;
%%
b0=1;
phi0=0.1*b0*di;
%%
bx=b0.*tanh((zz'-nz/2)/hs)*ones(1,nx);
by=zeros(nz,nx);
bz=zeros(nz,nx);
%%
for i=1:nx
    for j=1:nz
        xn=xx-nx/2;
        zn=zz-nz/2;
        expo=exp(-(xn(i)^2+zn(j)^2)/eta^2);
        bx(j,i)=bx(j,i)-phi0*cos(2*pi*xn(i)/L)*expo*(pi/L*sin(pi*zn(j)/L)+...
              2*zn(j)/eta^2*cos(pi*zn(j)/L));
        bz(j,i)=bz(j,i)+phi0*cos(pi*zn(j)/L)*expo*(2*pi/L*sin(2*pi*xn(i)/L)+...
                 2*xn(i)/eta^2*cos(2*pi*xn(i)/L));
    end
end
%%
pot=mphi2D(bx,bz,1,1);
figure
contour(xx,zz,pot',40,'k');







