%% plot the particle of highest energy particles
clear;
%% parameters
indir='E:\Turbulence\run1\data';
outdir='E:\Turbulence\run1\out\global';
prm = slj.Parameters(indir, outdir);

%% time
tt = 0:180;
spc = 'e';
top = 1;
c = prm.value.c;

%% space
nt = length(tt);
id = uint64(zeros(top, nt));

%% loop
for t = 1:nt
    %% read data
    cd(indir);
    ep = prm.read(['hest', spc], tt(t));
    %% obtain energy
    v2 = ep.value.vx.^2 + ep.value.vy.^2 + ep.value.vz.^2;
    ee = c ./ sqrt(c.^2 - v2) - 1;
    %% obtain the particle id
    if length(ee) < top
        id(1:length(ee), t) = ep.value.id;
    else
        [~, p] = maxk(ee, top);
        id(:, t) = ep.value.id(p);
    end
end
