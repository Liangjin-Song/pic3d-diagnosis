clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Overview\pressure_work';
prm=slj.Parameters(indir,outdir);

tt = 0:60;
xrange = 801:1200;
yrange = 401:600;
name='l';

if name == 'l'
    sfx='ih';
    spc = 'hot ion';
elseif name == 'h'
    sfx='ic';
    spc = 'cold ion';
elseif name == 'e'
    sfx = 'e';
    spc = 'electron';
else
    error('Parameters Error!');
end

norm=prm.value.qi*prm.value.n0*prm.value.vA*prm.value.vA;

nt = length(tt);
rate = zeros(nt, 3);
cd(indir);
for t = 1:nt
    %% load data
    P = prm.read(['P', name], tt(t));
    V = prm.read(['V', name], tt(t));
    
    %% \nabla \cdot (P \cdot V)
    divPV = P.dot(V);
    divPV = divPV.divergence(prm);
    rate(t, 1) = sum(divPV.value(yrange, xrange), 'all');
    
    %% V \cdot (\nabla \cdot P)
    VdivP = V.dot(P.divergence(prm));
    rate(t, 2) = sum(VdivP.value(yrange, xrange), 'all');
    
    %% (P \cdot \nabla) \cdot V
    tmp = slj.Scalar(V.x);
    tmp = tmp.gradient(prm);
    PdivV = P.xx .* tmp.x + P.xy .* tmp.y + P.xz .* tmp.z;
    tmp = slj.Scalar(V.y);
    tmp = tmp.gradient(prm);
    PdivV = PdivV + P.xy .* tmp.x + P.yy .* tmp.y + P.yz .* tmp.z;
    tmp = slj.Scalar(V.z);
    tmp = tmp.gradient(prm);
    PdivV = PdivV + P.xz .* tmp.x + P.yz .* tmp.y + P.zz .* tmp.z;
    rate(t, 3) = sum(PdivV(yrange, xrange), 'all');
end

%%
cd(outdir)
figure;
plot(tt, rate(:, 1), '-k', 'LineWidth', 1.5);
hold on
plot(tt, rate(:, 2), '-r', 'LineWidth', 1.5);
plot(tt, rate(:, 3), '-b', 'LineWidth', 1.5);
plot(tt, rate(:, 2) + rate(:, 3), '--k', 'LineWidth', 1.5);
xlabel('\Omega_{ci}t');
legend('\nabla \cdot (P \cdot V)', 'V \cdot (\nabla \cdot P)', '(P \cdot \nabla) \cdot V', 'Sum', 'Box', 'off');
title(['pressure work of ', spc]);
set(gca, 'FontSize', 14);
print('-dpng', '-r300', ['pressure_work_', spc, '.png']);