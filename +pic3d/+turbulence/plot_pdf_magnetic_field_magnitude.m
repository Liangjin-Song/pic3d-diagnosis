%% plot the pdf
clear;
%% parameters
indir='Y:\turbulence5.55';
outdir='C:\Users\Liangjin\Pictures\Turbulence\Energy';
prm=slj.Parameters(indir,outdir);

%%
tt = 50;
xz = 10;
norm = 1;

r = 1 * prm.value.de;

%% read data
fd = prm.read('B', tt);
fd = slj.Scalar(sqrt(fd.x.^2 + fd.y.^2 + fd.z.^2));
lf = fd.get_line2d(xz, 1, prm, norm);

%%
tf = [lf; lf];
nv = length(lf);
df = tf(r+1:(nv+r)) - lf;
df = lowpass(df, 0.000000001);
%% spectrum
[l1, pdf1, mu1, sigma1] = slj.Physics.pdf(df, 200);

%% gauss
pdf2 = slj.Physics.gauss(size(df)*5, mu1, sigma1);
[l2, pdf2, mu2, sigma2] = slj.Physics.pdf(pdf2, 200);
%%
figure;
plot(l1, pdf1, '-k', 'LineWidth', 2);
hold on 
plot(l2, pdf2, '-r', 'LineWidth', 2);
name = '\delta B(r)';
legend(name, 'Gaussian', 'Box', 'off');
xlabel(name);
ylabel('PDF');
ylim([1e-6, 0.1])
title(['t = ', num2str(tt)]);
set(gca, 'YScale', 'log');
set(gca, 'FontSize', 14);

%% 
cd(outdir);
% print('-dpng','-r300',[name,'_PDF_t', num2str(tt),'.png']);
