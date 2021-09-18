
clear all

%% compare the energy partition between different structures as a
%% function of time
%%
tt=20:100;
nx=2000;
ny=1000;
Lx=200;
Ly=100;
c=0.6;
imass=0.245457;
emass=imass/25;
%%
norm=0.5*imass*0.04^2;   %0.5*mi*Va^2
ymax=-20;
ymin=-30;
trange=[20 100];
%%
dirr='H:\island\island coalescence\mass=25\size_200_100\Bg=0.0\';
dirout='H:\island\island coalescence\mass=25\size_200_100\Bg=0.0\figures\';
cd(dirr)
%%
iy1=floor((ymin+Ly/2)/(Ly/ny))+1;
iy2=floor((ymax+Ly/2)/(Ly/ny));
%%
load xline.mat
load mline.mat
load si.mat
nt=length(tt);
wi_xline=zeros(nt,2);
we_xline=zeros(nt,2);
wi_mline=zeros(nt,2);
we_mline=zeros(nt,2);
wi_si=zeros(nt,2);
we_si=zeros(nt,2);
wi_pi=zeros(nt,2);
we_pi=zeros(nt,2);
for i=1:nt
it=num2str(tt(i),'%06.2f');
it=[it(1:3),'_',it(5:6)];
tmp=load(['vxi_t',it,'.mat']); tmp=struct2cell(tmp); vxi=tmp{1};
tmp=load(['vyi_t',it,'.mat']); tmp=struct2cell(tmp); vyi=tmp{1};
tmp=load(['vzi_t',it,'.mat']); tmp=struct2cell(tmp); vzi=tmp{1};
tmp=load(['vxe_t',it,'.mat']); tmp=struct2cell(tmp); vxe=tmp{1};
tmp=load(['vye_t',it,'.mat']); tmp=struct2cell(tmp); vye=tmp{1};
tmp=load(['vze_t',it,'.mat']); tmp=struct2cell(tmp); vze=tmp{1};
tmp=load(['presi_t',it,'.mat']); tmp=struct2cell(tmp); presi=tmp{1};
tmp=load(['prese_t',it,'.mat']); tmp=struct2cell(tmp); prese=tmp{1};
tmp=load(['Densi_t',it,'.mat']); tmp=struct2cell(tmp); ni=tmp{1};
tmp=load(['Dense_t',it,'.mat']); tmp=struct2cell(tmp); ne=tmp{1};

%% re-arrange data
pxxi=presi(:,1);  pxxi=reshape(pxxi,nx,ny); pxxi=pxxi';
pxyi=presi(:,2);  pxyi=reshape(pxyi,nx,ny); pxyi=pxyi';
pxzi=presi(:,3);  pxzi=reshape(pxzi,nx,ny); pxzi=pxzi';
pyyi=presi(:,4);  pyyi=reshape(pyyi,nx,ny); pyyi=pyyi';
pyzi=presi(:,5);  pyzi=reshape(pyzi,nx,ny); pyzi=pyzi';
pzzi=presi(:,6);  pzzi=reshape(pzzi,nx,ny); pzzi=pzzi';
pxxe=prese(:,1);  pxxe=reshape(pxxe,nx,ny); pxxe=pxxe';
pxye=prese(:,2);  pxye=reshape(pxye,nx,ny); pxye=pxye';
pxze=prese(:,3);  pxze=reshape(pxze,nx,ny); pxze=pxze';
pyye=prese(:,4);  pyye=reshape(pyye,nx,ny); pyye=pyye';
pyze=prese(:,5);  pyze=reshape(pyze,nx,ny); pyze=pyze';
pzze=prese(:,6);  pzze=reshape(pzze,nx,ny); pzze=pzze';
%%
%% thermal energy of particles
ui=(pxxi+pyyi+pzzi)/2.;  %thermal energy of ions
ue=(pxxe+pyye+pzze)/2.;
%% kinetic energy
kti=0.5*imass.*ni.*(vxi.^2+vyi.^2+vzi.^2);
kte=0.5*emass.*ne.*(vxe.^2+vye.^2+vze.^2);
%%
%%--------------xline------------------
ind=find(time_xline==tt(i));
nitot1=0;
netot1=0;
if isempty(ind)==0&length(xline{ind})>1,
   xpos=xline{ind}(2:end);
   np=length(xpos);
   for jj=1:np/2
   xmin=xpos((jj-1)*2+1);
   xmax=xpos((jj-1)*2+2);
   ix1=floor(xmin/(Lx/nx))+1; 
   if ix1<1, ix1=1; end
   ix2=floor(xmax/(Lx/nx));
   if ix2>nx,ix2=nx; end
   nitot1=nitot1+sum(sum(ni(iy1:iy2,ix1:ix2)));
   netot1=netot1+sum(sum(ne(iy1:iy2,ix1:ix2)));
   wi_xline(i,1)=wi_xline(i,1)+sum(sum(kti(iy1:iy2,ix1:ix2)))/norm;
   wi_xline(i,2)=wi_xline(i,2)+sum(sum(ui(iy1:iy2,ix1:ix2)))/norm;
   we_xline(i,1)=we_xline(i,1)+sum(sum(kte(iy1:iy2,ix1:ix2)))/norm;
   we_xline(i,2)=we_xline(i,2)+sum(sum(ue(iy1:iy2,ix1:ix2)))/norm;   
   end
