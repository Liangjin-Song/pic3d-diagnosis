%% plot the pdf
clear;
%% parameters
indir='Y:\turbulence5.55';
outdir='C:\Users\Liangjin\Pictures\Turbulence\Energy';
prm=slj.Parameters(indir,outdir);

%%
tt = 50;
xz = 10;
norm = prm.value.qi*prm.value.n0*prm.value.vA.^2;

%% read data
J = prm.read('J', tt);
E = prm.read('E', tt);
fd = J.dot(E);
lf = fd.value(:) / norm;
name = 'J\cdotE';

%% spectrum
[l1, pdf1, mu1, sigma1] = slj.Physics.pdf(lf, 200);

%% gauss
pdf2 = slj.Physics.gauss(size(lf)*5, mu1, sigma1);
[l2, pdf2, mu2, sigma2] = slj.Physics.pdf(pdf2, 200);

%%
figure;
plot(l1, pdf1, '-k', 'LineWidth', 2);
hold on 
plot(l2, pdf2, '-r', 'LineWidth', 2);
legend(name, 'Gaussian', 'Box', 'off');
xlabel(name);
ylabel('PDF');
ylim([1e-6, 0.1])
title(['t = ', num2str(tt)]);
set(gca, 'YScale', 'log');
set(gca, 'FontSize', 14);

%% 
cd(outdir);
% print('-dpng','-r300',['J.E_PDF_t', num2str(tt),'.png']);