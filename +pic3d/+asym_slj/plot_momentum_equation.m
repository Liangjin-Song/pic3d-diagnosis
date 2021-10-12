% function plot_momentum_equation
% clear;
%% parameters
indir='E:\Asym\asym_cold_Nr1\data';
outdir='E:\Asym\asym_cold_Nr1\out\Global';
prm=slj.Parameters(indir,outdir);

tt=100;
dt=1;
name='e';

q=prm.value.qe;
m=prm.value.me;

norm=prm.value.vA;
xz=50;
dir=1;
pxz=prm.value.nz/2;
dxz=100;

%% figure proterty
xrange=[-10,10];

%% momentum equation
E=prm.read('E',tt);
[vxB, divP, nvv, nvt] = slj.Physics.momentum_equation(prm, name, tt, dt, q, m);

%% filter
n=3;
E=E.filter2d(n);
vxB=vxB.filter2d(n);
divP=divP.filter2d(n);
nvv=nvv.filter2d(n);
nvt=nvt.filter2d(n);


%% get the line
eee=E.get_line2d(xz, dir, prm, norm);
vxb=vxB.get_line2d(xz, dir, prm, norm);
dvp=divP.get_line2d(xz, dir, prm, norm);
vpv=nvv.get_line2d(xz, dir, prm, norm);
vpt=nvt.get_line2d(xz, dir, prm, norm);

eee=eee.ly;
vxb=vxb.ly;
dvp=dvp.ly;
vpv=vpv.ly;
vpt=vpt.ly;

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

tot=vxb+dvp+vpv+vpt;

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
ylabel('Ey');
set(gca,'FontSize',14);
cd(outdir);
print('-dpng','-r300',['Ey_cold_ion_t',num2str(tt),'_x',num2str(xz),'.png']);