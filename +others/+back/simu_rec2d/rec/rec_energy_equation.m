%%
clear

%% calculate each term in the energy conservation equation
%% electrons and ions are calculated separately
tt=50:100;
nx=2400;
ny=1200;
Lx=120;
Ly=60;
dr=2;  %the grid size
mass=0.004667;  %electron or ion mass
qe=-0.00035;
dt=1/0.000375;
% pn=7; %the number of panels
% gap=0.02;
% height=(1-0.1)/pn-gap;
%%
norm1=abs(qe)*857*0.03*0.03;  %J.E
norm2=mass*0.3;  %me*VAe^2
% norm2=658;
% norm3=0.6;
% norm4=658*0.03;
ymin=-17;
ymax=-13;
iy1=floor((ymin+Ly/2)/(Ly/ny))+1;
iy2=floor((ymax+Ly/2)/(Ly/ny));
%%
dirr='I:\PIC simulation\DF\';
dirout='I:\PIC simulation\DF\figures\';
cd(dirr)
load('pos.mat');
%% 
nt=length(tt);
sk_jE1=zeros(nt,1);   %source term for bulk kinetic energy from J.E
sk_dp1=zeros(nt,1);   %source term for bulk kinetic energy from thermal pressure
su1=zeros(nt,1);    %source term for the thermal energy
dk1=zeros(nt,1);   %bulk kinetic energy transport
dq1=zeros(nt,1);   % divergence of heat flux
dh1=zeros(nt,1);   %divergence of enthalpy flux
uu1=zeros(nt,1);
kt1=zeros(nt,1);
for i=1:nt
it=num2str(tt(i),'%06.2f');
it=[it(1:3),'_',it(5:6)];
tmp=load(['Ex_t',it,'.mat']); tmp=struct2cell(tmp); ex=tmp{1};
tmp=load(['Ey_t',it,'.mat']); tmp=struct2cell(tmp); ey=tmp{1};
tmp=load(['Ez_t',it,'.mat']); tmp=struct2cell(tmp); ez=tmp{1};
tmp=load(['vxe_t',it,'.mat']); tmp=struct2cell(tmp); vx=tmp{1};
tmp=load(['vye_t',it,'.mat']); tmp=struct2cell(tmp); vy=tmp{1};
tmp=load(['vze_t',it,'.mat']); tmp=struct2cell(tmp); vz=tmp{1};
tmp=load(['Dense_t',it,'.mat']); tmp=struct2cell(tmp); ns=tmp{1};
tmp=load(['prese_t',it,'.mat']); tmp=struct2cell(tmp); pres=tmp{1};
tmp=load(['qfluxe_t',it,'.mat']); tmp=struct2cell(tmp); qflux=tmp{1};
tmp=load(['stream_t',it,'.mat']); tmp=struct2cell(tmp); ss=tmp{1};

%% re-arrange data
pxx=pres(:,1);  pxx=reshape(pxx,nx,ny); pxx=pxx';
pxy=pres(:,2);  pxy=reshape(pxy,nx,ny); pxy=pxy';
pxz=pres(:,3);  pxz=reshape(pxz,nx,ny); pxz=pxz';
pyy=pres(:,4);  pyy=reshape(pyy,nx,ny); pyy=pyy';
pyz=pres(:,5);  pyz=reshape(pyz,nx,ny); pyz=pyz';
pzz=pres(:,6);  pzz=reshape(pzz,nx,ny); pzz=pzz';

%% kinetic energy flux, K=mnv2V/2
kt=0.5*mass.*ns.*(vx.^2+vy.^2+vz.^2);
kx=kt.*vx;
ky=kt.*vy;
kz=kt.*vz;

%% thermal energy of particles
u=(pxx+pyy+pzz)/2;  %thermal energy of ions/electron
%%

%% enthalpy flux, H=(P.V+uV)
hx=u.*vx+pxx.*vx+pxy.*vy+pxz.*vz;
hy=u.*vy+pxy.*vx+pyy.*vy+pyz.*vz;
hz=u.*vz+pxz.*vx+pyz.*vy+pzz.*vz;
%%
%% heatflux
qx=qflux(:,1); qx=reshape(qx,nx,ny); qx=qx';
qy=qflux(:,2); qy=reshape(qy,nx,ny); qy=qy';
qz=qflux(:,3); qz=reshape(qz,nx,ny); qz=qz';

