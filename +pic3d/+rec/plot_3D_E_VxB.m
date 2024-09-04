%% plot the E and V \cross B
clear;
%%
indir='Z:\Simulation\moon\run1.2\';
outdir='Z:\Simulation\moon\run1.2\out\';
prm = slj.Parameters(indir, outdir);

tt = 10;
norm = prm.value.vA;

%% read data
cd(indir);
E = prm.read('E', tt);
V = prm.read('Vi', tt);
B = prm.read('B', tt);

%% cross
VB = B.cross(V);

%% plot the face
figure;
slj.Plot.field3d(VB.y./norm, prm.value.lx, prm.value.ly, prm.value.lz, ...
    [], ...
    [prm.value.ly(end/2)], ...
    [], []);
zlim([prm.value.lz(1), prm.value.lz(end)]);
xlabel('X [c/\omega_{pi}]');
ylabel('Y [c/\omega_{pi}]');
zlabel('Z [c/\omega_{pi}]');
title(['[-V\times B]_y, \Omega_{ci} t = ', num2str(tt)]);
set(gca, 'FontSize', 14);

%% get the line
lE = E.y(prm.value.ny/2, :, prm.value.nz/2)./norm;
lVB = VB.y(prm.value.ny/2, :, prm.value.nz/2)./norm;
figure;
plot(prm.value.lx, lE, '-k', 'LineWidth', 2);
hold on
plot(prm.value.lx, lVB, '-r', 'LineWidth', 2);
xlabel('X [c/\omega_{pi}]');
legend('Ey', '[-V\times B]_y', 'Box', 'Off');
set(gca, 'FontSize', 14);

%%
cd(outdir);