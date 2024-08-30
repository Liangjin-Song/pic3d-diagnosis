clear;
%% parameters
indir='Z:\Simulation\moon\run1.2\';
outdir='Z:\Simulation\moon\run1.2\out\';
prm = slj.Parameters(indir, outdir);

tt=10;
name='E';
cmp = 'z';
% norm = prm.value.qi .* prm.value.n0 .* prm.value.vA;
norm = prm.value.vA;
% norm = prm.value.n0;
% norm = 1;
nt = length(tt);

nx = prm.value.nx;
ny = prm.value.ny;
nz = prm.value.nz;


%% read data
for t=1:nt
    cd(indir);
    fd = prm.read(name, tt(t));
    
    %% plot figure
    f = figure;
    if cmp == 'x'
        fd = fd.x/norm;
    elseif cmp == 'y'
        fd = fd.y/norm;
    elseif cmp == 'z'
        fd = fd.z/norm;
    else
        fd = fd.value/norm;
    end

    lfd = fd(ny/2, :, :);
    % lfd = mean(mean(lfd, 1), 2);
    lfd = mean(lfd, 3);
    plot(prm.value.ly, lfd(:), '-k', 'LineWidth', 2);
    xlabel('X [c/\omega_{pi}]');
    ylabel('Ez');
    set(gca, 'FontSize', 14);
    cd(outdir);
%     print('-dpng', '-r300', [name, cmp, '_t', num2str(tt(t), '%06.2f'), '.png']);
%     close(f);
end