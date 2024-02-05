clear;
%% parameters
indir='D:\Downloads\t3d\data';
outdir='D:\Downloads\t3d\data';
prm = slj.Parameters(indir, outdir);

tt=25;
name='Ve';

%% read data
cd(indir);
fd = prm.read(name, tt);

%% plot figure
f1 = figure;
slj.Plot.field3d(fd.y, prm.value.lx, prm.value.ly, prm.value.lz, ...
    [prm.value.lx(1), prm.value.lx(end)], ...
    [prm.value.ly(1), prm.value.ly(end)], ...
    [prm.value.lz(1), prm.value.lz(end)], []);
xlabel('X [c/\omega_{pi}]');
ylabel('Y [c/\omega_{pi}]');
zlabel('Z [c/\omega_{pi}]');
set(gca, 'FontSize', 14);