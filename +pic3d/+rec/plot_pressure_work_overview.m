clear;
%% parameters
indir='Z:\Simulation\sym\rec1d';
outdir='Z:\Simulation\sym\rec1d\out\work';
prm=slj.Parameters(indir,outdir);

tt = 23;
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
ss= prm.read('B', tt);
ss= slj.Physics.stream2d(ss.x, ss.z);

%% \nabla \cdot (P \cdot V)
divPV = P.dot(V);
divPV = divPV.divergence(prm);

%% V \cdot (\nabla \cdot P)
VdivP = V.dot(P.divergence(prm));

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
PdivV = -PdivV;

%% plot overview
cd(outdir);
extra.xlabel = 'X [di]';
extra.ylabel = 'Z [di]';
extra.title = 14;

f1 = figure;
extra.title = ['t=', num2str(tt), ', ', spc, ', \nabla \cdot (P\cdot V)'];
slj.Plot.overview(divPV, ss, prm.value.lx, prm.value.lz, norm, extra);
colormap(slj.Plot.slanCM('bwr'));

f2 = figure;
extra.title = ['t=', num2str(tt), ', ', spc, ', V\cdot(\nabla\cdot P)'];
slj.Plot.overview(VdivP, ss, prm.value.lx, prm.value.lz, norm, extra);
colormap(slj.Plot.slanCM('bwr'));

f3 = figure;
extra.title = ['t=', num2str(tt), ', ', spc, ', -(P\cdot\nabla)\cdot V'];
slj.Plot.overview(PdivV, ss, prm.value.lx, prm.value.lz, norm, extra);
colormap(slj.Plot.slanCM('bwr'));

print(f1, '-dpng', '-r300', [spc, '_divPV_t', num2str(tt, '%06.2f'), '.png']);
print(f2, '-dpng', '-r300', [spc, '_VdivP_t', num2str(tt, '%06.2f'), '.png']);
print(f3, '-dpng', '-r300', [spc, '_PdivV_t', num2str(tt, '%06.2f'), '.png']);