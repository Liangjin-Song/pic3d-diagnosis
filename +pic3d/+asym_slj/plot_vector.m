% function plot_vector
clear;
%% parameters
indir='E:\Asym\cb1\data';
outdir='E:\Asym\cb1\out\Vector';
prm=slj.Parameters(indir,outdir);

tt=20;
name='h';

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
for t=1:nt
    %% read data
    cd(indir);
    B=prm.read('B',tt(t));
    N=prm.read(['N',name],tt(t));
    norm=1;
    ss=prm.read('stream',tt(t));
    V=prm.read(['V',name],tt(t));
    slj.Plot.overview(N, ss, prm.value.lx, prm.value.lz, norm, extra);
    hold on
    slj.Plot.plot_vector(V.x,V.z,prm.value.Lx,prm.value.Lz,50,4,'r');
    title(['Nic, Vic, \Omega_{ci}t=',num2str(tt)]);
    cd(outdir);
    print('-dpng','-r300',['Vector_cold_ions_t',num2str(tt(t)),'_By.png']);
end