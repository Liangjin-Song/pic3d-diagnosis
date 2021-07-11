function [f,xy]=get_line_data(fd,Lx,Ly,x0,norm,direction)
%
%form: f=plot_line(fd,Lx,Ly,x0,norm,[direction])
%
%input: 
%     fd is the data of field
%     Lx and Ly is the length and width of fd
%     x0 is the location of the line
%     norm is the normalized unit
%     direction indicate the direction of the line
%
%output:
%     f is the field along the line
%     xy is the array of the position
%-----------written by M.Zhou,2007, at SDCC------------------------
ndx=size(fd,2); ndy=size(fd,1);
fd=fd/norm;
if nargin<6, direction=0; end % 0 imply horizotal line
xx=0:Lx/ndx:Lx-Lx/ndx;
yy=-Ly/2:Ly/ndy:Ly/2-Ly/ndy;

% filter
% fd=simu_filter2d(fd);

%
% if nargin>6, color=cc; else color='k'; end
% if nargin>7, figure;  end
%%
if direction==0 
 x0=x0+Ly/2;
 ny=floor(x0/Ly*ndy)+1;
 ny1=ny+1;
 ddx=x0/Ly*ndy-ny+1.;
 f=fd(ny,:)*(1-ddx)+fd(ny1,:)*ddx;
 xy=xx;
 %%
%  plot(xx,f,color,'linewidth',1);
%  xlabel('X [c/\omega_{pi}]','fontsize',14)
%  axis([0 Lx -inf inf])
%  xlim([0 Lx])
else
    nx=floor(x0/Lx*ndx)+1;
    nx1=nx+1;
    ddx=x0/Lx*ndx-nx+1.;
    f=fd(:,nx)*(1-ddx)+fd(:,nx1)*ddx;
    xy=yy;
%     %%
%     plot(yy,f,color,'linewidth',1);
%     xlabel('Z [c/\omega_{pi}]','fontsize',14)
% %     axis([-Ly/2 Ly/2-Ly/ndy -inf inf])
%     xlim([-Ly/2 Ly/2])
end
