%% plot_current_density_overview.m
% writen by Liangjin Song on 20190604 
clear;
indir='/simu/Simulation/rec2d_B1.5T06Bs6Bg00/data/';
outdir='/simu/Simulation/rec2d_B1.5T06Bs6Bg00/out/di=23/Overview/Half/J/';
tt=90;
di=23;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
n0=90.71402;
vA=0.0138;
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

    %{
    plot_overview(jx,stream,norm,Lx,Ly)
    xlim([130,180]);
    ylim([15,40]);
    cd(outdir);
    print('-r300','-dpng',['jx_t',num2str(tt(t),'%06.2f')]);
    close(gcf);
    %}

    plot_overview(jy,stream,norm,Lx,Ly)
    xlim([130,180]);
    ylim([15,40]);
    cd(outdir);
    %{
    print('-r300','-dpng',['jy_t',num2str(tt(t),'%06.2f')]);
    close(gcf);

    plot_overview(jz,stream,norm,Lx,Ly)
    xlim([130,180]);
    ylim([15,40]);
    cd(outdir);
    print('-r300','-dpng',['jz_t',num2str(tt(t),'%06.2f')]);
    close(gcf);
    %}
end
