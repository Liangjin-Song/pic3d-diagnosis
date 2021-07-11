%% decompose the convective electric field 
%%
clear

%%
tt=43;
nx=1280;
ny=1280;
Lx=102.4;
Ly=102.4;
norm=0.6*0.04;
cut=25.6;
xrange=[0 20];
yrange=[15 36.2];
drt=0;
%%
it=num2str(tt,'%06.2f');
it=[it(1:3),'_',it(5:6)];
load(['vxe_t',it,'.mat']);
eval(['vxe=vxe_t',it,';']);
load(['vye_t',it,'.mat']);
eval(['vye=vye_t',it,';']);
load(['vze_t',it,'.mat']);
eval(['vze=vze_t',it,';']);
load(['Bx_t',it,'.mat']);
eval(['bx=Bx_t',it,';']);
load(['By_t',it,'.mat']);
eval(['by=By_t',it,';']);
load(['Bz_t',it,'.mat']);
eval(['bz=Bz_t',it,';']);

%%
% f1=-vxe.*by;
% f2=vye.*bx;
f1=-vye.*bz;
f2=vze.*by;
%%--------------------make plots-----------------
% plot_line(f1,Lx,Ly,cut,norm,drt,'b',1);
% hold on
% plot_line(f2,Lx,Ly,cut,norm,drt,'r');
% xlim(xrange)
% plot(xrange,[0 0],'k--','linewidth',1.)
%%
%%
plot_field(by,Lx,Ly,0.6);
xlim(xrange)
ylim(yrange)
hold on
[xx,yy]=ginput(2);
r0=[xx(1),yy(1)];
r1=[xx(2),yy(2)];  % select the trajectory by hand
%  r0=[39.1,29.4];
%  r1=[46.0,22.1];
plot([r0(1),r1(1)],[r0(2),r1(2)],'k--','linewidth',1.5)
%
plot_line2(f1,Lx,Ly,r0,r1,norm,'b',1);
hold on
plot_line2(f2,Lx,Ly,r0,r1,norm,'r');
vv=axis;
plot([vv(1),vv(2)],[0,0],'k--')







