%% plot the X-line number as the function of time
clear;

%% parameters
indir='E:\Turbulence\9.2\data';
outdir='E:\Turbulence\9.2\out\static\data\X-line_index';
prm=slj.Parameters(indir,outdir);

tt=0:221;
nt = length(tt);

%% the number of X-line

for t = 1:nt
    cd(indir);
    B = prm.read('B', tt(t));
    [icol, irow, ~] = slj.Physics.findXline_by_Hessian(B, prm);
    cd(outdir);
    save(['X-line_index_t', num2str(tt(t), '%06.2f.mat')], 'icol', 'irow');
end
