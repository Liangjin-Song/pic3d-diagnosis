%% parameters
indir='D:\xiao_PIC\asy20220913\ion_lost_energy1';
outdir='D:\xiao_PIC\asy20220913\ion_lost_energy1\out';
prm=slj.Parameters(indir,outdir);

tt=35;
dt=5;

q=prm.value.qi;
m=prm.value.mi;

norm=prm.value.vA;
xz=20;
dir=1;
pxz=prm.value.nz/2;
dd=40;
nn=10;

cmpt = 'z';

%% figure proterty
xrange=[-10,10];

%% momentum equation
E=prm.read('E',tt);
[JxB, divP, VixB, dJ] = calc_Ohm_law(prm, tt, dt);

if cmpt == 'x'
    E = E.x;
    JxB = JxB.x;
    divP = divP.x;
    VixB = VixB.x;
    dJ = dJ.x;
elseif cmpt == 'y'
    E = E.y;
    JxB = JxB.y;
    divP = divP.y;
    VixB = VixB.y;
    dJ = dJ.y;
elseif cmpt == 'z'
    E = E.z;
    JxB = JxB.z;
    divP = divP.z;
    VixB = VixB.z;
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
    vixb = mean(VixB(xz-dd:xz+dd, :), 1);
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
    vixb = mean(VixB(:, xz-dd:xz+dd), 2);
    dj = mean(dJ(:, xz-dd:xz+dd), 2);
else
    error('Parameters error!');
end

%% smooth data
eee=smoothdata(eee,'movmean',nn);
jxb=smoothdata(jxb,'movmean',nn);
dvp=smoothdata(dvp,'movmean',nn);
vixb=smoothdata(vixb,'movmean',nn);
dj=smoothdata(dj,'movmean',nn);
tot=jxb+dvp+vixb+dj;
% tot=smoothdata(tot);


%% figure
figure;
plot(ll,eee/norm,'-k','LineWidth',2); hold on
plot(ll,tot/norm,'--k','LineWidth',2);
plot(ll,jxb/norm,'-r','LineWidth',2);
plot(ll,dvp/norm,'-g','LineWidth',2);
plot(ll,vixb/norm,'-b','LineWidth',2);
plot(ll,dj/norm,'-y','LineWidth',2);
xlim(xrange);
legend('E','Sum','J\times B/eN','-\nabla \cdot P_e/eN','-(Vi\times B)','(m_e/e^2n)\partial J/\partial t',...
    'Location','Best');
xlabel(xlab);
ylabel(['E_',cmpt]);
title(['\Omega_{ci}t=',num2str(tt),', profiles  ', sdir,' = ',num2str(round(lp(xz)))]);
set(gca,'FontSize',12);
cd(outdir);
print('-dpng','-r300',['E',cmpt,'_Ohm_t',num2str(tt),'_x=',num2str(round(lp(xz))),'.png']);


function [JxB, divP, VixB, dJ] = calc_Ohm_law(prm, tt, dt)
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

%% Vi x B
V=prm.read('Vi',tt);
Nh=prm.read('Ni',tt);
Nh=-Nh.value./N.value;
vb.x=(-B.y.*V.z+B.z.*V.y).*Nh;
vb.y=(-B.z.*V.x+B.x.*V.z).*Nh;
vb.z=(-B.x.*V.y+B.y.*V.x).*Nh;
VixB=slj.Vector(vb);

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