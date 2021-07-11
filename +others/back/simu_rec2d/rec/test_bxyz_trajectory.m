%% plot the Bx, By and Bz along a trajectory across the magnetic island.
clear all
%%

tt=48;
Lx=102.4;
Ly=102.4;
it=num2str(tt,'%06.2f');
it=[it(1:3),'_',it(5:6)];
xrange=[5,45];
yrange=[15,36.2];
norm=0.6;
%%
tmp=load(['Bx_t',it,'.mat']); tmp=struct2cell(tmp); bx=tmp{1};
tmp=load(['By_t',it,'.mat']); tmp=struct2cell(tmp); by=tmp{1};
tmp=load(['Bz_t',it,'.mat']); tmp=struct2cell(tmp); bz=tmp{1};
tmp=load(['stream_t',it,'.mat']); tmp=struct2cell(tmp); ss=tmp{1};
%%
plot_field(by,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,60);
caxis(cr);
xlim(xrange)
ylim(yrange)
%%
%% -----------line plot along the trajectory-------------
[xx,yy]=ginput(2);
r0=[xx(1),yy(1)];
r1=[xx(2),yy(2)];  % select the trajectory by hand
plot([r0(1),r1(1)],[r0(2),r1(2)],'k--','linewidth',1.5)
%
plot_line2(bx,Lx,Ly,r0,r1,norm,'k',1);
hold on
plot_line2(by,Lx,Ly,r0,r1,norm,'r');
plot_line2(bz,Lx,Ly,r0,r1,norm,'b');
vv=axis;
plot([vv(1),vv(2)],[0,0],'k--')


