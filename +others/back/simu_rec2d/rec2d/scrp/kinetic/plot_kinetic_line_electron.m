%% plot thermal energy density overview 
% writen by Liangjin Song on 20190517 
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/line/kinetic/electron/X/';
tt=0:0.5:100;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
me=0.001667;
nt=length(tt);
z0=15;
c=0.6;
for t=1:nt
    cd(indir);
    m=me;
    n=read_data('Dense',tt(t));
    vx=read_data('vxe',tt(t));
    vy=read_data('vye',tt(t));
    vz=read_data('vze',tt(t));
    bz=read_data('Bz',tt(t));
    K=calc_bulk_kinetic_energy(m,n,vx,vy,vz);
    [lk,lx]=get_line_data(K,Lx,Ly,z0,1,0);
    [lbz,~]=get_line_data(bz,Lx,Ly,z0,c,0);

    xrange=[0,Lx];
    ylab='electron bulk kinetic energy';
    plotyy_with_bz(lk,lbz,lx,ylab,xrange);

    cd(outdir);
    print('-r200','-dpng',['electron_bulk_kinetic_energy_density_t',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);
end
