%% plot energy spectrum
indir='E:\Turbulence\run1\data';
outdir='E:\Turbulence\run1\out\global';
prm=slj.Parameters(indir,outdir);

tt = [0, 20, 100, 170];
sty = {'-k', '-r', '-g', '--b'};
spc = 'e';

%% set figure
figure;
hold on;
cmap = colormap('jet');
tmap = linspace(min(tt), max(tt), length(cmap));

nt = length(tt);
for t = 1:nt
    %% read data
    cd(indir);
    fid = fopen(['spctrm', spc, '_t', num2str(tt(t), '%06.2f'), '.bsd'], 'rb');
    fd = fread(fid, Inf, 'float');
    fclose(fid);
    %% plot figure
    x1 = fd(1);
    x2 = fd(2);
    xx = linspace(x1, x2, length(fd) - 2);
    % plot(xx, log10(fd(3:end)), '-', 'LineWidth', 2, 'Color', interp1(tmap, cmap, tt(t)));
    plot(xx, log10(fd(3:end)), sty{t}, 'LineWidth', 2);
end

%% set figure
% caxis([min(tt), max(tt)]);
% colorbar()
xlim([-6, 2]);
xticks(-6:2:2);
xticklabels({'10^{-6}', '10^{-4}','10^{-2}','10^{0}','10^{2}'});
ylim([-2, 7]);
yticks(-2:3:7);
yticklabels({'10^{-2}', '10^{1}','10^{4}','10^{7}'});
xlabel('E [mc^2]');
ylabel(['f_{', spc, '}']);
set(gca, 'FontSize', 14);

%% save
cd(outdir);
print('-dpng', '-r300', ['spctrm', spc, '.png']);