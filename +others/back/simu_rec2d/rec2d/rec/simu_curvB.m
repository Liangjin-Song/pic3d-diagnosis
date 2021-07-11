function rad=simu_curvB(bx,by,bz,dr)
%% calculate the curvature radius of magnetic field lines
%%input:
%%  bx,by,bz: three components of magentic field
%%  dr: length of dx,dy and dz in the simulation
%%
%%output:
%%   rad: the curvature radius of magnetic field line
%% 
%%--------------------written by Meng Zhou, Aug-12-2013------------------
ds=0.5;
nx=size(bx,2);
nz=size(bx,1);
xx=0:nx+1;
zz=0:nz+1;  % periodic boundary condition

bxnew=zeros(nz+2,nx+2);
bynew=zeros(nz+2,nx+2);
bznew=zeros(nz+2,nx+2);
%%
bxnew(2:nz+1,2:nx+1)=bx;
bxnew(1,2:nx+1)=bx(nz,:);
bxnew(nz+2,2:nx+1)=bx(1,:);
bxnew(2:nz+1,1)=bx(:,nx);
bxnew(2:nz+1,nx+2)=bx(:,1);
%%
bynew(2:nz+1,2:nx+1)=by;
bynew(1,2:nx+1)=by(nz,:);
bynew(nz+2,2:nx+1)=by(1,:);
bynew(2:nz+1,1)=by(:,nx);
bynew(2:nz+1,nx+2)=by(:,1);
%%
bznew(2:nz+1,2:nx+1)=bz;
bznew(1,2:nx+1)=bz(nz,:);
bznew(nz+2,2:nx+1)=bz(1,:);
bznew(2:nz+1,1)=bz(:,nx);
bznew(2:nz+1,nx+2)=bz(:,1);
%%
bt=sqrt(bx.^2+by.^2+bz.^2);
nbx=bx./bt;
nbz=bz./bt;
%%
x0=zeros(nz,nx);
z0=zeros(nz,nx);
x1=zeros(nz,nx);
z1=zeros(nz,nx);
for i=1:nz
    for j=1:nx
    x0(i,j)=j-ds*nbx(i,j);
    z0(i,j)=i-ds*nbz(i,j);
    x1(i,j)=j+ds*nbx(i,j);
    z1(i,j)=i+ds*nbz(i,j);
    end
end
    %%
    bx0=interp2(xx,zz,bxnew,x0,z0);
    by0=interp2(xx,zz,bynew,x0,z0);
    bz0=interp2(xx,zz,bznew,x0,z0);
    bt0=sqrt(bx0.^2+by0.^2+bz0.^2);
    bx1=interp2(xx,zz,bxnew,x1,z1);
    by1=interp2(xx,zz,bynew,x1,z1);
    bz1=interp2(xx,zz,bznew,x1,z1);
    bt1=sqrt(bx1.^2+by1.^2+bz1.^2);
    %%
    curx=(bx1./bt1-bx0./bt0)/ds;
    curz=(bz1./bt1-bz0./bt0)/ds;
    cur=sqrt(curx.^2+curz.^2);
    rad=1./cur*dr;

    
    
    
    