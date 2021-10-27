% function plot_vector
clear;
%% parameters
indir='E:\Asym\Cold2\data';
outdir='E:\Asym\Cold2\out\Vector';
prm=slj.Parameters(indir,outdir);

tt=30;
name='h';

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
for t=1:nt
    %% read data
    cd(indir);
    B=prm.read('B',tt(t));
    norm=1;
    ss=prm.read('stream',tt(t));
    V=prm.read(['V',name],tt(t));
    slj.Plot.overview(B.y, ss, prm.value.lx, prm.value.lz, norm, extra);
    hold on
    slj.Plot.plot_vector(V.x,V.z,prm.value.Lx,prm.value.Lz,50,4,'r');
    title(['By, Vic, \Omega_{ci}t=',num2str(tt)]);
    cd(outdir);
    print('-dpng','-r300',['Vector_cold_ions_t',num2str(tt(t)),'_By.png']);
end