function ff=simu_areaint(var,Lx,Ly,xb,yb)
%% area integral for reconnection simulation
%% current version can deal with only the rectangle without rotation
%% -------------written by Meng Zhou, Nov-24-2014----------------
nx=size(var,2);
ny=size(var,1);
dx=Lx/nx;
dy=Ly/ny;
ix1=floor(xb(1)/dx)+1;
ix2=floor(xb(2)/dx)+1;
iy1=floor((yb(1)+Ly/2)/dy)+1;
iy2=floor((yb(2)+Ly/2)/dy)+1;
%%
ff=sum(sum(var(iy1:iy2,ix1:ix2)));
%%
