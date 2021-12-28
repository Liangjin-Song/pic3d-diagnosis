%% plot Bz overview 
% writen by Liangjin Song on 20190625 
% clear;
indir='E:\';
outdir='E:\';
tt=85;
di=40;
Lx=4800/di;
Ly=2400/di;
c=0.6;
nt=length(tt);
for t=1:nt
    cd(indir);
    ss=read_data('stream',tt(t));
    bz=read_data('Bz',tt(t));
    figure;
    plot_overview(bx,ss,c,Lx,Ly);
    cd(outdir);
    % print('-r300','-dpng',['vez_t',num2str(tt(t),'%06.2f'),'.png']);
    % close(gcf);
end