%% interpolate p,q,h and k on the half grid
%% p
pxx=simu_copylayer(pxx);
pxy=simu_copylayer(pxy);
pxz=simu_copylayer(pxz);
pyy=simu_copylayer(pyy);
pyz=simu_copylayer(pyz);
pzz=simu_copylayer(pzz);
%%
pxx_interp=(pxx(:,1:end-1)+pxx(:,2:end))/2;
pxy_interp=(pxy(:,1:end-1)+pxy(:,2:end))/2;
pxz_interpx=(pxz(:,1:end-1)+pxz(:,2:end))/2;
pxz_interpz=(pxz(1:end-1,:)+pxz(2:end,:))/2;
pyz_interp=(pyz(1:end-1,:)+pyz(2:end,:))/2;
pzz_interp=(pzz(1:end-1,:)+pzz(2:end,:))/2;
%% k
kx=simu_copylayer(kx);
kz=simu_copylayer(kz);
kx_interp=(kx(:,1:end-1)+kx(:,2:end))/2;
kz_interp=(kz(1:end-1,:)+kz(2:end,:))/2;
%% h
hx=simu_copylayer(hx);
hz=simu_copylayer(hz);
hx_interp=(hx(:,1:end-1)+hx(:,2:end))/2;
hz_interp=(hz(1:end-1,:)+hz(2:end,:))/2;
%% q
qx=simu_copylayer(qx);
qz=simu_copylayer(qz);
qx_interp=(qx(:,1:end-1)+qx(:,2:end))/2;
qz_interp=(qz(1:end-1,:)+qz(2:end,:))/2;

%%
sk_jE=qe.*ns.*(vx.*ex+vy.*ey+vz.*ez);
sk_dp=-(pxx_interp(2:ny+1,2:end)-pxx_interp(2:ny+1,1:end-1)+pxz_interpz(2:end,2:nx+1)-pxz_interpz(1:end-1,2:nx+1))/dr.*vx-...
       (pxy_interp(2:ny+1,2:end)-pxy_interp(2:ny+1,1:end-1)+pyz_interp(2:end,2:nx+1)-pyz_interp(1:end-1,2:nx+1))/dr.*vy-...
       (pxz_interpx(2:ny+1,2:end)-pxz_interpx(2:ny+1,1:end-1)+pzz_interp(2:end,2:nx+1)-pzz_interp(1:end-1,2:nx+1))/dr.*vz;
% su=-sk_dp;
dk=-(kx_interp(2:ny+1,2:end)-kx_interp(2:ny+1,1:end-1))/dr...
     -(kz_interp(2:end,2:nx+1)-kz_interp(1:end-1,2:nx+1))/dr;
dh=-(hx_interp(2:ny+1,2:end)-hx_interp(2:ny+1,1:end-1))/dr-...
    (hz_interp(2:end,2:nx+1)-hz_interp(1:end-1,2:nx+1))/dr;
dq=-(qx_interp(2:ny+1,2:end)-qx_interp(2:ny+1,1:end-1))/dr-...
    (qz_interp(2:end,2:nx+1)-qz_interp(1:end-1,2:nx+1))/dr;

%% integrate in a given area
ind=find(si(:,1)==tt(i));
xmin=si(ind,2);
xmax=si(ind,3);   %2-3 is X-line, 4-5&6-7 are DFs, 8-9 is secondary island.
if xmin<0&&xmax>Lx,
 continue;
end
ix1=floor(xmin/(Lx/nx))+1;
ix2=floor(xmax/(Lx/nx));
if ix1<1, ix1=1; end
if ix1>nx, ix1=nx; end
if ix2<1, ix2=1; end
if ix2>nx, ix2=nx; end
%%
if ix1<ix2, 
    xr=ix1:ix2;
else
    xr=[ix1:nx,1:ix2];
end
sk_jE1(i)=sum(sum(sk_jE(iy1:iy2,xr)))/norm1;
sk_dp1(i)=sum(sum(sk_dp(iy1:iy2,xr)))/norm1;
su1(i)=-sk_dp1(i);
dk1(i)=sum(sum(dk(iy1:iy2,xr)))/norm1;
dh1(i)=sum(sum(dh(iy1:iy2,xr)))/norm1;
dq1(i)=sum(sum(dq(iy1:iy2,xr)))/norm1;
uu1(i)=sum(sum(u(iy1:iy2,xr)))/norm1/dt;
kt1(i)=sum(sum(kt(iy1:iy2,xr)))/norm1/dt;
end

%%-----------------make field plot--------------------
figure
h=subplot(2,1,1);
plot(tt,sk_jE1,'k','linewidth',1.)
hold on
plot(tt,sk_dp1,'r','linewidth',1.);
plot(tt,dk1,'b','linewidth',1.);
plot(tt,kt1,'m--','linewidth',1.);
plot(tt,sk_jE1+sk_dp1+dk1,'g--','linewidth',1.);
plot([0 20000],[0 0],'k--','linewidth',0.5);
xlim([50 100])
xlabel('t\omega_{ci}','fontsize',16)
%%
h=subplot(2,1,2);
plot(tt,su1,'k','linewidth',1.)
hold on
plot(tt,dh1,'r','linewidth',1.);
plot(tt,dq1,'b','linewidth',1.);
plot(tt,uu1,'m--','linewidth',1.);
plot(tt,su1+dh1+dq1,'g--','linewidth',1.);
plot([0 20000],[0 0],'k--','linewidth',0.5);
xlim([50 100])
xlabel('t\omega_{ci}','fontsize',16)








