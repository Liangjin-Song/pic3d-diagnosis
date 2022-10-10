function [gx,gy,gz]=calc_gradient(fd,grids)
%% calculate the grad of the scalar field
% writen by Liangjin Song on 20180710
%   fd is the scalar field
%
% output
%   gx, gy, gz is the grad of fd
%%

nx=size(fd,2);
nz=size(fd,1);
gx=zeros(nz,nx);
gy=zeros(nz,nx);
gz=zeros(nz,nx);

for k=1:nz-1
    for i=1:nx-1
        gx(k,i)=fd(k,i+1)-fd(k,i);
        gz(k,i)=fd(k+1,i)-fd(k,i);
    end
end
gx=gx/grids;
gz=gz/grids;
%% boundary condition
gx(:,nx)=gx(:,1);
gz(:,nx)=gz(:,1);
gx(nz,:)=gx(nz-1,:);
gz(nz,:)=gz(nz-1,:);

%% asigned to full grids
% for k=1:nz-1
    % for i=1:nx-1
        % gx(k,i)=(gx(k,i)+gx(k,i+1))/2;
        % gz(k,i)=(gz(k,i)+gz(k+1,i))/2;
    % end
% end
% gx(nz,1:nx-1)=(gx(nz,1:nx-1)+gx(nz,2:nx))/2;
% gx(:,nx)=(gx(:,1)+gx(:,nx))/2;
% gz(1:nz-1,nx)=(gz(1:nz-1,nx)+gz(2:nz,nx))/2;
% gz(nz,:)=(gz(1,:)+gz(nz,:))/2;
