%%
% figure 5
% generlized Ohm's law at two moments
%%
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article';
prm=slj.Parameters(indir,outdir);
datdir = 'E:\Asym\cold2_ds1\out\Article\data';

%% time
tt1 = 48;
tt2 = 48;
dt = 0.1;

%% line properties
q=prm.value.qi;
m=prm.value.mi;

norm=prm.value.vA;
xz1=25;
xz2=30;
dir=1;

dd = 40;
nn = 10;

%% figure properties
fontsize = 14;
xrange=[-5,5];


%% calculation
ll = prm.value.lz;
[E, JxB, divP, VlxB, VhxB, dJ] = calc_Ohm_law_with_cold_ions_z_direction(prm, tt1, dt);
[tot1, eee1, jxb1, dvp1, vlxb1, vhxb1, dj1] = smooth_Ohm_components(prm, xz1, dd, nn, E, JxB, divP, VlxB, VhxB, dJ);

[E, JxB, divP, VlxB, VhxB, dJ] = calc_Ohm_law_with_cold_ions_z_direction(prm, tt2, dt);
[tot2, eee2, jxb2, dvp2, vlxb2, vhxb2, dj2] = smooth_Ohm_components(prm, xz2, dd, nn, E, JxB, divP, VlxB, VhxB, dJ);

%% figure size
f=figure('Position',[500,500,900,400]);
ha=slj.Plot.subplot(1,2,[0.0001,0.1],[0.2,0.07],[0.1,0.025]);

%% t1
axes(ha(1));
plot(ll,eee1/norm,'-k','LineWidth',2); hold on
plot(ll,jxb1/norm,'-r','LineWidth',2);
plot(ll,dvp1/norm,'-g','LineWidth',2);
plot(ll,vlxb1/norm,'-b','LineWidth',2);
plot(ll,vhxb1/norm,'-m','LineWidth',2);
plot(ll,dj1/norm,'-y','LineWidth',2);
plot(ll,tot1/norm,'--k','LineWidth',2);
xlabel('Z [c/\omega_{pi}]');
ylabel('Ez');
legend('E','J\times B/eN','-\nabla \cdot P_e/eN','-(Nih/N)(Vih\times B)','-(Nic/N)(Vic\times B)','(m_e/e^2N)\partial J/\partial t',...
    'Sum','Location','Best','Box','off', 'Position',[0.305125001862645 0.481550012367963 0.17599999627471 0.432499987632037]);
xlim(xrange);
set(gca,'XTick',-4:2:4);
set(gca,'FontSize',fontsize);


%% t2
axes(ha(2));
plot(ll,eee2/norm,'-k','LineWidth',2); hold on
plot(ll,jxb2/norm,'-r','LineWidth',2);
plot(ll,dvp2/norm,'-g','LineWidth',2);
plot(ll,vlxb2/norm,'-b','LineWidth',2);
plot(ll,vhxb2/norm,'-m','LineWidth',2);
plot(ll,dj2/norm,'-y','LineWidth',2);
plot(ll,tot2/norm,'--k','LineWidth',2);
xlabel('Z [c/\omega_{pi}]');
ylabel('Ez');
xlim(xrange);
set(gca,'XTick',-4:2:4);
set(gca,'FontSize',fontsize);

%% panel label
fontsize=fontsize + 2;
annotation(f,'textbox',...
    [0.104444444444444 0.836500001788139 0.0549999986920092 0.0849999982118607],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.592222222222222 0.836500001788139 0.0549999986920092 0.0849999982118607],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',fontsize);


%% save figure
cd(outdir);
% print(f,'-dpng','-r300','figure5.png');
% print(f,'-depsc','-painters','figure5.eps');




function [tot, eee, jxb, dvp, vlxb, vhxb, dj] = smooth_Ohm_components(prm, xz, dd, nn, E, JxB, divP, VlxB, VhxB, dJ)
    [~, xz] = min(abs(prm.value.lx - xz));
    eee = mean(E(:, xz-dd:xz+dd), 2);
    jxb = mean(JxB(:, xz-dd:xz+dd), 2);
    dvp = mean(divP(:, xz-dd:xz+dd), 2);
    vlxb = mean(VlxB(:, xz-dd:xz+dd), 2);
    vhxb = mean(VhxB(:, xz-dd:xz+dd), 2);
    dj = mean(dJ(:, xz-dd:xz+dd), 2);

    eee=smoothdata(eee,'movmean',nn);
    jxb=smoothdata(jxb,'movmean',nn);
    dvp=smoothdata(dvp,'movmean',nn);
    vlxb=smoothdata(vlxb,'movmean',nn);
    vhxb=smoothdata(vhxb,'movmean',nn);
    dj=smoothdata(dj,'movmean',nn);
    tot=jxb+dvp+vlxb+vhxb+dj;
end


function [E, JxB, divP, VlxB, VhxB, dJ] = calc_Ohm_law_with_cold_ions_z_direction(prm, tt, dt)
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

%% electric field
E=prm.read('E',tt);

%% the z components
E = E.z;
JxB = JxB.z;
divP = divP.z;
VlxB = VlxB.z;
VhxB = VhxB.z;
dJ = dJ.z;
end