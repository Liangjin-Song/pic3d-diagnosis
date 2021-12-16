% function plot_energy_conversion_profiles
%% plot the cold ions density profiles
% clear;
%% parameters 
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out';
name='e';
tt=30;
xz=0;
dir=0;
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
%% read data
prm=slj.Parameters(indir,outdir);
% norm=prm.value.n0*prm.value.vA*prm.value.vA;
norm=prm.value.vA*prm.value.vA;
% N=prm.read(['N',name],tt);
V=prm.read(['V',name],tt);
E=prm.read('E',tt);
ss=prm.read('stream',tt);

%% calculation
sig=1;
if strcmp(name,'e') || strcmp(name,'he')
    sig=-1;
end

JE=V.dot(E);
% JE=JE*N;
JE=JE.filter2d(0);
JE=slj.Scalar(sig.*JE.value);
f=figure;
slj.Plot.overview(JE,ss,prm.value.lx,prm.value.lz,norm,extra);
title(['Je\cdot E/Ne, \Omega_{ci}t=',num2str(tt)]);