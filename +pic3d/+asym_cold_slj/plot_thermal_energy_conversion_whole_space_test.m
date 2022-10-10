% function plot_thermal_energy_conversion_as_time
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);


tt=7.4;
name='h';

if name == 'l'
    sfx='ih';
    q=prm.value.qi;
    m=prm.value.mi;
elseif name == 'h'
    sfx='ic';
    q=prm.value.qi;
    m=prm.value.mi;
elseif name == 'e'
    sfx = 'e';
    q=prm.value.qe;
    m=prm.value.me;
else
    error('Parameters Error!');
end

% norm=prm.value.qi*prm.value.n0*prm.value.vA*prm.value.vA;
norm = 1;
extra=[];

%% read data
V=prm.read(['V',name],tt);
P=prm.read(['P',name],tt);
ss=prm.read('stream',tt);

%% V \cdot (\nabla \cdot P)
divP=P.divergence(prm);
VdivP = divP.x.*V.x + divP.y.*V.y + divP.z.*V.z;

%% -(P \cdot \nabla) \cdot V
gV = slj.Scalar(V.x);
gV = gV.gradient(prm);
PV1 = P.xx .* gV.x + P.xy .* gV.y + P.xz .* gV.z;
gV = slj.Scalar(V.y);
gV = gV.gradient(prm);
PV2 = P.xy .* gV.x + P.yy .* gV.y + P.yz .* gV.z;
gV = slj.Scalar(V.z);
gV = gV.gradient(prm);
PV3 = P.xz .* gV.x + P.yz .* gV.y + P.zz .* gV.z;
PdivV = -PV1 - PV2 - PV3;

%% - \nbala \cdot (P \cdot V)
PV.x = P.xx.*V.x + P.xy.*V.y + P.xz.*V.z;
PV.y = P.xy.*V.x + P.yy.*V.y + P.yz.*V.z;
PV.z = P.xz.*V.x + P.yz.*V.y + P.zz.*V.z;
PV = slj.Vector(PV);
divPV = PV.divergence(prm);
divPV = -divPV.value;

delta = PdivV - divPV - VdivP;

%% sum
adivPV = sum(divPV, 'all');
aPdivV = sum(PdivV, 'all');
aVdivP = sum(VdivP, 'all');
adelta = sum(delta, 'all');

%% plot overview
f1=figure;
slj.Plot.overview(divPV,ss,prm.value.lx,prm.value.lz,norm,extra);
title('-\nabla\cdot(P\cdotV)');
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
f2=figure;
slj.Plot.overview(PdivV,ss,prm.value.lx,prm.value.lz,norm,extra);
title('-(P\cdot\nabla)\cdotV');
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
f3=figure;
slj.Plot.overview(VdivP,ss,prm.value.lx,prm.value.lz,norm,extra);
title('V\cdot(\nabla\cdotP)');
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');



%% plot line
dir = 1;
xz = 5;
ll = prm.value.lz;
[~, xz] = min(abs(prm.value.lx - xz));
ldivPV = divPV(:, xz);
lPdivV = PdivV(:, xz);
lVdivP = VdivP(:, xz);
f4 = figure;
plot(ll, lPdivV, '-k', 'LineWidth', 1.5);
hold on;
plot(ll, ldivPV + lVdivP, '--g', 'LineWidth', 1.5);
% plot(ll, lVdivP, '-r', 'LineWidth', 1.5);
% plot(ll, ldivPV, '-b', 'LineWidth', 1.5);
xlabel('Z [c/\omega_{pi}]');
legend('-(P\cdot\nabla)\cdotV', 'V\cdot(\nabla\cdotP)-\nabla\cdot(P\cdotV)'); % , 'V\cdot(\nabla\cdotP)', '-\nabla\cdot(P\cdotV)');
set(gca,'FontSize',16);

f5 = figure;
plot(ll, lPdivV - ldivPV - lVdivP, '-k','LineWidth',1.5);
xlabel('Z [c/\omega_{pi}]');
ylabel('\delta');


cd(outdir);
