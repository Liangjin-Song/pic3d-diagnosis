clear;
%% parameters
indir='E:\Turbulence\9.2\data';
outdir='E:\Turbulence\9.2\out\pressurework';
prm=slj.Parameters(indir,outdir);

tt = 77;
name='e';

xz = 160;
dir = 1;
dd = 0;

if name == 'l'
    sfx='ih';
    spc = 'hot ion';
elseif name == 'h'
    sfx='ic';
    spc = 'cold ion';
elseif name == 'e'
    sfx = 'e';
    spc = 'electron';
elseif name == 'i'
    sfx = 'i';
    spc = 'ion';
else
    error('Parameters Error!');
end

norm=prm.value.qi*prm.value.n0*prm.value.vA*prm.value.vA;

%% load data
cd(indir);
P = prm.read(['P', name], tt);
V = prm.read(['V', name], tt);

%% \nabla \cdot (P \cdot V)
divPV = P.dot(V);
divPV = divPV.divergence(prm);
divPV = obtain_line(divPV.value, dd, xz, prm.value.lx, norm);

%% V \cdot (\nabla \cdot P)
VdivP = V.dot(P.divergence(prm));
VdivP = obtain_line(VdivP.value, dd, xz, prm.value.lx, norm);

%% -(P \cdot \nabla) \cdot V
tmp = slj.Scalar(V.x);
tmp = tmp.gradient(prm);
PdivV = P.xx .* tmp.x + P.xy .* tmp.y + P.xz .* tmp.z;
tmp = slj.Scalar(V.y);
tmp = tmp.gradient(prm);
PdivV = PdivV + P.xy .* tmp.x + P.yy .* tmp.y + P.yz .* tmp.z;
tmp = slj.Scalar(V.z);
tmp = tmp.gradient(prm);
PdivV = slj.Scalar(-PdivV - P.xz .* tmp.x - P.yz .* tmp.y - P.zz .* tmp.z);
PdivV = obtain_line(PdivV.value, dd, xz, prm.value.lx, norm);

%% plot overview
cd(outdir);
figure;
plot(prm.value.lz, VdivP, '-r', 'LineWidth', 2);
hold on
plot(prm.value.lz, PdivV, '-b', 'LineWidth', 2);
plot(prm.value.lz, VdivP + VdivP, '-k', 'LineWidth', 2);
plot(prm.value.lz, divPV, '--g', 'LineWidth', 2);
xlim([prm.value.lz(1), prm.value.lz(end)]);
xlabel('Z [d_e]');
ylabel('Pressure Work');
legend('V \cdot (\nabla \cdot P)', '-(P \cdot \nabla) \cdot V', 'V \cdot (\nabla \cdot P) + (P \cdot \nabla) \cdot V', '\nabla \cdot (P \cdot V)', 'Box', 'off');
title([spc, ', profiles along x=', num2str(xz),', t = ', num2str(tt)]);
set(gca, 'FontSize', 14);
print('-dpng', '-r300', [spc, '_pressure_work_x=', num2str(xz), '_t', num2str(tt, '%06.2f'), '.png']);

%%
function lfd = obtain_line(fd, dd, xz, ll, norm)
[~, in] = min(abs(ll - xz));
lfd = fd(:, in-dd:in+dd);
lfd = mean(lfd, 2)/norm;
end