%% plot Je dot E along the current sheet
% writen by Liangjin Song on 20191028
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/je/';
tt=45;
c=0.6;
n0=1304.33557;
wci=0.000750;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);
vA=di*wci;
qe=-1;
q=qe;

z0=15;
dirt=0;
norm=n0*vA*vA;

nt=length(tt);
for t=1:nt
    cd(indir);
    ex=read_data('Ex',tt(t));
    ey=read_data('Ey',tt(t));
    ez=read_data('Ez',tt(t));

    ne=read_data('Dense',tt(t));
    vx=read_data('vxe',tt(t));
    vy=read_data('vye',tt(t));
    vz=read_data('vze',tt(t));
    ss=read_data('stream',tt(t));

    jx=q*(ne.*vx);
    jy=q*(ne.*vy);
    jz=q*(ne.*vz);

    jex=jx.*ex;
    jey=jy.*ey;
    jez=jz.*ez;
    je=jex+jey+jez;

    % [ljex,lx]=get_line_data(jex,Lx,Ly,z0,norm,dirt);
    % [ljey,~]=get_line_data(jey,Lx,Ly,z0,norm,dirt);
    % [ljez,~]=get_line_data(jez,Lx,Ly,z0,norm,dirt);
    % lje=ljex+ljey+ljez;

    figure;
    plot_overview(je,ss,norm,Lx,Ly);
    cd(outdir);
end
