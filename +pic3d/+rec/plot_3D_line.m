clear;
%% parameters
indir='Z:\Simulation\moon\run1.2\';
outdir='Z:\Simulation\moon\run1.2\out\';
prm = slj.Parameters(indir, outdir);

tt=10;
name='J';
cmp = 'y';
norm = prm.value.qi .* prm.value.n0 .* prm.value.vA;
% norm = prm.value.vA;
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
        fd = fd.x;
    elseif cmp == 'y'
        fd = fd.y;
    elseif cmp == 'z'
        fd = fd.z;
    else
        fd = fd.value;
    end

    lfd = fd(ny/2, nx/2, :)./norm;
    % lfd = mean(mean(lfd, 1), 2);
    % lfd = mean(lfd, 3);
    plot(prm.value.lz, lfd(:), '-k', 'LineWidth', 2);
    xlabel('Z [c/\omega_{pi}]');
    ylabel('Jy');
    set(gca, 'FontSize', 14);
    cd(outdir);
%     print('-dpng', '-r300', [name, cmp, '_t', num2str(tt(t), '%06.2f'), '.png']);
%     close(f);
end