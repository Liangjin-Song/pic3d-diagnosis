function h=plot_veldist_1d(fd,norm,b0)
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
%--------written by M.Zhou,July,2013, at Wuhan--------------------

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
%%----------------------plot f(Vpara)-----------------
v1=fd(:,1);
v1max=max(v1);
v1min=min(v1);
v1gap=v1max-v1min;
v1max=v1max+0.25*v1gap;
v1min=v1min-0.25*v1gap;
vmax=max([abs(v1max),abs(v1min)]);
dv=2*vmax/50;   % number of grids 50 is optional
vv=-vmax:dv:vmax;
nv=length(vv);
dist=zeros(nv,1);
%
for ii=1:np
    ix=floor((v1(ii)+vmax)/dv)+1;
    dist(ix)=dist(ix)+1;
end

%%
h=plot(vv,dist,'k','linewidth',1.5);
hold on
plot([0,0],[0,1000000],'k--','linewidth',1.5)
%
xlim([-vmax vmax])
ymax=max(dist)*1.5;
ylim([0 ymax])
set(gca,'fontsize',14,'linewidth',1.5,'xminortick','on','yminortick','on')
xlabel(string{1},'fontsize',14)
%


