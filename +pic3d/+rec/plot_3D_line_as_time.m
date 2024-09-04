%% plot the line as the function of time
clear;
%% parameters
indir='Z:\Simulation\moon\run1.2\';
outdir='Z:\Simulation\moon\run1.2\out\';
prm = slj.Parameters(indir, outdir);

%% time
tt = 0:12;

%% variable
name='E';
cmp = 'y';
% norm = prm.value.qi .* prm.value.n0 .* prm.value.vA;
norm = prm.value.vA;
% norm = prm.value.n0;
% norm = 1;
nt = length(tt);
val = zeros(nt, prm.value.ny);

%%
for t = 1:nt
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
    
    val(t, :) = fd(:, prm.value.nx/2, prm.value.nz/2);
end

%%
figure;
slj.Plot.field2d(val/norm, prm.value.ly, tt, []);
xlabel('Y [c/\omega_{pi}]');
ylabel('\Omega_{ci}t');
set(gca, 'FontSize', 14);
cd(outdir)