%% function plot_Ohm_law
% written by Liangjin Song on 20220330 at Nanchang University
clear;
%% parameters
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Ohm';
prm=slj.Parameters(indir,outdir);

tt=40;
dt=0.5;
name='l';

q=prm.value.qi;
m=prm.value.mi;

norm=prm.value.vA;
xz=22;
dir=1;
pxz=prm.value.nz/2;
dxz=100;

%% figure proterty
xrange=[-5,5];

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

eee=smoothdata(eee0,'movmean',5);
jxb=smoothdata(jxb0,'movmean',5);
dvp=smoothdata(dvp0,'movmean',5);
vlxb=smoothdata(vlxb0,'movmean',5);
vhxb=smoothdata(vhxb0,'movmean',5);
dj=smoothdata(dj0,'movmean',5);



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
legend('E','Sum','J\times B/eN','-\nabla \cdot P_e/eN','-(Nih/N)(Vih\times B)','-(Nic/N)(Vic\times B)','(m_e/e^2n)\partial J/\partial t','Location','Best')
xlabel('Z [c/\omega_{pi}]');
ylabel('Ez');
% title(['\Omega_{ci}t=',num2str(tt)]);
set(gca,'FontSize',12);
cd(outdir);
% print('-dpng','-r300',['Ey_cold_ion_t',num2str(tt),'_x',num2str(xz),'.png']);


function [JxB, divP, VlxB, VhxB, dJ] = calc_Ohm_law_with_cold_ions(prm, tt, dt)
N=prm.read('Ne',tt);
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
divP.x=dP.x./(q*N.value);
divP.y=dP.y./(q*N.value);
divP.z=dP.z./(q*N.value);
divP=slj.Vector(divP);

%% -Vih x B
V=prm.read('Vl',tt);
Nl=prm.read('Nl',tt);
B=prm.read('B',tt);
Nl=-Nl.value./N.value;
vb.x=(-B.y.*V.z+B.z.*V.y)./Nl;
vb.y=(-B.z.*V.x+B.x.*V.z)./Nl;
vb.z=(-B.x.*V.y+B.y.*V.x)./Nl;
VlxB=slj.Vector(vb);


%% Vic x B
V=prm.read('Vh',tt);
Nh=prm.read('Nh',tt);
Vh.x = V.x.*Nh.value;
Vh.y = V.y.*Nh.value;
Vh.z = V.z.*Nh.value;
V = slj.Vector(Vh);
B=prm.read('B',tt);
vb.x=(-B.y.*V.z+B.z.*V.y)./N.value;
vb.y=(-B.z.*V.x+B.x.*V.z)./N.value;
vb.z=(-B.x.*V.y+B.y.*V.x)./N.value;
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