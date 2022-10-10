function plot_veldist2(fd,d1,d2,norm,b0)
%plot the velocity distribution in 2D 
%
%  plot_veldist2(fd,d1,d2)
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
string={'V_{x}/V_{A}','V_{y}/V_{A}','V_{z}/V_{A}'};
%
fd=fd/norm;
np=size(fd,1);   %number of particles
%%
if nargin>4, 
    nb=b0./sqrt(dot(b0,b0));
    nperp1=cross(nb,[0,0,1]); nperp1=nperp1./sqrt(dot(nperp1,nperp1));
    nperp2=cross(nb,nperp1);  nperp2=nperp2./sqrt(dot(nperp2,nperp2));
    vpara=fd(:,1)*nb(1)+fd(:,2)*nb(2)+fd(:,3)*nb(3);
    vperp1=fd(:,1)*nperp1(1)+fd(:,2)*nperp1(2)+fd(:,3)*nperp1(3);
    vperp2=fd(:,1)*nperp2(1)+fd(:,2)*nperp2(2)+fd(:,3)*nperp2(3);
    %%
    fd=[vpara,vperp1,vperp2];
    string={'V_{||}/V_{A}','V_{\perp1}/V_{A}','V_{\perp2}/V_{A}'};
end
%%

v1=fd(:,d1);
v2=fd(:,d2);
v1max=max(v1);
v1min=min(v1);
v2max=max(v2);
v2min=min(v2);
v1gap=v1max-v1min;
v2gap=v2max-v2min;
v1max=v1max+0.25*v1gap;
v1min=v1min-0.25*v1gap;
v2max=v2max+0.25*v2gap;
v2min=v2min-0.25*v2gap;
vmax=max([abs(v1max),abs(v1min),abs(v2max),abs(v2min)]);
dv=2*vmax/50;
vv=-vmax:dv:vmax;
nv=length(vv);
dist=zeros(nv,nv);
%
for ii=1:np
    ix=floor((v1(ii)+vmax)/dv)+1;
    iy=floor((v2(ii)+vmax)/dv)+1;
    dist(iy,ix)=dist(iy,ix)+1;
end
dist=simu_filter2d(dist); % optional to do smooth
ind=find(dist==0);
dist(ind)=NaN;
%%
% pcolor(vv,vv,log10(dist)); shading flat
pcolor(vv,vv,dist); shading flat
colorbar;
hold on
plot([-100,100],[0,0],'k--','linewidth',2)
plot([0,0],[-100,100],'k--','linewidth',2)
%
axis([-vmax,vmax,-vmax,vmax]);
set(gca,'fontsize',14,'linewidth',2,'dataaspectratio',[1 1 1])
xlabel(string{d1},'fontsize',14)
ylabel(string{d2},'fontsize',14)
%


