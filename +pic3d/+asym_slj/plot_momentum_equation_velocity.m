% function plot_momentum_equation_velocity
clear;
%% parameters
indir='E:\Asym\cold2\data';
outdir='E:\Asym\cold2\out\Tmp';
prm=slj.Parameters(indir,outdir);

tt=34;
dt=0.1;
name='h';

q=prm.value.qi;
m=prm.value.mi;

norm=prm.value.vA;
xz=40;
dir=1;

%% figure proterty
xrange=[-5,5];

%% momentum equation
[vdv, divP, evb] = slj.Physics.momentum_equation_velocity(prm, name, tt, q, m);
Vn=prm.read(['V',name],tt+dt);
Vp=prm.read(['V',name],tt-dt);
pt=prm.value.wci/(2*dt);
dvt.x=(Vn.x-Vp.x)*pt;
dvt.y=(Vn.y-Vp.y)*pt;
dvt.z=(Vn.z-Vp.z)*pt;
dvt=slj.Vector(dvt);

%% filter
% n=3;
% E=E.filter2d(n);
% vxB=vxB.filter2d(n);
% divP=divP.filter2d(n);
% nvv=nvv.filter2d(n);
% nvt=nvt.filter2d(n);


%% get the line
dpt=dvt.get_line2d(xz, dir, prm, norm);
vgv=vdv.get_line2d(xz, dir, prm, norm);
dvp=divP.get_line2d(xz, dir, prm, norm);
vcb=evb.get_line2d(xz, dir, prm, norm);

dpt=dpt.ly;
vgv=vgv.ly;
dvp=dvp.ly;
vcb=vcb.ly;

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
dpt0=dpt;
vgv0=vgv;
dvp0=dvp;
vcb0=vcb;

dpt=smoothdata(dpt0,'movmean',40);
vgv=smoothdata(vgv0,'movmean',40);
dvp=smoothdata(dvp0,'movmean',40);
vcb=smoothdata(vcb0,'movmean',40);

tot=vgv+dvp+vcb;
% tot=smoothdata(tot);
%% figure
ll=prm.value.lz;
figure;
plot(ll,dpt,'-k','LineWidth',2); hold on
plot(ll,tot,'--k','LineWidth',2);
plot(ll,vgv,'-r','LineWidth',2);
plot(ll,dvp,'-g','LineWidth',2);
plot(ll,vcb,'-b','LineWidth',2);
xlim(xrange);
legend('\partial V/\partial t','Sum','-V\cdot\nabla V',' -\nabla \cdot P/mn','q/m (E + V \times B)',...
    'Location','Best','Box','off');
xlabel('X [c/\omega_{pi}]');
ylabel('\partial Vicy/\partial t');
title(['\Omega_{ci}t=',num2str(tt), ', profiles x = ',num2str(xz)]);
set(gca,'FontSize',16);
cd(outdir);
% print('-dpng','-r300',['Vz_cold_ion_t',num2str(tt),'_x',num2str(xz),'_momentum.png']);
