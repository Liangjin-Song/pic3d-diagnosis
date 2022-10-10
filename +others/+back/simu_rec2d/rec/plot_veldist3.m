function [h1,h2]=plot_veldist3(fd,norm,b0)
%plot the velocity distribution in 2D 
%
%  plot_veldist2(fd,norm,[b0])
%
%input:
%   fd is the array containing three components of 
%   particle velocity
%   norm is the nomalized velocity, such as Alfven velocity
%   b0 is the ambient magnetic field
%
%--------written by M.Zhou,April,2007, at SDCC---------------------
string={'V_{x}/V_{A}','V_{y}/V_{A}','V_{z}/V_{A}'};
%
fd=fd/norm;
np=size(fd,1);   %number of particles
%%
if nargin>2, 
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
%%----------------------plot Vpara-Vperp1 or Vx-Vy-----------------
v1=fd(:,1);
v2=fd(:,2);
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
dv=2*vmax/50;   % number of grids 50 is optional
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
figure
h1=subplot('position',[0.1,0.3,0.4,0.4]);
% pcolor(vv,vv,log10(dist)); shading flat
pcolor(vv,vv,dist); shading flat
colorbar;
hold on
plot([-100,100],[0,0],'k--','linewidth',2)
plot([0,0],[-100,100],'k--','linewidth',2)
%
axis([-vmax,vmax,-vmax,vmax]);
set(gca,'fontsize',14,'linewidth',2,'dataaspectratio',[1 1 1],...
    'xminortick','on','yminortick','on')
xlabel(string{1},'fontsize',14)
ylabel(string{2},'fontsize',14)
%
%%------------------plot Vperp1-Vperp2 or Vy-Vz---------------------------
v1=fd(:,3);
v2=fd(:,2);
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
dv=2*vmax/50;   % number of grids 50 is optional
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
h2=subplot('position',[0.55,0.3,0.4,0.4]);
% pcolor(vv,vv,log10(dist)); shading flat
pcolor(vv,vv,dist); shading flat
colorbar;
hold on
plot([-100,100],[0,0],'k--','linewidth',1.5)
plot([0,0],[-100,100],'k--','linewidth',1.5)
%
axis([-vmax,vmax,-vmax,vmax]);
set(gca,'fontsize',14,'linewidth',1,'dataaspectratio',[1 1 1],...
       'xminortick','on','yminortick','on')
xlabel(string{3},'fontsize',14)


