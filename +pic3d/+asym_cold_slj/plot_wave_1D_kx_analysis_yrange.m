%% The 1D FFT
clear;
%% parameters
indir='E:\Asym\cold2_ds1\wave';
outdir='E:\Asym\cold2_ds1\out\wave_yrange';
prm=slj.Parameters(indir,outdir);

tt = 28;
name = 'E';

vA = 0.036;
B0 = 1.72;
norm = B0 * vA;

%% the length
L = length(prm.value.lx);

%% frequency of sampling
% fs = prm.value.di;
fs = 2.27;

%% the period of sampling
T = 1/fs;

%% the vector
lx = (0:L-1)*T;

%% the index of x=35
[~, nd] = min(abs(prm.value.lx - 35));
% nd = 1;


%% load data
fd = prm.read(name, tt, 'yrange', prm.value.nx, 200, 1);
fd = fd.z;
cmp = 'z';
filter = true;

%% get the line at z=-0.66
lf = fd(74, :);

%% the range between [35, 50];
lf = lf(nd:end);
lx = lx(nd:end);
L = length(lf);

%% high-pass
if filter
    lf = highpass(lf, 0.03, fs);
end

%% FFT
Y = fft(lf);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end) = 2*P1(2:end);
kx = fs * (0:(L/2))/L;

%% plot figure
cd(outdir);
f1=figure;
plot(lx, lf, '-k', 'LineWidth', 2);
set(get(gca, 'XLabel'), 'String', 'X [\lambda_i]');
set(get(gca, 'YLabel'), 'String', [name,cmp, '(x)']);
xlim([lx(1), lx(end)]);
set(gca, 'FontSize', 16);

f2=figure;
plot(kx, P1, '-k', 'LineWidth', 2);
xlabel('kx [1/\lambda_i]');
ylabel([name,cmp, '(kx)']);
xlim([kx(1), kx(end)]);
set(gca, 'FontSize', 16);

if filter
    print(f1, '-dpng', '-r300', [name, cmp, '_x_x_35-50_t', num2str(tt),'_highpass.png']);
    print(f2, '-dpng', '-r300', [name, cmp, '_kx_x_35-50_t', num2str(tt),'_highpass.png']);
else
    print(f1, '-dpng', '-r300', [name, cmp, '_x_x_35-50_t', num2str(tt),'.png']);
    print(f2, '-dpng', '-r300', [name, cmp, '_kx_x_35-50_t', num2str(tt),'.png']);
end