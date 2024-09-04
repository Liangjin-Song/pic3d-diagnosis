%% plot the value at a point as the function of time
clear;
%% parameters
indir='Z:\Simulation\moon\run1.2\';
outdir='Z:\Simulation\moon\run1.2\out\';
prm = slj.Parameters(indir, outdir);

%% time and point
tt = 0:12;
px = 20;
py = 0;
pz = 0;

%% variable
name='E';
cmp = 'y';
% norm = prm.value.qi .* prm.value.n0 .* prm.value.vA;
norm = prm.value.vA;
% norm = prm.value.n0;
% norm = 1;
nt = length(tt);

%%
[~, ix] = min(abs(prm.value.lx - px));
[~, iy] = min(abs(prm.value.ly - py));
[~, iz] = min(abs(prm.value.lz - pz));
val = zeros(1, nt);
%%
for t=1:nt
    cd(indir);
    fd = prm.read(name, tt(t));
    if cmp == 'x'
        fd = fd.x;
    elseif cmp == 'y'
        fd = fd.y;
    elseif cmp == 'z'
        fd = fd.z;
    else
        fd = fd.value;
    end
    val(t) = mean(fd(iy+4, ix-4:ix+4, iz-4:iz+4), 'all');
    % val(t) = fd(iy, ix, iz);
end

%% figure
figure;
plot(tt, val/norm, '-k', 'LineWidth', 2);
xlabel('\Omega_{ci}t');
ylabel([name, cmp]);
set(gca, 'FontSize', 14);

cd(outdir);