function [jx,jy,jz]=simu_curlB(bx,by,bz,dr,c)
%% purpose: calculate the current from curlB
%%
%%--------------------written by M.Zhou, Aug,2010, at SDCC--------------
nx=size(bx,2);
nz=size(bx,1);
jx=zeros(nz,nx);
jy=zeros(nz,nx);
jz=zeros(nz,nx);
%%
for k=1:nz-1
     for i=1:nx-1
      jx(k,i)=-(by(k+1,i)-by(k,i));
      jy(k,i)=bx(k+1,i)-bx(k,i)-(bz(k,i+1)-bz(k,i));
      jz(k,i)=by(k,i+1)-by(k,i);
     end
end
%%
jx=jx*c/dr;
jy=jy*c/dr;
jz=jz*c/dr;
%% boundary condition
jx(:,nx)=jx(:,1);
jy(:,nx)=jy(:,1);
jz(:,nx)=jz(:,1);
jx(nz,:)=jx(nz-1,:);
jy(nz,:)=jy(nz-1,:);
jz(nz,:)=jz(nz-1,:);


