%% function plot_Ohm_law
% written by Liangjin Song on 20220330 at Nanchang University
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Line\DF';
prm=slj.Parameters(indir,outdir);

tt=30;
dt=1;

norm=prm.value.vA;
xz=50;
dir=1;


%% figure proterty
% xrange=[0,prm.value.Lx];
xrange=[-10,10];

%% momentum equation
E=prm.read('E',tt);
[JxB, divP, VlxB, VhxB, dJ] = calc_Ohm_law_with_cold_ions(prm, tt, dt);

%% filter
% n=3;
% E=E.filter2d(n);
% vxB=vxB.filter2d(n);
% divP=divP.filter2d(n);
% nvv=nvv.filter2d(n);
% nvt=nvt.filter2d(n);


%% get the line
eee=E.get_line2d(xz, dir, prm, norm);
jxb=JxB.get_line2d(xz, dir, prm, norm);
dvp=divP.get_line2d(xz, dir, prm, norm);
vlxb=VlxB.get_line2d(xz, dir, prm, norm);
vhxb=VhxB.get_line2d(xz, dir, prm, norm);
dj=dJ.get_line2d(xz, dir, prm, norm);

eee=eee.lz;
jxb=jxb.lz;
dvp=dvp.lz;
vlxb=vlxb.lz;
vhxb=vhxb.lz;
dj=dj.lz;

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
jxb0=jxb;
dvp0=dvp;
vlxb0=vlxb;
vhxb0=vhxb;
dj0=dj;

n=40;
eee=smoothdata(eee0,'movmean',n);
jxb=smoothdata(jxb0,'movmean',n);
dvp=smoothdata(dvp0,'movmean',n);
vlxb=smoothdata(vlxb0,'movmean',n);
vhxb=smoothdata(vhxb0,'movmean',n);
dj=smoothdata(dj0,'movmean',n);



tot=jxb+dvp+vlxb+vhxb+dj;
% tot=smoothdata(tot);
%% figure
ll=prm.value.lz;
figure;
plot(ll,eee,'-k','LineWidth',2); hold on
plot(ll,tot,'--k','LineWidth',2);
plot(ll,jxb,'-r','LineWidth',2);
plot(ll,dvp,'-g','LineWidth',2);
plot(ll,vlxb,'-b','LineWidth',2);
plot(ll,vhxb,'-m','LineWidth',2);
plot(ll,dj,'-y','LineWidth',2);
xlim(xrange);
legend('E', 'Sum','J\times B/eN','-\nabla \cdot P_e/eN','-(Nih/N)(Vih\times B)','-(Nic/N)(Vic\times B)','(m_e/e^2n)\partial J/\partial t','Location','Best')
xlabel('Z [c/\omega_{pi}]');
ylabel('Ez');
% title(['\Omega_{ci}t=',num2str(tt)]);
set(gca,'FontSize',12);
cd(outdir);
% print('-dpng','-r300',['Ez_cold_ion_t',num2str(tt),'_x',num2str(xz),'.png']);


function [JxB, divP, VlxB, VhxB, dJ] = calc_Ohm_law_with_cold_ions(prm, tt, dt)
N1=prm.read('Ne',tt);
N2=prm.read('Nhe',tt);
N=slj.Scalar(N1.value + N2.value);
%% JxB term
J=prm.read('J',tt);
B=prm.read('B',tt);
q=prm.value.qi;
jb.x=(-B.y.*J.z+B.z.*J.y)./(q*N.value);
jb.y=(-B.z.*J.x+B.x.*J.z)./(q*N.value);
jb.z=(-B.x.*J.y+B.y.*J.x)./(q*N.value);
JxB=slj.Vector(jb);

%% nabla dot Pe term
P=prm.read('Pe',tt);
q=prm.value.qe;
dP=P.divergence(prm);
divP.x=-dP.x./(q*N.value);
divP.y=-dP.y./(q*N.value);
divP.z=-dP.z./(q*N.value);
divP=slj.Vector(divP);

%% -Vih x B
V=prm.read('Vl',tt);
Nl=prm.read('Nl',tt);
B=prm.read('B',tt);
Nl=-Nl.value./N.value;
vb.x=(-B.y.*V.z+B.z.*V.y).*Nl;
vb.y=(-B.z.*V.x+B.x.*V.z).*Nl;
vb.z=(-B.x.*V.y+B.y.*V.x).*Nl;
VlxB=slj.Vector(vb);


%% Vic x B
V=prm.read('Vh',tt);
Nh=prm.read('Nh',tt);
Nh=-Nh.value./N.value;
vb.x=(-B.y.*V.z+B.z.*V.y).*Nh;
vb.y=(-B.z.*V.x+B.x.*V.z).*Nh;
vb.z=(-B.x.*V.y+B.y.*V.x).*Nh;
VhxB=slj.Vector(vb);

%% electron inertial term
q=prm.value.qi;
m=prm.value.me;
Jp=prm.read('J', tt-dt);
Jn=prm.read('J', tt+dt);
dJ.x=(Jn.x-Jp.x)*dt*2*prm.value.wci;
dJ.y=(Jn.y-Jp.y)*dt*2*prm.value.wci;
dJ.z=(Jn.z-Jp.z)*dt*2*prm.value.wci;
dJ.x=(dJ.x*m)./(q*q*N.value);
dJ.y=(dJ.y*m)./(q*q*N.value);
dJ.z=(dJ.z*m)./(q*q*N.value);
dJ=slj.Vector(dJ);
end