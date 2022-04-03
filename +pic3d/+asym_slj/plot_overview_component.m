% function avi_overview
%%
% @info: writen by Liangjin Song on 20220401
% @brief: plot the avi overview
%%
clear;
%% parameters
% input/output directory
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Ohm';
prm=slj.Parameters(indir,outdir);

tt=40;
name='Pe';
norm=1;

%%
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
lx=prm.value.lx;
ly=prm.value.lz;

cd(indir);
f=figure;
ss=prm.read('stream',tt);
fd=prm.read(name,tt);
fd=fd.xx;
slj.Plot.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
xlim([15,35]);
ylim([-5,5]);