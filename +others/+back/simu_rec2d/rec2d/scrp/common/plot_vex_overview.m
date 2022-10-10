%% plot Bz overview 
% writen by Liangjin Song on 20190625 
clear;
indir='/data/simulation/rec2d_M100B02T02Bs6Bg10/data/';
outdir='/data/simulation/rec2d_M100B02T02Bs6Bg10/out/zhong/';
tt=50;
wci=0.0005;
di=34.64;
Lx=2400/di;
Ly=2400/di;
c=0.6;
vA=di*wci;
nt=length(tt);
for t=1:nt
    cd(indir);
    ss=read_data('stream',tt(t));
    bz=read_data('vex',tt(t));
    figure;
    plot_overview(bz,ss,c,Lx,Ly);
    cd(outdir);
    % print('-r300','-dpng',['vez_t',num2str(tt(t),'%06.2f'),'.png']);
    % close(gcf);
end
