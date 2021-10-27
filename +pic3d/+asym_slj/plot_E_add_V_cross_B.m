%% function plot_E_add_V_cross_B
clear;
%% parameters
% directory
indir='E:\Asym\Cold2\data';
outdir='E:\Asym\Cold2\out\Energy\Line';
prm=slj.Parameters(indir,outdir);
% time
tt=10;
% species
name='h';
% direction
dir='x';

%% figure property
extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

%% normalization
norm=prm.value.vA;

%% species information
if name == 'l'
    sfx='ih';
elseif name == 'h'
    sfx='ic';
elseif name == 'e'
    sfx = 'e';
else
    error('Parameters Error!');
end

%% read data
E=prm.read('E',tt);
B=prm.read('B',tt);
V=prm.read(['V',name],tt);
S=prm.read('stream',tt);

%% calculation
ED=V.cross(B);
ED=ED+E;

%% direction
if dir == 'x'
    ED=ED.x;
elseif dir == 'y'
    ED=ED.y;
elseif dir == 'z'
    ED=ED.z;
else
    error('Parameters Error!');
end

%% plot figure
figure;
slj.Plot.overview(ED, S, prm.value.lx, prm.value.lz, norm, extra);
title(['(E + V',sfx,'\times B)_',dir,', \Omega_{ci}t=',num2str(tt)]);
cd(outdir);
%% end