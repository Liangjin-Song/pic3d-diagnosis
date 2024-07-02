%% plot the energy of high energy particles
clear;
%% parameters
indir='E:\Turbulence\run1\data';
outdir='E:\Turbulence\run1\out\global';
prm = slj.Parameters(indir, outdir);

%% time
tt = 0:280;
spc = 'e';
top = [1, 5, 10, 15, 20, 50];
sty = {'-k', '-r', '-b', '-g', '--k', '--r'};
c = prm.value.c;

%% space
nt = length(tt);
no = length(top);
en = zeros(no, nt);

%% loop
for j = 1:no
for t = 1:nt
    %% read data
    cd(indir);
    ep = prm.read(['hest', spc], tt(t));
    %% obtain energy
    v2 = ep.value.vx.^2 + ep.value.vy.^2 + ep.value.vz.^2;
    ee = c ./ sqrt(c.^2 - v2) - 1;
    if length(ep.value.id) < top(j)
        en(j, t) = mean(ee, 'all');
    else
        ee = sort(ee, 'descend');
        en(j, t) = mean(ee(1:top(j)), 'all');
    end
end
end
%% figure
figure;
% cmap = colormap('hsv');
% tmap = linspace(min(top), max(top), length(cmap));
hold on
for j = 1:no
    plot(tt, en(j, :), sty{j}, 'LineWidth', 2);
end
% caxis([min(top), max(top)]);
% colorbar;
xlabel('t');
ylabel(['E_{', spc, '} [mc^2]']);
title('average energy');
legend('top 1', 'top 5', 'top 10', 'top 15', 'top 20', 'top 50', 'Box', 'off');
set(gca, 'FontSize', 14);

cd(outdir);
print('-dpng', '-r300', ['etop_', spc, '.png']);