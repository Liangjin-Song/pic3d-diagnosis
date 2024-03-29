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

Pt = sum(Pb, 2);

%% figure
f1=figure;
plot(tt, Pb(:, 1), '-r', 'LineWidth', 2);
hold on
plot(tt, Pb(:, 2), '-g', 'LineWidth', 2);
plot(tt, Pb(:, 3), '-b', 'LineWidth', 2);
plot(tt, Pt, '-k', 'LineWidth', 2);
xlabel('\Omega_{ci}t');
ylabel('magnetic energy');
legend('x', 'y', 'z', 'sum');
set(gca, 'FontSize', 14);

%%
f2=figure;
dPb = (Pb(:,:) - Pb(1, :))/Pt(1);
plot(tt, dPb(:, 1), '-r', 'LineWidth', 2);
hold on
plot(tt, dPb(:, 2), '-g', 'LineWidth', 2);
plot(tt, dPb(:, 3), '-b', 'LineWidth', 2);
plot(tt, sum(dPb, 2), '-k', 'LineWidth', 2);
xlabel('\Omega_{ci}t');
ylabel('\Delta E_B');
legend('x', 'y', 'z', 'sum');
set(gca, 'FontSize', 14);

%%
cd(outdir);