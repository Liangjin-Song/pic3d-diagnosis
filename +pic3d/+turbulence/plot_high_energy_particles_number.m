%% plot the high energy particle number
clear;
%% parameters
indir='E:\Turbulence\run1\data';
outdir='E:\Turbulence\run1\out\global';
prm = slj.Parameters(indir, outdir);

%% 
tt = 1:180;
spc = 'e';

%%
nt = length(tt);
np = zeros(1, nt);

for t = 1:nt
    eh = prm.read(['hest', spc], tt(t));
    np(t) = length(eh.value.id);
end

%%
figure;
plot(tt, np, '-k', 'LineWidth', 2);
xlabel('t');
ylabel('Number of particles');
set(gca, 'FontSize', 14);

cd(outdir);
print('-dpng', '-r300', ['np_', spc, '.png']);