%% The 1D FFT for frequency
clear;
%% parameters
indir='E:\Asym\cold2_ds1\wave';
outdir='E:\Asym\cold2_ds1\out\wave_yrange';
prm=slj.Parameters(indir,outdir);

name = 'Bz';
filter = true;

%% normalization
vA = 0.036;
B0 = 1.72;
norm = B0;

px = 40;

%% the index where z = -0.66
% iz = 74
iz = 140;

%% read data
lf = load([name, '_x', num2str(px), '.dat']);
lf = lf(:, iz);
L = length(lf);

%% frequency of sampling
wpi = 0.1;
fs = 1/wpi;

%% the period of sampling
T = 1/fs;

%% the vector
lt = (0:L-1)*prm.value.wci;
[~, n1] = min(abs(lt - 27));
[~, n2] = min(abs(lt - 29));

%% range between 27 and 29
lf = lf(n1:n2);
lt = lt(n1:n2);
L = length(lf);

%% high-pass
if filter
    lf = highpass(lf, 0.12, fs);
end

%% FFT
Y = fft(lf);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end) = 2*P1(2:end);
w = fs * (0:(L/2))/L;

%% plot figure
cd(outdir);
f1=figure;
plot(lt, lf, '-k', 'LineWidth', 2);
set(get(gca, 'XLabel'), 'String', '\Omega_{ci}t');
set(get(gca, 'YLabel'), 'String', [name, '(t)']);
set(gca, 'FontSize', 16);

f2=figure;
plot(w, P1, '-k', 'LineWidth', 2);
xlabel('\omega [\omega_{pe}]');
ylabel([name, '(\omega)']);
set(gca, 'FontSize', 16);

if filter
    print(f1, '-dpng', '-r300', [name, '_t_x=40_highpass.png']);
    print(f2, '-dpng', '-r300', [name, '_w_x=40_highpass.png']);
else
    print(f1, '-dpng', '-r300', [name, '_t_x=40.png']);
    print(f2, '-dpng', '-r300', [name, '_w_x=40.png']);
end