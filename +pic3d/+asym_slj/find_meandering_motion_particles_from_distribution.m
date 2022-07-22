%% find the meandering motion particles from distribution function
clear;
%% parameters
indir='E:\Asym\cold2v2\data';
outdir='E:\Asym\cold2v2\out\Kinetic';
prm=slj.Parameters(indir,outdir);

%% construct the distribution function name
tt = 20:30;
prefix = 'PVh_';
postfix = '_x800-1200_y418-661_z0-1';

%% the period
pdt = 1/prm.value.wci;
nt = length(tt);

%% the space range
down.x=[23,27];
down.z=[-2,-0.5];
down.y=[-10,10];
up.x=down.x;
up.z=[2,5];
up.y=down.y;

upid=[];
downid=[];

for t = 1:nt
    name = [prefix, 'ts', num2str(tt(t) * pdt), postfix];
    dist = prm.read(name);
    mmatdowns=dist.subposition(down.x,down.y,down.z);
    ups=dist.subposition(up.x,up.y,up.z);
    upid = union(upid, ups.value.id);
    downid = union(downid, downs.value.id);
end
cid = intersect(upid, downid, 'stable');