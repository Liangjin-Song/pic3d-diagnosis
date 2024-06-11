%% plot nonidea electric field
clear;
%% parameters
indir='Z:\Simulation\Zhong\moon\run3';
outdir='Z:\Simulation\Zhong\moon\run3\out\profile';
prm=slj.Parameters(indir,outdir);

%%
tt = 21;
dir = 0;
xz = 0;
ll = prm.value.lx;
labelx = 'X [c/\omega_{di}]';
spc = 'i';

%% read data
cd(indir);
E = prm.read('E', tt);
V = prm.read(['V', spc], tt);
B = prm.read('B', tt);

%% calculation
En = E + V.cross(B);

%% profiles
le = En.get_line2d(xz, dir, prm, prm.value.vA);

%% plot
figure;
hold on
plot(ll, le.lx, '-r', 'LineWidth', 2);
plot(ll, le.ly, '-k', 'LineWidth', 2);
plot(ll, le.lz, '-b', 'LineWidth', 2);
legend('x', 'y', 'z', 'Box', 'Off', 'Location', 'Best');
xlabel(labelx);
ylabel(['E + V', spc, ' \times B']);
set(gca, 'FontSize', 14);

%% save figure
cd(outdir);
