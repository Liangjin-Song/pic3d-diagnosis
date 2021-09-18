function [f,rr0]=plot_line2(fd,Lx,Ly,r0,r1,norm,cc,fig)
% this script can make lineplot along any stright line
%form: f=plot_line(fd,Lx,Ly,r0,r1,norm,[cc,fig])
%
%input: 
%     fd is the data of field
%     Lx and Ly is the length and width of fd
%     r0 r1 are begin and end points of the line
%     norm is the normalized unit
%     cc indicate the line color.
%     fig=1 means open a new figure file, otherwise not. 
%
%output:
%     f is the field along the line
%
%-----------written by M.Zhou,2007, at SDCC------------------------
%%----------modified by M.Zhou, 2011 at SDCC, to add oblique lines---------

ndx=size(fd,2); ndy=size(fd,1);
fd=fd/norm;
%
dr=Lx/ndx;
np=floor(sqrt((r1(2)-r0(2))^2+(r1(1)-r0(1))^2)/dr)+1;
%
if nargin>6, color=cc; else color='k'; end
if nargin>7, figure;  end
%%
costh=(r1(1)-r0(1))/sqrt((r1(1)-r0(1))^2+(r1(2)-r0(2))^2);
sinth=(r1(2)-r0(2))/sqrt((r1(1)-r0(1))^2+(r1(2)-r0(2))^2);
%%
f=zeros(np,1);
rr0=zeros(np,2);
for ii=1:np
    rx=r0(1)+dr*costh*(ii-1);
    ry=r0(2)+dr*sinth*(ii-1);
    rr0(ii,1)=rx;
    rr0(ii,2)=ry;
    ix=floor(rx/dr)+1;
    iy=floor((ry+Ly/2)/dr)+1;
    sx=rx/dr-ix+1;
    sy=(ry+Ly/2)/dr-iy+1;
    %
    if ix>ndx, ix=1; end
    if iy>ndy, iy=1; end
    ix1=ix+1;
    iy1=iy+1;
    if ix1>ndx, ix1=1; end
    if iy1>ndy, iy1=1; end
    f(ii)=fd(iy,ix)*(1-sx)*(1-sy)+fd(iy1,ix)*(1-sx)*sy+...
        fd(iy,ix1)*sx*(1-sy)+fd(iy1,ix1)*sx*sy;
end

%%%
 rr=0:dr:(np-1)*dr;
 plot(rr,f,color,'linewidth',1.5);
 axis([0 (np-1)*dr -inf inf])
 %%
 xlabel('distance [c/\omega_{pi}]','fontsize',14)
 set(gca,'fontsize',14,'xminortick','on','yminortick','on')




