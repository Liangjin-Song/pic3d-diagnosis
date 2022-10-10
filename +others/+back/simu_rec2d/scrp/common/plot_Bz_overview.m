%% plot Bz overview 
% writen by Liangjin Song on 20190625 
% clear;
indir='E:\Simulation\rec2d_M100SBg00Sx\data';
outdir='E:\Simulation\rec2d_M100SBg00Sx\out\Overview';
tt=40;
di=40;
Lx=4800/di;
Ly=2400/di;
c=0.6;
vA=0.03;
nt=length(tt);
for t=1:nt
    cd(indir);
    ss=read_data('stream',tt(t));
    bz=read_data('Ey',tt(t));
    norm=vA;
    figure;
    plot_overview(bz,ss,norm,Lx,Ly);
    cd(outdir);
    % print('-r300','-dpng',['vez_t',num2str(tt(t),'%06.2f'),'.png']);
    % close(gcf);
end
