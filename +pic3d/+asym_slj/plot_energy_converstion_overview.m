% function plot_energy_converstion_overview
clear;
%% parameters
indir='E:\Asym\NCold\data';
outdir='E:\Asym\Cold\out\Analysis\Electron';
prm=slj.Parameters(indir,outdir);

tt=100;
name='e';

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

norm=prm.value.n0*prm.value.vA*prm.value.vA;

for t=1:nt
    %% read data
    E=prm.read('E',tt(t));
    V=prm.read(['V',name],tt(t));
    N=prm.read(['N',name],tt(t));
    ss=prm.read('stream',tt(t));
    %% calculation
    JE=E.dot(V);
    JE=JE*N;
    slj.Plot.overview(-JE.value, ss, prm.value.lx, prm.value.lz, norm, extra);
    cd(outdir);
    print('-dpng','-r300',['Je_dot_E_t',num2str(tt(t)),'.png']);
    close(gcf);
end