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
z0=12.5;

for t=1:nt
    cd(indir);
    tm=tt(t);
    tp=tm-dt;
    tn=tm+dt;

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

    [lto,lx]=get_line_data(to,Lx,Ly,z0,1,0);
    [ldv,~]=get_line_data(dv,Lx,Ly,z0,1,0);
    [ldn,~]=get_line_data(dn,Lx,Ly,z0,1,0);

    % plot(lx,ldv,'r','LineWidth',2); hold on
    % plot(lx,ldn,'b','LineWidth',2);
    plot(lx,lto,'k','LineWidth',2); % hold off
    % legend('\nabla \cdot (nv_e)','\partial ne /\partial t','sum');
    xlabel('X [c/\omega_{pi}]');
    ylabel('\partial ne /\partial t');

    cd(outdir);
end
