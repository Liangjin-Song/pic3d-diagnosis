
%% compare the energy source between different regions as a function of
%% time
%%
tt=20:100;
nx=2000;
ny=1000;
Lx=200;
Ly=100;
xmin=0;
xmax=200;
ymin=-40;
ymax=-10;
c=0.6;
trange=[20,100];
%%
norm=833*0.04^2*200*30;   %normalized by n0*va*E0=n0*va*b0*va
dt=1;     %1/wci.

%%
dirr='H:\island\island coalescence\mass=25\size_200_100\Bg=0.0\';
cd(dirr)
%%
iy1=floor((ymin+Ly/2)/(Ly/ny))+1;
iy2=floor((ymax+Ly/2)/(Ly/ny));
ix1=floor(xmin/(Lx/nx))+1;
ix2=floor(xmax/(Lx/nx));
dV=(iy2-iy1)*(Ly/ny)*(ix2-ix1)*(Lx/nx);  %the volume, di^3
%%
load xline30.mat
load mline30.mat
load si30.mat
%%
nt=length(tt);
JiE=zeros(nt,1);
JeE=zeros(nt,1);
JtotE=zeros(nt,1);
JiE_pi=zeros(nt,1);
JeE_pi=zeros(nt,1);
JtotE_pi=zeros(nt,1);
time_pi=zeros(nt,1);
%%
for i=1:nt
time_pi(i)=tt(i);
it=num2str(tt(i),'%06.2f');
it=[it(1:3),'_',it(5:6)];
tmp=load(['Ex_t',it,'.mat']); tmp=struct2cell(tmp); ex=tmp{1};
tmp=load(['Ey_t',it,'.mat']); tmp=struct2cell(tmp); ey=tmp{1};
tmp=load(['Ez_t',it,'.mat']); tmp=struct2cell(tmp); ez=tmp{1};
tmp=load(['flwxi_t',it,'.mat']); tmp=struct2cell(tmp); flwxi=tmp{1};
tmp=load(['flwyi_t',it,'.mat']); tmp=struct2cell(tmp); flwyi=tmp{1};
tmp=load(['flwzi_t',it,'.mat']); tmp=struct2cell(tmp); flwzi=tmp{1};
tmp=load(['flwxe_t',it,'.mat']); tmp=struct2cell(tmp); flwxe=tmp{1};
tmp=load(['flwye_t',it,'.mat']); tmp=struct2cell(tmp); flwye=tmp{1};
tmp=load(['flwze_t',it,'.mat']); tmp=struct2cell(tmp); flwze=tmp{1};

%% re-arrange the data
%% Ji dot E
var1=flwxi.*ex+flwyi.*ey+flwzi.*ez;
%% Je dot E
var2=-(flwxe.*ex+flwye.*ey+flwze.*ez);
%%
var=var1+var2;
%%
JiE(i)=sum(sum(var1(iy1:iy2,ix1:ix2)))/norm*dt*dV;
JeE(i)=sum(sum(var2(iy1:iy2,ix1:ix2)))/norm*dt*dV;
JtotE(i)=sum(sum(var(iy1:iy2,ix1:ix2)))/norm*dt*dV;
%%
ind=find(time_xline==tt(i));
if isempty(ind)==0, 
    tmp1=JtotE_xline(ind);
    tmp2=JiE_xline(ind);
    tmp3=JeE_xline(ind);
else
    tmp1=0;
    tmp2=0;
    tmp3=0;
end
JtotE_pi(i)=JtotE(i)-tmp1;
JiE_pi(i)=JiE(i)-tmp2;
JeE_pi(i)=JeE(i)-tmp3;
%%
ind=find(time_mline==tt(i));
if isempty(ind)==0, 
    tmp1=JtotE_mline(ind);
    tmp2=JiE_mline(ind);
    tmp3=JeE_mline(ind);
else
    tmp1=0;
    tmp2=0;
    tmp3=0;
end
JtotE_pi(i)=JtotE_pi(i)-tmp1;
JiE_pi(i)=JiE_pi(i)-tmp2;
JeE_pi(i)=JeE_pi(i)-tmp3;
%%
ind=find(time_si==tt(i));
if isempty(ind)==0, 
    tmp1=JtotE_si(ind);
    tmp2=JiE_si(ind);
    tmp3=JeE_si(ind);
else
    tmp1=0;
    tmp2=0;
    tmp3=0;
end
JtotE_pi(i)=JtotE_pi(i)-tmp1;
JiE_pi(i)=JiE_pi(i)-tmp2;
JeE_pi(i)=JeE_pi(i)-tmp3;

clear ex ey ez flwxi flwyi flwzi flwxe flwye flwze
end
%%  ----------------make plots---------------------------
h=subplot('position',[0.2,0.74,0.6,0.2]);
plot(time_pi,JtotE_pi,'k');
hold on
plot(time_pi,JiE_pi,'b');
plot(time_pi,JeE_pi,'r');
set(gca,'fontsize',13,'xticklabel','','xminortick','on')
ylabel('J\cdotE','fontsize',13)
xlim(trange)
plot([trange(1),trange(2)],[0,0],'k--')
%%
h=subplot('position',[0.2,0.52,0.6,0.2]);
plot(time_xline,JtotE_xline,'k');
hold on
plot(time_xline,JiE_xline,'b');
plot(time_xline,JeE_xline,'r');
set(gca,'fontsize',13,'xticklabel','','xminortick','on')
ylabel('J\cdotE','fontsize',13)
xlim(trange)
plot([trange(1),trange(2)],[0,0],'k--')
%%
h=subplot('position',[0.2,0.3,0.6,0.2]);
plot(time_mline,JtotE_mline,'k');
hold on
plot(time_mline,JiE_mline,'b');
plot(time_mline,JeE_mline,'r');
set(gca,'fontsize',13,'xticklabel','','xminortick','on')
ylabel('J\cdotE','fontsize',13)
xlim(trange)
plot([trange(1),trange(2)],[0,0],'k--')
%%
h=subplot('position',[0.2,0.08,0.6,0.2]);
plot(time_si,JtotE_si,'k');
hold on
plot(time_si,JiE_si,'b');
plot(time_si,JeE_si,'r');
set(gca,'fontsize',13,'xminortick','on')
xlabel('t\omega_{ci}','fontsize',13);
ylabel('J\cdotE','fontsize',13);
xlim(trange)
plot([trange(1),trange(2)],[0,0],'k--')





