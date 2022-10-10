%% get common particles id from distribution function
% clear;
%% parameters
indir='E:\Asym\cold2v2\data';
outdir='E:\Asym\cold2v2\out\Kinetic';
prm=slj.Parameters(indir,outdir);

%% construct the distribution function name
tt = 0:60;
prefix = 'PVh_';
postfix = '_x800-1200_y418-661_z0-1';

%% the period
pdt = 1/prm.value.wci;
nt = length(tt);

%% for the first distribution function
% name = [prefix, 'ts', num2str(tt(1) * pdt), postfix];
% dist = prm.read(name);
% cid = dist.value.id;


for t = 1:nt
    %% distribution function name
    name = [prefix, 'ts', num2str(tt(t) * pdt), postfix];
    dist = prm.read(name);
    id = dist.value.id;
    cid = intersect(cid, id,'stable');
end