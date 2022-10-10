%% plot the ion density change at the front
% writen by Liangjin Song on 20191029
clear;
indir='/data/simulation/rec2d_M100SBg00Sx_ppn=1000/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx_ppn=1000/out/density/';
tt=60;
dt=0.5;
di=40;
ndx=4000;
ndy=2000;
Lx=ndx/di; Ly=ndy/di;
nt=length(tt);
grids=1;
wci=0.000750;
c=0.6;

for t=1:nt
    cd(indir);
    tm=tt(t);
    tp=tm-dt;
    tn=tm+dt;

    ss=read_data('stream',tm);

    vx=read_data('vxe',tm);
    vy=read_data('vye',tm);
    vz=read_data('vze',tm);

    n=read_data('Dense',tm);
    nn=read_data('Dense',tn);
    np=read_data('Dense',tp);

    nvx=vx.*n;
    nvy=vy.*n;
    nvz=vz.*n;

    dv=calc_divergence(nvx,nvy,nvz,grids);
    dn=(nn-np)*wci;
    to=dv+dn;

    plot_field(to,Lx,Ly,1);
    % color_range=[-0.2,0.2];
    color_range=caxis;
    hold on
    plot_stream(ss,Lx,Ly,40);
    caxis(color_range);

    xlim([Lx/2,Lx]);
    ylim([0,Ly/2]);
    cd(outdir);
end