end
%%-------------merging line------------------
ind=find(time_mline==tt(i));
nitot2=0;
netot2=0;
if isempty(ind)==0&length(mline{ind})>1,
   xpos=mline{ind}(2:end);
   np=length(xpos);
   for jj=1:np/2
   xmin=xpos((jj-1)*2+1);
   xmax=xpos((jj-1)*2+2);
   ix1=floor(xmin/(Lx/nx))+1; 
   if ix1<1, ix1=1; end
   ix2=floor(xmax/(Lx/nx));
   if ix2>nx,ix2=nx; end
   nitot2=nitot2+sum(sum(ni(iy1:iy2,ix1:ix2)));
   netot2=netot2+sum(sum(ne(iy1:iy2,ix1:ix2)));
   wi_mline(i,1)=wi_mline(i,1)+sum(sum(kti(iy1:iy2,ix1:ix2)))/norm;
   wi_mline(i,2)=wi_mline(i,2)+sum(sum(ui(iy1:iy2,ix1:ix2)))/norm;
   we_mline(i,1)=we_mline(i,1)+sum(sum(kte(iy1:iy2,ix1:ix2)))/norm;
   we_mline(i,2)=we_mline(i,2)+sum(sum(ue(iy1:iy2,ix1:ix2)))/norm;
   end
end
%%--------------secondary island------------------
ind=find(time_si==tt(i));
nitot3=0;
netot3=0;
if isempty(ind)==0&length(si{ind})>1,
   xpos=si{ind}(2:end);
   np=length(xpos);
   for jj=1:np/2
   xmin=xpos((jj-1)*2+1);
   xmax=xpos((jj-1)*2+2);
   ix1=floor(xmin/(Lx/nx))+1; 
   if ix1<1, ix1=1; end
   ix2=floor(xmax/(Lx/nx));
   if ix2>nx,ix2=nx; end
   nitot3=nitot3+sum(sum(ni(iy1:iy2,ix1:ix2)));
   netot3=netot3+sum(sum(ne(iy1:iy2,ix1:ix2)));
   wi_si(i,1)=wi_si(i,1)+sum(sum(kti(iy1:iy2,ix1:ix2)))/norm;
   wi_si(i,2)=wi_si(i,2)+sum(sum(ui(iy1:iy2,ix1:ix2)))/norm;
   we_si(i,1)=we_si(i,1)+sum(sum(kte(iy1:iy2,ix1:ix2)))/norm;
   we_si(i,2)=we_si(i,2)+sum(sum(ue(iy1:iy2,ix1:ix2)))/norm;  
   end
end
%%--------------primary island------------------
   wi_pi(i,1)=sum(sum(kti(1:ny/2,1:nx)))/norm-wi_xline(i,1)-wi_mline(i,1)-wi_si(i,1);
   wi_pi(i,2)=sum(sum(ui(1:ny/2,1:nx)))/norm-wi_xline(i,2)-wi_mline(i,2)-wi_si(i,2);
   we_pi(i,1)=sum(sum(kte(1:ny/2,1:nx)))/norm-we_xline(i,1)-we_mline(i,1)-we_si(i,1);
   we_pi(i,2)=sum(sum(ue(1:ny/2,1:nx)))/norm-we_xline(i,2)-we_mline(i,2)-we_si(i,2);
   nitot4=sum(sum(ni(1:ny/2,1:nx)))-nitot1-nitot2-nitot3;
   netot4=sum(sum(ne(1:ny/2,1:nx)))-netot1-netot2-netot3;
   
