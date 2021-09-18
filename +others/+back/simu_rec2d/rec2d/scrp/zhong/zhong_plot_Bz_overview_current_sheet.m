%% plot Bz overview 
% writen by Liangjin Song on 20190625 
clear;
indir='/data/simulation/zhong/M100B01Bg05/data/';
outdir='/data/simulation/zhong/M100B01Bg05/out/';
tt=25;
wci=0.00075;
di=40;
ndy=1200;
Lx=1200/di;
Ly=1200/di;
c=0.6;
vA=di*wci;

yy=-Ly/2:Ly/ndy:Ly/2-Ly/ndy;

nt=length(tt);
for t=1:nt
    cd(indir);
    ss=read_datat('stream',tt(t));
    bz=read_datat('Bz',tt(t));
    bx=read_datat('Bx',tt(t));

    in0=get_current_sheet_index(bx,0);
    in1=get_current_sheet_index(bx,1);
    xx=1:600;

    figure;
    plot_overview(bz,ss,c,Lx,Ly); hold on
    plot(xx,yy(in0(:)),'-r');
    plot(xx,yy(in1(:)),'-r'); hold off
    cd(outdir);
    % print('-r300','-dpng',['vez_t',num2str(tt(t),'%06.2f'),'.png']);
    % close(gcf);
end
