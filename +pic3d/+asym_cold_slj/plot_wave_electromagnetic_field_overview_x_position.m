%% plot the electromagnetic field overview and PSD along x in z direction
clear;
%% parameters
indir='E:\Asym\cold2_ds1\wave';
outdir='E:\Asym\cold2_ds1\out\Wave';
prm=slj.Parameters(indir,outdir);

%% the position
xx = 40;

%% componetn
cE = 'z';
cB = 'z';

%% electric field
cd(indir);
E = load(['E', cE,'_x', num2str(xx), '.dat']);
E = imfilter(E, fspecial('average', [5,5]));
B = load(['B', cB,'_x', num2str(xx), '.dat']);

%% size
range = 400:600;
[nE, ~] = size(E);
tE = 0:nE-1;
tE = tE * prm.value.wci;
[nB, nx] = size(B);
tB = 0:nB-1;
tB = tB * prm.value.wci;
cd(outdir);

%% plot figure
f1 = figure;
slj.Plot.field2d(E, prm.value.lz(range), tE, []);
xlabel('Z [c/\omega_{pi}]');
ylabel('\Omega_{ci}t');
title(['E', cE]);
set(gca,'FontSize', 14);
print(f1, '-dpng','-r300','E_z_t.png');

%% plot figure
f2 = figure;
slj.Plot.field2d(B, prm.value.lz(range), tB, []);
xlabel('Z [c/\omega_{pi}]');
ylabel('\Omega_{ci}t');
title(['B', cB]);
set(gca,'FontSize', 14);
print(f2, '-dpng','-r300','B_z_t.png');


%% Fourier transform
fE = fftshift(fft2(E));
fB = fftshift(fft2(B));
% dx = 1/40;
% k = 2*pi/dx;
k = 2*pi/60;
k = linspace(-k*0.5, k*0.5, nx);
dt = prm.value.wci;
pdt = dt * prm.value.fpi/prm.value.wci;
f = 0.1;
wE = linspace(-f*0.5, f*0.5, nE);
wB = linspace(-f*0.5, f*0.5, nB);


%% E
f3 = figure;
[X, Y] = meshgrid(k, wE);
p = pcolor(X, Y, abs(fE));
shading flat;
p.FaceColor = 'interp';
colorbar;
% xlabel('k [2\pi/di]');
% ylabel('\omega [\omega_{ci}]');
xlabel('k [2\pi/\lambda_D]');
ylabel('\omega [\omega_{pi}]');
title(['PSD, E', cE]);
set(gca,'FontSize',14);
print(f3, '-dpng','-r300','PSD_E_k_w.png');


%%
f4 = figure;
[X, Y] = meshgrid(k, wB);
p = pcolor(X, Y, abs(fB));
shading flat;
p.FaceColor = 'interp';
colorbar;
% xlabel('k [2\pi/di]');
% ylabel('\omega [\omega_{ci}]');
xlabel('k [2\pi/\lambda_D]');
ylabel('\omega [\omega_{pi}]');
title(['PSD, B', cB]);
set(gca,'FontSize',14);
print(f4, '-dpng','-r300','PSD_B_k_w.png');