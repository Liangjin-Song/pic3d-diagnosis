function fn=simu_copylayer(ff)
%% enlarge the array with periodic boundary condition
%%
nx=size(ff,2);
ny=size(ff,1);
%%
fn=zeros(ny+2,nx+2);

fn(1,2:nx+1)=ff(end,:);
fn(ny+2,2:nx+1)=ff(1,:);
fn(2:ny+1,2:nx+1)=ff;
fn(2:ny+1,1)=ff(:,end);
fn(2:ny+1,nx+2)=ff(:,1);