%% ------------calculate the average energy----------------
   wi_xline(i,:)=wi_xline(i,:)./nitot1;  %average ion energy
   we_xline(i,:)=we_xline(i,:)./netot1;  %average electron energy
   wi_mline(i,:)=wi_mline(i,:)./nitot2;  %average ion energy
   we_mline(i,:)=we_mline(i,:)./netot2;  %average electron energy
   wi_si(i,:)=wi_si(i,:)./nitot3;  %average ion energy
   we_si(i,:)=we_si(i,:)./netot3;  %average electron energy
   wi_pi(i,:)=wi_pi(i,:)./nitot4;  %average ion energy
   we_pi(i,:)=we_pi(i,:)./netot4;  %average electron energy   
end
%% ---------------make plots---------------------
%% ions first
h=subplot('position',[0.2,0.74,0.6,0.2]);
plot(tt,wi_pi(:,1),'k');
hold on
plot(tt,wi_pi(:,2),'k--');
set(gca,'fontsize',13,'xticklabel','','xminortick','on','yminortick','on')
ylabel('2W/m_{i}V_{A}^{2} @ PI','fontsize',13)
xlim(trange)
plot([trange(1),trange(2)],[0,0],'k--')
%%
h=subplot('position',[0.2,0.52,0.6,0.2]);
plot(tt,wi_xline(:,1),'k');
hold on
plot(tt,wi_xline(:,2),'k--');
set(gca,'fontsize',13,'xticklabel','','xminortick','on','yminortick','on')
ylabel('2W/m_{i}V_{A}^{2} @ X-line','fontsize',13)
xlim(trange)
plot([trange(1),trange(2)],[0,0],'k--')
%%
h=subplot('position',[0.2,0.3,0.6,0.2]);
plot(tt,wi_mline(:,1),'k');
hold on
plot(tt,wi_mline(:,2),'k--');
set(gca,'fontsize',13,'xticklabel','','xminortick','on','yminortick','on')
ylabel('2W/m_{i}V_{A}^{2} @ M-line','fontsize',13)
xlim(trange)
plot([trange(1),trange(2)],[0,0],'k--')
%%
h=subplot('position',[0.2,0.08,0.6,0.2]);
plot(tt,wi_si(:,1),'k');
hold on
plot(tt,wi_si(:,2),'k--');
set(gca,'fontsize',13,'xminortick','on','yminortick','on')
xlabel('t\omega_{ci}','fontsize',13);
ylabel('2W/m_{i}V_{A}^{2} @ SI','fontsize',13)
xlim(trange)
plot([trange(1),trange(2)],[0,0],'k--')
%%--------------------------------------------------
%% then electrons
figure
h=subplot('position',[0.2,0.74,0.6,0.2]);
plot(tt,we_pi(:,1),'k');
hold on
plot(tt,we_pi(:,2),'k--');
set(gca,'fontsize',13,'xticklabel','','xminortick','on','yminortick','on')
ylabel('2W/m_{i}V_{A}^{2} @ PI','fontsize',13)
xlim(trange)
plot([trange(1),trange(2)],[0,0],'k--')
%%
h=subplot('position',[0.2,0.52,0.6,0.2]);
plot(tt,we_xline(:,1),'k');
hold on
plot(tt,we_xline(:,2),'k--');
set(gca,'fontsize',13,'xticklabel','','xminortick','on','yminortick','on')
ylabel('2W/m_{i}V_{A}^{2} @ X-line','fontsize',13)
xlim(trange)
plot([trange(1),trange(2)],[0,0],'k--')
%%
h=subplot('position',[0.2,0.3,0.6,0.2]);
plot(tt,we_mline(:,1),'k');
hold on
plot(tt,we_mline(:,2),'k--');
set(gca,'fontsize',13,'xticklabel','','xminortick','on','yminortick','on')
ylabel('2W/m_{i}V_{A}^{2} @ M-line','fontsize',13)
xlim(trange)
plot([trange(1),trange(2)],[0,0],'k--')
%%
h=subplot('position',[0.2,0.08,0.6,0.2]);
plot(tt,we_si(:,1),'k');
hold on
plot(tt,we_si(:,2),'k--');
set(gca,'fontsize',13,'xminortick','on','yminortick','on')
xlabel('t\omega_{ci}','fontsize',13);
ylabel('2W/m_{i}V_{A}^{2} @ SI','fontsize',13)
xlim(trange)
plot([trange(1),trange(2)],[0,0],'k--')




