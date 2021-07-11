%% plot Bz overview 
% writen by Liangjin Song on 20190625 
clear;
indir='/data/simulation/zhong/M100B01Bg05/data/';
outdir='/data/simulation/zhong/M100B01Bg05/out/';
tt=25;
wci=0.00075;
di=40;
Lx=1200/di;
Ly=1200/di;
c=0.6;
vA=di*wci;
nt=length(tt);
for t=1:nt
    cd(indir);
    ss=read_datat('stream',tt(t));
    bx=read_datat('Bx',tt(t));
    figure;
    plot_overview(bx,ss,c,Lx,Ly);
    cd(outdir);
    % print('-r300','-dpng',['vez_t',num2str(tt(t),'%06.2f'),'.png']);
    % close(gcf);
end
