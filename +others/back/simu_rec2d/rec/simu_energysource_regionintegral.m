
clear all

%% calculate the integrated energy dissipation in a given region as 
%% a function of time
nx=2000;
ny=1000;
Lx=200;
Ly=100;
xmin=0;
xmax=200;
ymin=-30;
ymax=-20;
c=0.6;
%%
norm=833*0.04^2*200*30;   %normalized by n0*va*E0=n0*va*b0*va
dt=1;     %1/wci.
%%
dirr='H:\island\island coalescence\mass=25\size_200_100\Bg=0.0\';
cd(dirr)
%%
iy1=floor((ymin+Ly/2)/(Ly/ny))+1;
iy2=floor((ymax+Ly/2)/(Ly/ny));

%%
load si.mat  %pi(primary island),si(secondary island),mi(merged island),mline(merging line)
dat=si;
%%
nt=length(dat);
JiE=zeros(nt,1);
JeE=zeros(nt,1);
JtotE=zeros(nt,1);
time=zeros(nt,1);
for i=1:nt
if length(dat{i})==1, 
    time(i)=dat{i}(1);
    continue; 
end
%%
tt=dat{i}(1);
time(i)=tt;
it=num2str(tt,'%06.2f');
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
xpos=dat{i}(2:end);
np=length(xpos);
dvv=0;
for jj=1:np/2
xmin=xpos((jj-1)*2+1);
xmax=xpos((jj-1)*2+2);
ix1=floor(xmin/(Lx/nx))+1; 
if ix1<1, ix1=1; end
ix2=floor(xmax/(Lx/nx));
if ix2>nx,ix2=nx; end
dV=(iy2-iy1)*(ix2-ix1)*Lx/nx*Ly/ny;
JiE(i)=JiE(i)+sum(sum(var1(iy1:iy2,ix1:ix2)))/norm*dt*dV;
JeE(i)=JeE(i)+sum(sum(var2(iy1:iy2,ix1:ix2)))/norm*dt*dV;
JtotE(i)=JtotE(i)+sum(sum(var(iy1:iy2,ix1:ix2)))/norm*dt*dV;
end

clear ex ey ez flwxi flwyi flwzi flwxe flwye flwze
%%
end




