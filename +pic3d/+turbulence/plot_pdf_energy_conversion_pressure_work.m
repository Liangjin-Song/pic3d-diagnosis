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
Pi = prm.read('Pi', tt);
Pe = prm.read('Pe', tt);
Vi = prm.read('Vi', tt);
Ve = prm.read('Ve', tt);

%% calculate
divPV=Pi.divergence(prm);
divPVi = divPV.dot(Vi);
divPV=Pe.divergence(prm);
divPVe = divPV.dot(Ve);
fd = divPVi.value + divPVe.value;

lf = fd.value(:) / norm;
name = '[(\nabla \cdot P) \cdot V]_{i+e}';

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
% print('-dpng','-r300',['total_pressure_work_PDF_t', num2str(tt),'.png']);
