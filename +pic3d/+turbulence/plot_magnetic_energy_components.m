%%
clear;
%%
%% parameters
indir='Y:\turbulence5.55';
outdir='C:\Users\Liangjin\Pictures\Turbulence\Energy';
prm=slj.Parameters(indir,outdir);

dt = 1;
tt=0:dt:240;


%%
nt = length(tt);
Pb = zeros(nt, 3);
for t=1:nt
    %% read data
    cd(indir);
    B = prm.read('B', tt(t));
    %%
    Pb(t, 1) = sum(B.x.^2 * prm.value.c.^2 * 0.5, 'all');
    Pb(t, 2) = sum(B.y.^2 * prm.value.c.^2 * 0.5, 'all');
    Pb(t, 3) = sum(B.z.^2 * prm.value.c.^2 * 0.5, 'all');
end

%% figure
figure;
plot(tt, Pb(:, 1), '-r', 'LineWidth', 2);
hold on
plot(tt, Pb(:, 2), '-g', 'LineWidth', 2);
plot(tt, Pb(:, 3), '-b', 'LineWidth', 2);
plot(tt, Pb(:,1) + Pb(:, 2) + Pb(:, 3), '-k', 'LineWidth', 2);
xlabel('\Omega_{ci}t');
ylabel('magnetic energy');
legend('x', 'y', 'z', 'sum');
set(gca, 'FontSize', 14);

%%
cd(outdir);