%% to determine the time when the reverse reconnection starts!
%%
%%
clear
cd('I:\PIC simulation\island\island coalescence\mass=25\size_1024_1024\Bg=0.5detail2\')
%%
tt=32:0.5:50;
nx=1280;
ny=1280;
Lx=102.4;
Ly=102.4;
norm=0.04;
cut=25.6;
xrange=[26 52];
dx=Lx/nx;
dy=Ly/ny;
%%
nt=length(tt);
xpos=zeros(nt,1);
emr=zeros(nt,2);
for i=1:nt
it=num2str(tt(i),'%06.2f');
it=[it(1:3),'_',it(5:6)];
load(['ohmy_t',it,'.mat']);
eval(['ohm=ohmy_t',it,';']);
load(['Bz_t',it,'.mat']);
eval(['bz=Bz_t',it,';']);
% load(['Ey_t',it,'.mat']);
% eval(['ey=Ey_t',it,';']);
%%
bz=simu_shift(bz,Lx,Ly,30);
%%
ef=ohm(:,1);
evbe=ohm(:,3);
ef=reshape(ef,nx,ny);
ef=ef';
evbe=reshape(evbe,nx,ny);
evbe=evbe';
aa=ef-evbe;
%%
ef=simu_shift(ef,Lx,Ly,30);
aa=simu_shift(aa,Lx,Ly,30);
%%
fbz=plot_line(bz,Lx,Ly,cut,0.6,0,'k',1);
xlim(xrange)
hold on
plot([xrange(1),xrange(2)],[0,0],'k--')
%%
%% determine the position of X-line or M-line half-automatically
%% or automatically
% [xx,yy]=ginput(2);
% xpos(i)=xx;
% close(gcf)
[xx,yy]=ginput(2);
ix1=floor(xx(1)/dx);
ix2=floor(xx(2)/dx);
fbz=fbz(ix1:ix2);
indx=find(fbz(1:end-1).*fbz(2:end)<0); 
indx=indx(1)+ix1-1;
xpos(i)=indx;
ix=indx-2:indx+2;
iy=3*ny/4-2:3*ny/4+2;
%%
emr(i,1)=mean(mean(aa(iy,ix),1))/norm;
emr(i,2)=mean(mean(ef(iy,ix),1))/norm;
%%
clear Bz* ohm* Ey*
close(gcf)
end
%%
%%
emr=-emr;
plot(tt,emr(:,1),'k','linewidth',1);
hold on
% plot(tt,emr(:,1),'bs','markersize',10)
plot(tt,emr(:,2),'r','linewidth',1);
set(gca,'fontsize',15)
xlabel('t\omega_{ci}','fontsize',16)
ylabel('Ey_{Mline}','fontsize',16)





