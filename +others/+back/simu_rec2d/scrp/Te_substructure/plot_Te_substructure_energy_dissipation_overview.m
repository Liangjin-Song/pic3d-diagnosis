%% plot J dot (E + V cross B)
% writen by Liangjin Song on 20190603
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/Te_substructure/overview/';
tt=43;
di=40;
Lx=4800/di;
Ly=2400/di;
c=0.6;
n0=1304.33557;
vA=0.03;
qi=1;
qe=-1;

norm=n0*vA*vA;
nt=length(tt);
for t=1:nt
    cd(indir);
    stream=read_data('stream',tt(t));
    % ion
    vix=read_data('vxi',tt(t));
    viy=read_data('vyi',tt(t));
    viz=read_data('vzi',tt(t));
    ni=read_data('Densi',tt(t));
    % electron
    vex=read_data('vxe',tt(t));
    vey=read_data('vye',tt(t));
    vez=read_data('vze',tt(t));
    ne=read_data('Dense',tt(t));
    % field
    ex=read_data('Ex',tt(t));
    ey=read_data('Ey',tt(t));
    ez=read_data('Ez',tt(t));
    bx=read_data('Bx',tt(t));
    bx=bx/c;
    by=read_data('By',tt(t));
    by=by/c;
    bz=read_data('Bz',tt(t));
    bz=bz/c;

    % current density 
    [Jx,Jy,Jz]=calc_current_density(ni,ne,qi,qe,vix,viy,viz,vex,vey,vez);
    ed=calc_energy_dissipation(Jx,Jy,Jz,ex,ey,ez,vix,viy,viz,bx,by,bz);
    plot_overview(ed,stream,norm,Lx,Ly)
    xlim([70,110]);
    ylim([7,23]);
    cd(outdir)
    print('-r300','-dpng',['Energy_dissipation_t',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf)
end
