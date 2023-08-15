%% current sheet flapping in asymmetric reconnection
clear;
%% parameters
indir='Z:\ion_deceleration\case2';
outdir='C:\Users\Liangjin\Pictures\Asym\case2\out\Test';
prm = slj.Parameters(indir, outdir);

%% time
dt = 0.5;
tt = 0:dt:100;

%% the space
nt = length(tt);
cs = zeros(nt, prm.value.nx);

%% loop
for t = 1:nt
    %% read data
    B = prm.read('B', tt(t));
    %% current sheet position index
    [~, cs(t, :)] = min(abs(B.x), [], 1);
end

%% the current sheet position
pcs = prm.value.lz(cs);

%% plot position figure
figure;
[X, Y] = meshgrid(prm.value.lx, tt);
p=pcolor(X, Y, pcs);
shading flat;
p.FaceColor = 'interp';
colorbar;
xlabel('X [c/\omega_{pi}]');
ylabel('\Omega_{ci}t');
title('current sheet position');
set(gca, 'FontSize', 14);
cd(outdir);
print(gcf, '-dpng', 'cs_position.png');

%% plot velocity figure
vcs = (pcs(2:end, :) - pcs(1:end-1, :)) / dt;
figure;
[X, Y] = meshgrid(prm.value.lx, tt(2:end));
p = pcolor(X, Y, vcs);
colorbar;
shading flat;
p.FaceColor = 'interp';
xlabel('X [c/\omega_{pi}]');
ylabel('\Omega_{ci}t');
title('current sheet flapping velocity');
set(gca, 'FontSize', 14);
cd(outdir);
print(gcf, '-dpng', 'cs_velocity.png');