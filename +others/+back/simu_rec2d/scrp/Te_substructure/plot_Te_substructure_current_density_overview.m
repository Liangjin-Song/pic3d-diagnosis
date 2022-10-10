%% plot_current_density_overview.m
% writen by Liangjin Song on 20190604 
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/Te_substructure/overview/';
tt=43;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
vA=0.03;
n0=1304.33557;
nt=length(tt);
norm=n0*vA;
for t=1:nt
    cd(indir)
    stream=read_data('stream',tt(t));
    ni=read_data('Densi',tt(t));
    ne=read_data('Dense',tt(t));

    vix=read_data('vxi',tt(t));
    vex=read_data('vxe',tt(t));

    viy=read_data('vyi',tt(t));
    vey=read_data('vye',tt(t));

    viz=read_data('vzi',tt(t));
    vez=read_data('vze',tt(t));

    % current density 
    [jx,jy,jz]=calc_current_density(ni,ne,1,-1,vix,viy,viz,vex,vey,vez);

    plot_overview(jx,stream,norm,Lx,Ly)
    xlim([70,110]);
    ylim([7,23]);
    cd(outdir);
    print('-r300','-dpng',['jx_t',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);

    plot_overview(jy,stream,norm,Lx,Ly)
    xlim([70,110]);
    ylim([7,23]);
    cd(outdir);
    print('-r300','-dpng',['jy_t',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);

    plot_overview(jz,stream,norm,Lx,Ly)
    xlim([70,110]);
    ylim([7,23]);
    cd(outdir);
    print('-r300','-dpng',['jz_t',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);
end
