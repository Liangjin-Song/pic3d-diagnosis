% function avi_overview
%%
% @info: writen by Liangjin Song on 20220401
% @brief: plot the avi overview
%%
clear;
%% parameters
% input/output directory
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Wave';
prm=slj.Parameters(indir,outdir);

tt=28;
name='E';
norm=prm.value.vA;

%%
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
lx=prm.value.lx;
ly=prm.value.lz;

cd(indir);
f=figure;
ss=prm.read('stream',tt);
fd=prm.read(name,tt);
fd=fd.x;
slj.Plot.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
xlim([0,50]);
ylim([-10,10]);
cd(outdir);