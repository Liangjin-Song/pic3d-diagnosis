%% create the avi file
%% parameters
indir='E:\Turbulence\run1\data';
outdir='E:\Turbulence\run1\out\avi';
prm=slj.Parameters(indir,outdir);

tt=0:125;
name='e';

%% create the avi file
cd(outdir);
v = VideoWriter([name, '_spectrum.avi']);
v.FrameRate = 5;
open(v);

%%
figure;
nt = length(tt);
for t = 1:nt
    cd(indir);
    %% read data
    fid = fopen(['spctrm', name, '_t', num2str(tt(t), '%06.2f'), '.bsd'], 'rb');
    fd = fread(fid, Inf, 'float');
    fclose(fid);
    %% plot figure
    x1 = fd(1);
    x2 = fd(2);
    xx = linspace(x1, x2, length(fd) - 2);
    plot(xx, log10(fd(3:end)), '-k', 'LineWidth', 2);
    xlim([-6, 2]);
    xticks(-6:2:2);
    xticklabels({'10^{-6}', '10^{-4}','10^{-2}','10^{0}','10^{2}'});
    ylim([-2, 7]);
    yticks(-2:3:7);
    yticklabels({'10^{-2}', '10^{1}','10^{4}','10^{7}'});
    xlabel('E [mc^2]');
    ylabel(['f_{', name, '}']);
    title(['t = ', num2str(tt(t), '%06.2f')]);
    set(gca, 'FontSize', 14);
    %% write the frame
    writeVideo(v, getframe(gcf));
end

%% close the video
close(v);
cd(outdir);