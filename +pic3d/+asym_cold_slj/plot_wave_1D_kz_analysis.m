%% The 1D FFT
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Wave';
prm=slj.Parameters(indir,outdir);

tt = 28;
name = 'B';

xz = 40;
dir = 1;

norm = 1.72; % 0.036*1.72; % 334.3; % 1.72;

%% the length
L = length(prm.value.lz);

%% frequency of sampling
% fs = prm.value.di;
fs = 2.27;

%% the period of sampling
T = 1/fs;

%% the vector
lx = (0:L-1)*T;

%% the index of x=35
[~, n1] = min(abs(prm.value.lz + 2));
[~, n2] = min(abs(prm.value.lz - 2));


%% load data
fd = prm.read(name, tt);

%% get the line
lf = fd.get_line2d(xz, dir, prm, norm);
lf = lf.lx;
cmp = 'x';
filter = true;

%% the range between [35, 50];
lf = lf(n1:n2);
lx = lx(n1:n2);
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