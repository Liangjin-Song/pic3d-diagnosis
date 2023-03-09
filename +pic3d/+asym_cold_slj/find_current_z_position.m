%% find the current position in z-direction
% writen by Liangjin Song on 20230308
%%
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);

%% time
tt = 50;

%% space
nt = length(tt);
pz = zeros(nt, prm.value.nx);

%% loop
for t = 1:nt
    %% magnetic field
    B = prm.read('B', tt(t));
    B = B.x;
    %% the position of minimum value
    [~, tmp] = min(abs(B), [], 1);
    pz(t, :) = tmp(:);
end
cd(outdir);