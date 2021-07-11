function plot_veldist(fd,d1,d2,norm,b0)
%plot the velocity distribution in 2D 
%
%  plot_veldist(fd,d1,d2)
%
%input:
%   fd is the array containing three components of 
%   particle velocity
%   d1 is the component of the horizotal axes
%   d2 is the component of the vertical axes
%   norm is the nomalized velocity, such as Alfven velocity
%   b0 is the ambient magnetic field
%
%--------written by M.Zhou,April,2007, at SDCC---------------------
string={'Vx/V_{A}','Vy/V_{A}','Vz/V_{A}'};
m=size(fd,1);
%
fd=fd/norm;
v1max=max(fd(:,d1));
v1min=min(fd(:,d1));
v2max=max(fd(:,d2));
v2min=min(fd(:,d2));
v1gap=v1max-v1min;
v2gap=v2max-v2min;
v1max=v1max+0.25*v1gap;
v1min=v1min-0.25*v1gap;
v2max=v2max+0.25*v2gap;
v2min=v2min-0.25*v2gap;
vmax=max([abs(v1max),abs(v1min),abs(v2max),abs(v2min)]);
%
figure
scatter(fd(:,d1),fd(:,d2),'r.')
%
axis([-vmax,vmax,-vmax,vmax])
xlabel(string{d1})
ylabel(string{d2})
%
if nargin>4, 
    hold on
    bx=b0(d1);
    by=b0(d2);
    dr=vmax/20;
    xx=-vmax:dr:vmax;
    yy=by/bx*xx;
    plot(xx,yy,'linewidth',2);
end


