clear;
%% parameters
% directory
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Wave';
prm=slj.Parameters(indir,outdir);
name = 'e';
norm = prm.value.n0*prm.value.vA*prm.value.vA*prm.value.di*prm.value.di;
%% integral region
dy = 20;

%% load the position index of the separatrix in z direction
cd(outdir);
load('z_position_along_separatrix.mat');
pt = 20:0.1:40;

%%
nt = length(pt);
rate = zeros(nt, 1);
for t = 1:nt
    %% read data
    cd(indir);
    E=prm.read('E',pt(t));
    V=prm.read(['V',name],pt(t));
    N=prm.read(['N',name],pt(t));
    
    %% calculation
    JE = E.dot(V);
    JE = JE.value.*N.value;
    if name == 'e'
        JE = -JE;
    end
    %% integral region
    if pt(t) < 30
        x1 = 30;
    else
        x1 = 35;
    end
    [~, ix1] = min(abs(prm.value.lx - x1));
    [~, ix2] = min(abs(prm.value.lx - 50));
    %% integral
    rate(t) = sum(JE(pz(t)-dy:pz(t)+dy, ix1:ix2), 'all');
end
rate0 = rate;
%%
cd(outdir);
figure;
rate=slj.Physics.filter1d(rate0, 2);
plot(pt, rate/norm, '-k', 'LineWidth', 2);
xlabel('\Omega_{ci}t');
ylabel(['J', name, '\cdot E']);
set(gca, 'FontSize', 14);