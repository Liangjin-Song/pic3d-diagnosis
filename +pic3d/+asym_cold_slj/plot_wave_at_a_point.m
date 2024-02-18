%% input the data
outdir = 'E:\Research\Simulation\cold2_ds1\out\Test';
load('E:\Research\Simulation\cold2_ds1\out\Wave\B_x_t.mat');
norm = 1;
fd = B.z/norm;
name = 'B_z';

%% the point position
x = 35;
lx = prm.value.lx;

%% obtain the data point
[~, idx] = min(abs(lx - x));
lfd = fd(:, idx);

%% plot the figure
f1 = figure;
plot(tt, lfd, '-k', 'LineWidth', 2);
xlabel('\Omega_{ci}t');
ylabel(name);
title(['x = ', num2str(x)]);
set(gca, 'FontSize', 14);
cd(outdir);
print('-dpng', '-r300', 'Ex_t.png');

%% FFt
fs = 1/(tt(2) - tt(1));
[lw, lf] = slj.Physics.fft1d(fs, lfd);
f2 = figure;
plot(lw, lf, '-k', 'LineWidth', 2);
xlabel('\omega [\Omega_{ci}]');
ylabel(name);
title(['x = ', num2str(x)]);
set(gca, 'FontSize', 14);
cd(outdir);
print('-dpng', '-r300', 'Ex_w.png');

%% add rectangle window to FFT
nt = length(tt);
% width of the windows
width = 8;
rfd = zeros(1, nt * 2);
rfd(1:nt) = lfd;
rfd(nt+1:end) = lfd;

res = zeros(width/2 + 1, nt);
for i = 1:nt
    [lw, lf] = slj.Physics.fft1d(fs, rfd(i:i+width-1));
    res(:, i) = lf;
end

% plot figure
f3 = figure;
slj.Plot.field2d_suitable(res, tt, lw, []);
% colormap(slj.Plot.mycolormap(1));
xlabel('t [\Omega_{ci0}^{-1}]');
ylabel('\omega [\omega_{ci0}]');

%% add hamming window to FFT
w = hamming(width);
for i = 1:nt
    [lw, lf] = slj.Physics.fft1d(fs, rfd(i:i+width-1).*w);
    res(:, i) = lf;
end

% plot figure
f4 = figure;
slj.Plot.field2d_suitable(res, tt, lw, []);
xlabel('t [\Omega_{ci0}^{-1}]');
ylabel('\omega [\omega_{ci0}]');

%% add hann window to FFT
w = hann(width);
for i = 1:nt
    [lw, lf] = slj.Physics.fft1d(fs, rfd(i:i+width-1).*w);
    res(:, i) = lf;
end

% plot figure
f5 = figure;
slj.Plot.field2d_suitable(res, tt, lw, []);
xlabel('t [\Omega_{ci0}^{-1}]');
ylabel('\omega [\omega_{ci0}]');

%% the wavelet transform
f6 = figure;
[wt, f, coi] = cwt(lfd, 'amor', fs);
pcolor(tt, f, abs(wt));
shading interp
colorbar
% colormap(slj.Plot.mycolormap(1));
xlabel('t [\Omega_{ci0}^{-1}]');
ylabel('\omega [\omega_{ci0}]');
set(gca, 'FontSize', 14);