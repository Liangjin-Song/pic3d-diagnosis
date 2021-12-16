% function plot_momentum_equation
clear;
%% parameters
indir='E:\Asym\cb3\data';
outdir='E:\Asym\cb3\out';
prm=slj.Parameters(indir,outdir);

tt=39;
dt=1;
name='l';

q=prm.value.qi;
m=prm.value.mi;

norm=prm.value.vA;
xz=30;
dir=1;
pxz=prm.value.nz/2;
dxz=100;

%% figure proterty
xrange=[-15,15];

%% momentum equation
E=prm.read('E',tt);
[vxB, divP, nvv, nvt] = slj.Physics.momentum_equation(prm, name, tt, dt, q, m);

%% filter
% n=3;
% E=E.filter2d(n);
% vxB=vxB.filter2d(n);
% divP=divP.filter2d(n);
% nvv=nvv.filter2d(n);
% nvt=nvt.filter2d(n);


%% get the line
eee=E.get_line2d(xz, dir, prm, norm);
vxb=vxB.get_line2d(xz, dir, prm, norm);
dvp=divP.get_line2d(xz, dir, prm, norm);
vpv=nvv.get_line2d(xz, dir, prm, norm);
vpt=nvt.get_line2d(xz, dir, prm, norm);

eee=eee.lz;
vxb=vxb.lz;
dvp=dvp.lz;
vpv=vpv.lz;
vpt=vpt.lz;

% eee=E.z(:,pxz-dxz:pxz+dxz);
% vxb=vxB.z(:,pxz-dxz:pxz+dxz);
% dvp=divP.z(:,pxz-dxz:pxz+dxz);
% vpv=nvv.z(:,pxz-dxz:pxz+dxz);
% vpt=nvt.z(:,pxz-dxz:pxz+dxz);
% eee=sum(eee,2);
% vxb=sum(vxb,2);
% dvp=sum(dvp,2);
% vpv=sum(vpv,2);
% vpt=sum(vpt,2);

%% smooth data
eee0=eee;
vxb0=vxb;
dvp0=dvp;
vpv0=vpv;
vpt0=vpt;

eee=smoothdata(eee0,'movmean',20);
vxb=smoothdata(vxb0,'movmean',20);
dvp=smoothdata(dvp0,'movmean',20);
vpv=smoothdata(vpv0,'movmean',20);
vpt=smoothdata(vpt0,'movmean',20);

% vxb=smoothdata(vxb0,'movmean');
% vxb=smoothdata(vxb,'movmean');
% dvp=smoothdata(dvp0,'movmean');
% vpv=smoothdata(vpv0,'movmean');
% vpt=smoothdata(vpt0,'movmean');


tot=vxb+dvp+vpv+vpt;
% tot=smoothdata(tot);
%% figure
ll=prm.value.lz;
figure;
plot(ll,eee,'-k','LineWidth',2); hold on
plot(ll,tot,'--k','LineWidth',2);
plot(ll,vxb,'-r','LineWidth',2);
plot(ll,dvp,'-g','LineWidth',2);
plot(ll,vpv,'-b','LineWidth',2);
plot(ll,vpt,'-m','LineWidth',2); hold off
xlim(xrange);
legend('E','Sum','-V\times B','\nabla \cdot P/qn','m/qn\nabla\cdot(nVV)','m/qn \partial nV/\partial t','Location','Best')
xlabel('Z [c/\omega_{pi}]');
ylabel('Ez');
title(['\Omega_{ci}t=',num2str(tt)]);
set(gca,'FontSize',12);
cd(outdir);
% print('-dpng','-r300',['Ey_cold_ion_t',num2str(tt),'_x',num2str(xz),'.png']);