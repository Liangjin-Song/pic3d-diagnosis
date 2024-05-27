% function avi_overview
%%
% @info: writen by Liangjin Song on 20220401
% @brief: plot the avi overview
%%
clear;
%% parameters
% input/output directory
indir='Z:\Simulation\Zhong\moon\run3';
outdir='Z:\Simulation\Zhong\moon\run3\out\range';
prm=slj.Parameters(indir,outdir);

tt=8;
name='Ne';
norm=prm.value.n0;

%%
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
lx=prm.value.lx;
ly=prm.value.lz;

cd(indir);
f=figure;
ss=prm.read('stream',tt);
fd=prm.read(name,tt);
% fd=fd.x;
slj.Plot.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
xlim([40,60]);
ylim([-5,5]);
cd(outdir);