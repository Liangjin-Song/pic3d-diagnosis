% function plot_vector
clear;
%% parameters
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\partial_t\region5';
prm=slj.Parameters(indir,outdir);

tt=26;
name='h';
norm=1;

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
for t=1:nt
    %% read data
    cd(indir);
    N=prm.read('Nh',tt(t));
    V=prm.read(['V',name],tt(t));
    ss=prm.read('stream',tt(t));
    NV.x = N.value.*V.x;
    NV.y = N.value.*V.y;
    NV.z = N.value.*V.z;
    slj.Plot.overview(NV.z, ss, prm.value.lx, prm.value.lz, norm, extra);
    
    cd(outdir);
%     print('-dpng','-r300',['Vector_cold_ions_t',num2str(tt(t)),'_Nic.png']);
end