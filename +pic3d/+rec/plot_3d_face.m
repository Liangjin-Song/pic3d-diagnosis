clear;
%% parameters
indir='Z:\Simulation\moon\run1.2\';
outdir='Z:\Simulation\moon\run1.2\out\';
prm = slj.Parameters(indir, outdir);

tt=0;
name='Ve';
cmp = 'y';
% norm = prm.value.qi .* prm.value.n0 .* prm.value.vA;
norm = prm.value.vA;
% norm = prm.value.n0;
% norm = 1;
nt = length(tt);

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
%     slj.Plot.field3d(fd./norm, prm.value.lx, prm.value.ly, prm.value.lz, ...
%         [prm.value.lx(1), prm.value.lx(end)], ...
%         [prm.value.ly(1), prm.value.ly(end)], ...
%         [prm.value.lz(1), prm.value.lz(end)], []);
    slj.Plot.field3d(fd./norm, prm.value.lx, prm.value.ly, prm.value.lz, ...
        [], ...
        [prm.value.ly(41), prm.value.ly(160)], ...
        [], []);

    zlim([prm.value.lz(1), prm.value.lz(end)]);
    xlabel('X [c/\omega_{pi}]');
    ylabel('Y [c/\omega_{pi}]');
    zlabel('Z [c/\omega_{pi}]');
    
    hold on
%     plot3([prm.value.lx(1), prm.value.lx(1)], [prm.value.ly(1), prm.value.ly(end)], [prm.value.lz(end), prm.value.lz(end)], '-k');
%     plot3([prm.value.lx(1), prm.value.lx(end)], [prm.value.ly(1), prm.value.ly(1)], [prm.value.lz(end), prm.value.lz(end)], '-k');
%     plot3([prm.value.lx(1), prm.value.lx(1)], [prm.value.ly(1), prm.value.ly(1)], [prm.value.lz(1), prm.value.lz(end)], '-k');
    title([name, cmp, ', \Omega_{ci} t = ', num2str(tt(t))]);
    set(gca, 'FontSize', 14);
    
%     xlim([prm.value.lx(1), prm.value.lx(end)]);
%     ylim([prm.value.ly(1), prm.value.ly(end)]);
%     zlim([prm.value.lz(1), prm.value.lz(end)]);
    
    
    cd(outdir);
%     print('-dpng', '-r300', [name, cmp, '_t', num2str(tt(t), '%06.2f'), '.png']);
%     close(f);
end