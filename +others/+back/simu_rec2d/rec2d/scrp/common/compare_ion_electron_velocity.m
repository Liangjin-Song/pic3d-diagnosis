%% plot magnetic field slash
% writen by Liangjin Song on 20190906
clear;
indir='/data/simulation/rec2d_M100SBg00Tie2/data/';
outdir='/data/simulation/rec2d_M100SBg00Tie2/out/je/';
tt=60;
c=0.6;
n0=964.28925;
wci=0.000750;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);
vA=di*wci;

z0=15;
dirt=0;

for t=1:nt
    cd(indir);
    vix=read_data('vxi',tt(t));
    viy=read_data('vyi',tt(t));
    viz=read_data('vzi',tt(t));

    vex=read_data('vxe',tt(t));
    vey=read_data('vye',tt(t));
    vez=read_data('vze',tt(t));

    [lvix,lx]=get_line_data(vix,Lx,Ly,z0,vA,dirt);
    [lviy,~]=get_line_data(viy,Lx,Ly,z0,vA,dirt);
    [lviz,~]=get_line_data(viz,Lx,Ly,z0,vA,dirt);

    [lvex,~]=get_line_data(vex,Lx,Ly,z0,vA,dirt);
    [lvey,~]=get_line_data(vey,Lx,Ly,z0,vA,dirt);
    [lvez,~]=get_line_data(vez,Lx,Ly,z0,vA,dirt);

    figure;
    lw=2;
    subplot(2,1,1)
    plot(lx,lvix,'r','LineWidth',lw); hold on
    plot(lx,lvex,'k','LineWidth',lw);
    legend('vix','vex');

    subplot(2,1,2)
    plot(lx,lviy,'r','LineWidth',lw); hold on
    plot(lx,lvey,'k','LineWidth',lw);
    legend('viy','vey');

    cd(outdir);
    % print('-r300','-dpng',['B_slash_k=',num2str(k),'_t',num2str(tt(t),'%06.2f'),'.png']);
end
