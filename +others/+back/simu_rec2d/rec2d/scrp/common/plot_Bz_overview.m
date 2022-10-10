%% plot Bz overview 
% writen by Liangjin Song on 20190625 
clear;
indir='/data/simulation/M25SBg00Sx_low_vte/data';
outdir='/data/simulation/M25SBg00Sx_low_vte/out/overview/B/Bz';
tt=78;
di=30;
Lx=6000/di;
Ly=3000/di;
c=0.6;
nt=length(tt);
for t=1:nt
    cd(indir);
    ss=read_data('stream',tt(t));
    bz=read_data('Bz',tt(t));
    figure;
    plot_overview(bz,ss,c,Lx,Ly);
    cd(outdir);
    % print('-r300','-dpng',['vez_t',num2str(tt(t),'%06.2f'),'.png']);
    % close(gcf);
end
