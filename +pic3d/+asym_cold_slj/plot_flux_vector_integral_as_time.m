clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Overview\pressure_work';
prm=slj.Parameters(indir,outdir);

tt = 0:60;
name='e';

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
rate = zeros(nt, 4);
cd(indir);
for t = 1:nt
    %% load data
    P = prm.read(['P', name], tt(t));
    V = prm.read(['V', name], tt(t));
    N = prm.read(['N', name], tt(t));
    
    %% \nabla \cdot (NV)
    NV = [];
    NV.x = N.value .* V.x;
    NV.y = N.value .* V.y;
    NV.z = N.value .* V.z;
    NV = slj.Vector(NV);
    divNV = NV.divergence(prm);
    rate(t, 1) = sum(divNV.value, 'all');

    %% \nabla \cdot (KV)
    K = 0.5 .* prm.value.me .* N.value .* (V.x.^2 + V.y.^2 + V.z.^2);
    KV = [];
    KV.x = K .* V.x;
    KV.y = K .* V.y;
    KV.z = K .* V.z;
    KV = slj.Vector(KV);
    divKV = KV.divergence(prm);
    rate(t, 2) = sum(divKV.value, 'all');

    %% \nabla \cdot (UV)
    U = 0.5 * (P.xx + P.yy + P.zz);
    UV = [];
    UV.x = U .* V.x;
    UV.y = U .* V.y;
    UV.z = U .* V.z;
    UV = slj.Vector(UV);
    divUV = UV.divergence(prm);
    rate(t, 3) = sum(divUV.value, 'all');

    %% \nabla \cdot (P \cdot V)
    divPV = P.dot(V);
    divPV = divPV.divergence(prm);
    rate(t, 4) = sum(divPV.value, 'all');
end

f = figure;
hold on
% plot(tt, rate(:, 1), '-k', 'LineWidth', 1.5);
plot(tt, rate(:, 2), '-r', 'LineWidth', 1.5);
plot(tt, rate(:, 3), '-g', 'LineWidth', 1.5);
plot(tt, rate(:, 4), '-b', 'LineWidth', 1.5);
xlabel('\Omega_{ci}t');
legend('\nabla\cdot(KV)', '\nabla\cdot(UV)', '\nabla\cdot(P\cdot V)', 'Box', 'off');
cd(outdir);