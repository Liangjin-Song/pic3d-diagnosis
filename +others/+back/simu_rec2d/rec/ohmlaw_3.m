%% get the component of the generalized ohm's law
%%
clear

%%
tt=42;
nx=1280;
ny=1280;
Lx=102.4;
Ly=102.4;
c=0.6;
q=0.000418;
norm=1*0.04;
norm2=836;
norm3=0.6;
norm4=658*0.03;
xrange=[2 18];
yrange=[23 28.2];
%%
it=num2str(tt,'%3.3d');
load(['ohmy_t',it,'_00.mat']);
eval(['ohm=ohmy_t',it,'_00;']);
load(['By_t',it,'_00.mat']);
eval(['by=By_t',it,'_00;']);

%%
ef=ohm(:,1);
evbi=ohm(:,2);
evbe=ohm(:,3);
dp=ohm(:,4);
dvv=ohm(:,5);
dvt=ohm(:,6);
%%
ef=reshape(ef,nx,ny);
ef=ef';
evbi=reshape(evbi,nx,ny);
evbi=evbi';
evbe=reshape(evbe,nx,ny);
evbe=evbe';
dvv=reshape(dvv,nx,ny);
dvv=dvv';
dp=reshape(dp,nx,ny);
dp=dp';
dvt=reshape(dvt,nx,ny);
dvt=dvt';
%%
aa=ef-evbi;
bb=ef-evbe;
cc=evbe+dp+dvv+dvt;
jxb=-evbi+evbe;
ef=simu_filter2d(ef);
aa=simu_filter2d(aa);
bb=simu_filter2d(bb);
cc=simu_filter2d(cc);
jxb=simu_filter2d(jxb);
dvv=simu_filter2d(dvv);
dvt=simu_filter2d(dvt);
dp=simu_filter2d(dp);
dvv=dvv+dvt;
%%
plot_field(bb,Lx,Ly,0.6*0.04);
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
plot_line2(ef,Lx,Ly,r0,r1,norm,'k',1);
hold on
plot_line2(evbe,Lx,Ly,r0,r1,norm,'b');
plot_line2(dvv,Lx,Ly,r0,r1,norm,'y');
plot_line2(dp,Lx,Ly,r0,r1,norm,'g');
% plot_line2(dvt,Lx,Ly,r0,r1,norm,'c');
plot_line2(cc,Lx,Ly,r0,r1,norm,'m');
% plot_line2(by,Lx,Ly,r0,r1,0.6,'r--');
vv=axis;
plot([vv(1),vv(2)],[0,0],'k--')
%%







