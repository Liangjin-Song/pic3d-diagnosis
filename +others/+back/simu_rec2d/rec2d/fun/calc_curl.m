function [jx,jy,jz]=calc_curl(fx,fy,fz,grids)
%% calculate the curl
%%
%%--------------------written by M.Zhou, Aug,2010, at SDCC--------------
nx=size(fx,2);
nz=size(fx,1);
jx=zeros(nz,nx);
jy=zeros(nz,nx);
jz=zeros(nz,nx);
%%
for k=1:nz-1
     for i=1:nx-1
      jx(k,i)=-(fy(k+1,i)-fy(k,i));
      jy(k,i)=fx(k+1,i)-fx(k,i)-(fz(k,i+1)-fz(k,i));
      jz(k,i)=fy(k,i+1)-fy(k,i);
     end
end
%%
jx=jx/grids;
jy=jy/grids;
jz=jz/grids;
%% boundary condition
jx(:,nx)=jx(:,1);
jy(:,nx)=jy(:,1);
jz(:,nx)=jz(:,1);
jx(nz,:)=jx(nz-1,:);
jy(nz,:)=jy(nz-1,:);
jz(nz,:)=jz(nz-1,:);

%% assign to the full grids
