function ff=simu_shift(ff,Lx,Ly,shift)
%% shift the martrix in the x direction
%%
nx=size(ff,2);
ny=size(ff,1);

%%
dx=Lx/nx;
nshift=shift/dx;
%%
if shift>0,  % shift to right
tmp=ff;
ff(:,nshift+1:nx)=tmp(:,1:nx-nshift);
ff(:,1:nshift)=tmp(:,nx-nshift+1:nx);
else    %shift to left
tmp=ff;
ff(:,1:nx-nshift)=tmp(:,nshift+1:nx);
ff(:,nx-nshift+1:nx)=tmp(:,1:nshift);
end