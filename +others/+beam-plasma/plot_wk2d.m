function plot_wk2d(wk,dt,dr)
%plot the w-k or kx-ky diagram
nx=length(wk(:,1));
ny=length(wk(1,:));
dx=2*pi/(2*nx*dr);
%dx=2*pi/819.2;
%dy=2*pi/256;
dy=2*pi/(2*ny*dt);
%
xx=0:dx:dx*(nx-1);
yy=0:dy:dy*(ny-1);
[X,Y]=meshgrid(xx,yy);
%fwx=fwx';
contour(X,Y,wk','k')
%pcolor(X,Y,wk');colorbar;
%shading flat