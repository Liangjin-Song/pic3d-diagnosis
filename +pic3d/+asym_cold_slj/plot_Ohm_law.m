%% function plot_Ohm_law
% written by Liangjin Song on 20220330 at Nanchang University
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);

tt=28;
dt=0.1;

q=prm.value.qi;
m=prm.value.mi;

norm=prm.value.vA;
xz=35;
dir=1;
pxz=prm.value.nz/2;
% dd=40;
% nn=10;
dd = 40;
nn = 10;

cmpt = 'y';

%% figure proterty
xrange=[-5,5];
xtick=-5:2:5;

%% momentum equation
E=prm.read('E',tt);
[JxB, divP, VlxB, VhxB, dJ] = calc_Ohm_law_with_cold_ions(prm, tt, dt);



if cmpt == 'x'
    E = E.x;
    JxB = JxB.x;
    divP = divP.x;
    VlxB = VlxB.x;
    VhxB = VhxB.x;
    dJ = dJ.x;
elseif cmpt == 'y'
    E = E.y;
    JxB = JxB.y;
    divP = divP.y;
    VlxB = VlxB.y;
    VhxB = VhxB.y;
    dJ = dJ.y;
elseif cmpt == 'z'
    E = E.z;
    JxB = JxB.z;
    divP = divP.z;
    VlxB = VlxB.z;
    VhxB = VhxB.z;
    dJ = dJ.z;
else
    error('Parameters error!');
end


if dir == 0
    sdir = 'z';
    xlab = 'X [c/\omega_{pi}]';
    ll = prm.value.lx;
    lp = prm.value.lz;
    [~, xz] = min(abs(prm.value.lz - xz));
    eee = mean(E(xz-dd:xz+dd, :), 1);
    jxb = mean(JxB(xz-dd:xz+dd, :), 1);
    dvp = mean(divP(xz-dd:xz+dd, :), 1);
    vlxb = mean(VlxB(xz-dd:xz+dd, :), 1);
    vhxb = mean(VhxB(xz-dd:xz+dd, :), 1);
    dj = mean(dJ(xz-dd:xz+dd, :), 1);
elseif dir == 1
    sdir = 'x';
    xlab = 'Z [c/\omega_{pi}]';
    ll = prm.value.lz;
    lp = prm.value.lx;
    [~, xz] = min(abs(prm.value.lx - xz));
    eee = mean(E(:, xz-dd:xz+dd), 2);
    jxb = mean(JxB(:, xz-dd:xz+dd), 2);
    dvp = mean(divP(:, xz-dd:xz+dd), 2);
    vlxb = mean(VlxB(:, xz-dd:xz+dd), 2);
    vhxb = mean(VhxB(:, xz-dd:xz+dd), 2);
    dj = mean(dJ(:, xz-dd:xz+dd), 2);
else
    error('Parameters error!');
end

%% smooth data
eee=smoothdata(eee,'movmean',nn);
jxb=smoothdata(jxb,'movmean',nn);
dvp=smoothdata(dvp,'movmean',nn);
vlxb=smoothdata(vlxb,'movmean',nn);
vhxb=smoothdata(vhxb,'movmean',nn);
dj=smoothdata(dj,'movmean',nn);
tot=jxb+dvp+vlxb+vhxb+dj;
% tot=smoothdata(tot);


%% figure
figure;
plot(ll,eee/norm,'-k','LineWidth',2); hold on
plot(ll,jxb/norm,'-r','LineWidth',2);
plot(ll,dvp/norm,'-g','LineWidth',2);
plot(ll,vlxb/norm,'-b','LineWidth',2);
plot(ll,vhxb/norm,'-m','LineWidth',2);
plot(ll,dj/norm,'-y','LineWidth',2);
plot(ll,tot/norm,'--k','LineWidth',2);
xlim(xrange);
set(gca,'XTick',xtick);
legend('E','J\times B/eN','-\nabla \cdot P_e/eN','-(Nih/N)(Vih\times B)','-(Nic/N)(Vic\times B)','(m_e/e^2n)\partial J/\partial t',...
    'Sum','Location','Best','Box','off');
xlabel(xlab);
ylabel(['E_',cmpt]);
title(['\Omega_{ci}t=',num2str(tt),', profiles  ', sdir,' = ',num2str(round(lp(xz)))]);
set(gca,'FontSize',12);
cd(outdir);
% print('-dpng','-r300',['E',cmpt,'_Ohm_t',num2str(tt),'_x=',num2str(round(lp(xz))),'.png']);


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
m=prm.value.me;
Jp=prm.read('J', tt-dt);
Jn=prm.read('J', tt+dt);
dJ.x=(Jn.x-Jp.x)*prm.value.wci/(2*dt);
dJ.y=(Jn.y-Jp.y)*prm.value.wci/(2*dt);
dJ.z=(Jn.z-Jp.z)*prm.value.wci/(2*dt);
dJ.x=(dJ.x*m)./(q*q*N.value);
dJ.y=(dJ.y*m)./(q*q*N.value);
dJ.z=(dJ.z*m)./(q*q*N.value);
dJ=slj.Vector(dJ);
end