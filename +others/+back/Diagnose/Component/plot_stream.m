function plot_stream(fd,Lx,Ly,number)
%2D contour plot of field, especially for field line display 
%--------------written by M.Zhou-----------------------------------
ndx=size(fd,2);
ndy=size(fd,1);
if nargin<4, number=20; end
%
xx=0:Lx/ndx:Lx-Lx/ndx;
yy=-Ly/2:Ly/ndy:Ly/2-Ly/ndy;
contour(xx,yy,fd,number,'k');
%[c,h]=contour(xx,yy,bb,44.5395,'k');
%clabel(c,h)
xlabel('X [c/\omega_{pi}]','fontsize',14)
ylabel('Z [c/\omega_{pi}]','fontsize',14)
