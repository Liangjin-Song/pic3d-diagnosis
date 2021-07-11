%% plot the parallel and perpendicular temperature
%%
tt=66;
nx=2400;
ny=1200;
Lx=120;
Ly=60;
imass=0.466671;
emass=imass/100;
qe=0.00035;
n0=857; %normalization for plasma density
%% pn=4; %% number of panels
%%
shift=0;
norm= 0.08660^2*emass;   %emass*vth^2
xrange=[26 42];
yrange=[-22 -8];
lineplot=0;
icut=[34,35,36];
% cr=[-0.6 0.6];
%%
dirr='I:\PIC simulation\DF\guide=0.0\';
 %dirr='I:\PIC simulation\island\island coalescence\mass=25\size_1024_1024\Bg=0.5detail2\';
% dirout='I:\DF\figures\';
cd(dirr)
%%
it=num2str(tt,'%06.2f');
it=[it(1:3),'_',it(5:6)];
tmp=load(['Bx_t',it,'.mat']); tmp=struct2cell(tmp); bx=tmp{1};
tmp=load(['By_t',it,'.mat']); tmp=struct2cell(tmp); by=tmp{1};
tmp=load(['Bz_t',it,'.mat']); tmp=struct2cell(tmp); bz=tmp{1};
tmp=load(['Ex_t',it,'.mat']); tmp=struct2cell(tmp); ex=tmp{1};
tmp=load(['Ey_t',it,'.mat']); tmp=struct2cell(tmp); ey=tmp{1};
tmp=load(['Ez_t',it,'.mat']); tmp=struct2cell(tmp); ez=tmp{1};
tmp=load(['vxe_t',it,'.mat']); tmp=struct2cell(tmp); vxe=tmp{1};
tmp=load(['vye_t',it,'.mat']); tmp=struct2cell(tmp); vye=tmp{1};
tmp=load(['vze_t',it,'.mat']); tmp=struct2cell(tmp); vze=tmp{1};
tmp=load(['prese_t',it,'.mat']); tmp=struct2cell(tmp); prese=tmp{1};
tmp=load(['Densi_t',it,'.mat']); tmp=struct2cell(tmp); ni=tmp{1};
tmp=load(['Dense_t',it,'.mat']); tmp=struct2cell(tmp); ne=tmp{1};
% tmp=load(['stream_t',it,'.mat']); tmp=struct2cell(tmp); ss=tmp{1};
tmp=load(['ohmx_t',it,'.mat']); tmp=struct2cell(tmp); ohmx=tmp{1};
tmp=load(['ohmy_t',it,'.mat']); tmp=struct2cell(tmp); ohmy=tmp{1};
tmp=load(['ohmz_t',it,'.mat']); tmp=struct2cell(tmp); ohmz=tmp{1};
%%
%% re-arrange the data
efxe=ohmx(:,1)-ohmx(:,3);
efxe=reshape(efxe,nx,ny);
efxe=efxe';
efye=ohmy(:,1)-ohmy(:,3);
efye=reshape(efye,nx,ny);
efye=efye';
efze=ohmz(:,1)-ohmz(:,3);
efze=reshape(efze,nx,ny);
efze=efze';
%% calculation
[jx,jy,jz]=simu_curlB(bx,by,bz,2,0.6);
rho=qe*(ni-ne);
%%
gamma=1;  %relativity factor
De=jx.*efxe-rho.*vxe.*ex+jy.*efye-rho.*vye.*ey+jz.*efze-rho.*vze.*ez;
De=gamma.*De;

%%
pfac=simu_pres_fac(prese,bx,by,bz);
ppara=pfac(:,6);
pperp=(pfac(:,1)+pfac(:,4))/2;
ppara=reshape(ppara,nx,ny);  ppara=ppara';
pperp=reshape(pperp,nx,ny);  pperp=pperp';
tpara=ppara./ne;
tperp=pperp./ne;
tpara=simu_shift(tpara,Lx,Ly,shift);
tperp=simu_shift(tperp,Lx,Ly,shift);
ani=tperp./tpara;
%%
epara=simu_Epara(bx,by,bz,ex,ey,ez);
epara=simu_shift(epara,Lx,Ly,shift);
%%
vpara=simu_Epara(bx,by,bz,vxe,vye,vze);
vpara=simu_shift(vpara,Lx,Ly,shift);
%%
plot_field(tpara,Lx,Ly,norm,1);
xlim(xrange); ylim(yrange)
plot_field(tperp,Lx,Ly,norm,1);
xlim(xrange); ylim(yrange)
plot_field(epara,Lx,Ly,0.03,1);
xlim(xrange); ylim(yrange)
plot_field(De,Lx,Ly,0.03*0.03*qe*857,1);
xlim(xrange); ylim(yrange)
plot_field(ani,Lx,Ly,1,1);
xlim(xrange); ylim(yrange)

%% make line plot
if lineplot==1, 
for i=1:length(icut)
  plot_line(tpara,Lx,Ly,icut(i),norm,1,'b',1);
  hold on
  plot_line(tperp,Lx,Ly,icut(i),norm,1,'r');
  plot_line(De,Lx,Ly,icut(i),0.03*0.03*qe*n0*0.2,1,'k');
% plot_line(ne,Lx,Ly,icut,57,0,'k');
  xlim(yrange)
end
end


