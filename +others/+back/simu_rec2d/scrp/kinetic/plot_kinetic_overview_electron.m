%% plot kinetic energy overview 
% writen by Liangjin Song on 20190517 
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/kinetic/electron/overview/';
tt=0:0.5:100;
di=40;
ndx=4800;
ndy=2400;
mi=0.306670;
me=0.003067;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);
for t=1:nt
    cd(indir);
    m=me;
    n=read_data('Dense',tt(t));
    vx=read_data('vxe',tt(t));
    vy=read_data('vye',tt(t));
    vz=read_data('vze',tt(t));
    stream=read_data('stream',tt(t));
    K=calc_bulk_kinetic_energy(m,n,vx,vy,vz);
    plot_overview(K,stream,1,Lx,Ly);

    cd(outdir);
    print('-r300','-dpng',['electron_bulk_kinetic_energy_t',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);
end
