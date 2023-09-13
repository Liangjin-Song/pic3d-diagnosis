%% The 1D FFT
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Wave';
prm=slj.Parameters(indir,outdir);

tt = 28;
name = 'E';

xz = -0.66;
dir = 0;

norm = prm.value.vA;
lx = prm.value.lx;
%% load data
fd = prm.read(name, tt);

%% get the line
lf = fd.get_line2d(xz, dir, prm, norm);
lf = lf.lx;

%% FFT


%% plot figure
figure;
plot(lx, lf, '-k', 'LineWidth', 2);
set(get(gca, 'XLabel'), 'String', 'X [c/\omega_{pi}]');
set(get(gca, 'YLabel'), 'String', 'Ex');
set(gca, 'FontSize', 16);