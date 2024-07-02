%% plot the particle of highest energy particles
clear;
%% parameters
indir='E:\Turbulence\run1\data';
outdir='E:\Turbulence\run1\out\kinetic\trajectory\1264632577';
prm = slj.Parameters(indir, outdir);

%% time
tt = 0:180;
spc = 'e';
c = prm.value.c;
id = uint64(1264632577);

%% space
nt = length(tt);
info = zeros(nt, 7);

%% loop
for t = 1:nt
    %% read data
    cd(indir);
    ep = prm.read(['hest', spc], tt(t));
    %% obtain the particle information
    info(t, 1) = tt(t);
    if ~ismember(id, ep.value.id)
        continue;
    end
    ix = find(ep.value.id == id);
    info(t, 2) = ep.value.rx(ix);
    info(t, 3) = ep.value.ry(ix);
    info(t, 4) = ep.value.rz(ix);
    info(t, 5) = ep.value.vx(ix);
    info(t, 6) = ep.value.vy(ix);
    info(t, 7) = ep.value.vz(ix);
end

%% particle energy
en = info(:, 5).^2 + info(:, 6).^2 + info(:, 7).^2;
en = prm.value.c ./ sqrt(prm.value.c.^2 - en) - 1;

%% plot the particle energy as time
f1 = figure;
plot(info(:, 1), en, 'k-', 'LineWidth', 2);
xlabel('\Omega_{ci}t');
ylabel('E [mc^2]');
title(['id = ', num2str(id)]);
set(gca, 'FontSize', 14);

%% plot the particle trajectory in x-z plane
f2 = figure;
cd(outdir);
v = VideoWriter(['traj_id', num2str(id), '.avi']);
v.FrameRate = 5;
open(v);

cxs = [-4, 4];
norm = prm.value.qi .* prm.value.n0 * prm.value.vA;
extra.xlabel = 'X [c/\omega_{pi}]';
extra.ylabel = 'Z [c/\omega_{pi}]';

t0 = 61;
for t = t0:nt
    %% read data
    cd(indir);
    J = prm.read('J', tt(t));
    ss = prm.read('stream', tt(t));
    %% plot
    slj.Plot.overview(J.y, ss, prm.value.lx, prm.value.lz, norm, extra);
    title(['t = ', num2str(tt(t)), ' \Omega_{ci}^{-1}']);
    hold on
    plot(info(t0:t, 2), info(t0:t, 4), '-r', 'LineWidth', 2);
    hold off
    caxis([-4, 4]);
    %% write the frame
    writeVideo(v, getframe(gcf));
end
close(v);

%%
cd(outdir);
% print(f1, '-dpng', '-r300', 'energy_time.png');