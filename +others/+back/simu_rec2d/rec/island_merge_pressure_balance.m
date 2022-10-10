%%check the pressure balance in reconnection region
clear all
%% parameters
c=0.6;

%% input the parameters
Lx=102.4;
Ly=102.4;
nx=1280;
ny=1280;
xrange=[15,25];
yrange=[23,28.2];
shift=30;
cr=[0,0.5];
%%
tt=46;  % time points
fline=1; % set 1 to plot stream superposed
dirr='H:\island\island coalescence\mass=25\size_1024_1024\Bg=0.5detail2\';
outdir='H:\island\island coalescence\mass=25\size_1024_1024\Bg=0.5detail2\figures\';
cd(dirr)
%%=====================the loop===========================
nt=length(tt);
%%
for i=1:nt
it=num2str(tt(i),'%06.2f');
it=[it(1:3),'_',it(5:6)];
%%--------------------load data-------------------------- 
if fline==1, 
load(['stream_t',it,'.mat']);
eval(['ss=stream_t',it,';']);
end
%%
load(['Bx_t',it,'.mat']);
eval(['bx=Bx_t',it,';'])
load(['By_t',it,'.mat']);
eval(['by=By_t',it,';'])
load(['Bz_t',it,'.mat']);
eval(['bz=Bz_t',it,';'])
%%
load(['presi_t',it,'.mat']);
eval(['presi=presi_t',it,';'])
load(['prese_t',it,'.mat']);
eval(['prese=prese_t',it,';'])
%%
%%
Pb=(bx.^2+by.^2+bz.^2)/2;
Pi=(presi(:,1)+presi(:,4)+presi(:,6))/3;
Pe=(prese(:,1)+prese(:,4)+prese(:,6))/3;
Pi=reshape(Pi,nx,ny);
Pi=Pi';
Pe=reshape(Pe,nx,ny);
Pe=Pe';

%%
Pb=simu_shift(Pb,Lx,Ly,shift);
Pi=simu_shift(Pi,Lx,Ly,shift);
Pe=simu_shift(Pe,Lx,Ly,shift);
ss=simu_shift(ss,Lx,Ly,shift);
Pt=Pb+Pi+Pe;
beta=Pe./Pb;
%%----------make plots and output figures----------------------
figure
h1=subplot('position',[0.2,0.7,0.6,0.28]);
plot_field(Pt,Lx,Ly,1);
% cr=caxis;
hold on
plot_stream(ss,Lx,Ly,80);
xlim(xrange)
ylim(yrange)
caxis(cr)
xlabel('');
set(h1,'xticklabel',{''})
%%
h2=subplot('position',[0.2,0.4,0.6,0.28]);
plot_field(Pb,Lx,Ly,1);
hold on
plot_stream(ss,Lx,Ly,80);
xlim(xrange)
ylim(yrange)
caxis(cr)
xlabel('');
set(h2,'xticklabel',{''})
%%
h3=subplot('position',[0.2,0.1,0.6,0.28]);
plot_field(Pi+Pe,Lx,Ly,1);
hold on
plot_stream(ss,Lx,Ly,80);
xlim(xrange)
ylim(yrange)
caxis(cr)
%%
% plot_field(Pt,Lx,Ly,1);
% color_range=caxis;
% hold on
% 
% if fline==1,
% plot_stream(ss,Lx,Ly,60);
% caxis(color_range);
% end
% xlim(xrange)
% ylim(yrange)
% print('-r300','-dpng',[outdir,var,'_t',it,'_zoomin.png']);
% close(gcf)
%%
% clear Bx* By* Bz* Ex* Ey* Ez* Dens* stream* vx* vy* vz* eleaven* flw* presi* prese*
end

%%










