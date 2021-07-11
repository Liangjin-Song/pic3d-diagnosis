%% plot thermal energy density overview 
% writen by Liangjin Song on 20190517 
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/thermal/ion/X/';
tt=0:0.5:100;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);
z0=15;
c=0.6;
for t=1:nt
    cd(indir);
    p=read_data('presi',tt(t));
    bz=read_data('Bz',tt(t));
    [pxx,~,~,pyy,~,pzz]=reshap_pressure(p,ndy,ndx);
    U=calc_thermal_energy(pxx,pyy,pzz);
    [lue,lx]=get_line_data(U,Lx,Ly,z0,1,0);
    [lbz,~]=get_line_data(bz,Lx,Ly,z0,c,0);

    xrange=[0,Lx];
    ylab='ion thermal energy';
    plotyy_with_bz(lue,lbz,lx,ylab,xrange);

    cd(outdir);
    print('-r200','-dpng',['ion_thermal_energy_density_t',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);
end
