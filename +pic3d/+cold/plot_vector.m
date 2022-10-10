% function plot_vector
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Overview\vector';
prm=slj.Parameters(indir,outdir);

tt=40;
name='e';

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
for t=1:nt
    %% read data
    cd(indir);
    B=prm.read('B',tt(t));
    % N=prm.read(['N',name],tt(t));
    norm=prm.value.vA;
    ss=prm.read('stream',tt(t));
    V=prm.read(['V',name],tt(t));
    slj.Plot.overview(V.x, ss, prm.value.lx, prm.value.lz, norm, extra);
    hold on
    slj.Plot.plot_vector(V.x,V.z,prm.value.Lx,prm.value.Lz,100,4,'r');
    title(['Vex, Ve, \Omega_{ci}t=',num2str(tt)]);
%     cd(outdir);
%     print('-dpng','-r300',['Vector_cold_ions_t',num2str(tt(t)),'_By.png']);
end