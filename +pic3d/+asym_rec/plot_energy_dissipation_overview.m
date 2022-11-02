% function plot_overview
%%
% @info: writen by Liangjin Song on 20210706
% @brief: plot the overview for the harris reconnection model
%%
clear;
%% parameters
% input/output directory
indir='E:\Asym\zhong\case1\data';
outdir='E:\Asym\zhong\case1\out\Overview';
prm=slj.Parameters(indir,outdir);
% time
tt=0:100;
nt=length(tt);

Visible = 'off';

norm = prm.value.qi*prm.value.nis*prm.value.vA*prm.value.vA;
extra = [];

%% loop
for t = 1:nt
%% read data
ss=prm.read('stream',tt(t));
J = prm.read('J', tt(t));
E = prm.read('E', tt(t));
Ve = prm.read('Ve', tt(t));
B = prm.read('B', tt(t));

%% calculation
JE = Ve.cross(B);
JE = E + JE;
JE = J.dot(JE);

%% figure
f = figure('Visible', Visible);
slj.Plot.overview(JE, ss, prm.value.lx, prm.value.lz, norm, extra);
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
ylim([-25, 25]);
caxis([-2,2]);
title(['J\cdot (E + Ve \times B),  \Omega_{ci}t = ', num2str(tt(t))]);
cd(outdir);
print(f,'-dpng', '-r300', ['J.(E+VexB)_t', num2str(tt(t), '%06.2f'), '.png']);
close(f);
end