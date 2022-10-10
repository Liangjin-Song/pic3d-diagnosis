%% plot magnetic field slash
% writen by Liangjin Song on 20190906
clear;
indir='/data/simulation/self25/data/';
outdir='/data/simulation/self25/out/slash/';
tt=25;
c=0.6;
vA=0.03;
di=40;
ndx=2400;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);

nx0=1800;
ny0=1800;
k=1;

for t=1:nt
    cd(indir);
    vex=read_data('vxe',tt(t));
    vex=vex/vA;
    vey=read_data('vye',tt(t));
    vey=vey/vA;
    vez=read_data('vze',tt(t));
    vez=vez/vA;

    [svx,sx,sy]=get_line_by_k(vex,nx0,ny0,k);
    [svy,sx,sy]=get_line_by_k(vey,nx0,ny0,k);
    [svz,sx,sy]=get_line_by_k(vez,nx0,ny0,k);

    figure;
    plot(sx,svx,'r','LineWidth',2); hold on
    plot(sx,svy,'g','LineWidth',2);
    plot(sx,svz,'b','LineWidth',2); hold off
    ylabel('ve');
    legend('vex','vey','vez');
    cd(outdir);
    print('-r300','-dpng',['B_slash_k=',num2str(k),'_t',num2str(tt(t),'%06.2f'),'.png']);
end
