%% plot the X-line number as the function of time
clear;

%% parameters
indir='E:\Turbulence\9.2\data';
outdir='E:\Turbulence\9.2\out\static';
prm=slj.Parameters(indir,outdir);

tt=0:221;
nt = length(tt);

%% the number of X-line
nX = zeros(nt, 1);

for t = 1:nt
    cd(indir);
    B = prm.read('B', tt(t));
    [icol, irow, ~] = slj.Physics.findXline_by_Hessian(B, prm);
    nX(t) = length(icol);
end

%% plot
cd(outdir);
figure;
plot(tt, nX, '-k', 'LineWidth', 2);
xlabel('\Omega_{ci}t');
ylabel('Number of X-line');
set(gca, 'FontSize', 14);