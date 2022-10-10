%% plot Je dot E along the current sheet
% writen by Liangjin Song on 20191028
clear;
indir='/data/simulation/rec2d_M100SBg00Tie2/data/';
outdir='/data/simulation/rec2d_M100SBg00Tie2/out/je/';
tt=60;
c=0.6;
n0=964.28925;
wci=0.000750;
di=40;
Lx=4800/di;
Ly=2400/di;
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

    jx=q*(ne.*vx);
    jy=q*(ne.*vy);
    jz=q*(ne.*vz);

    jex=jx.*ex;
    jey=jy.*ey;
    jez=jz.*ez;

    [ljex,lx]=get_line_data(jex,Lx,Ly,z0,norm,dirt);
    [ljey,~]=get_line_data(jey,Lx,Ly,z0,norm,dirt);
    [ljez,~]=get_line_data(jez,Lx,Ly,z0,norm,dirt);
    lje=ljex+ljey+ljez;

    lw=2;
    figure;
    plot(lx,ljex,'r','LineWidth',lw); hold on
    plot(lx,ljey,'g','LineWidth',lw);
    plot(lx,ljez,'b','LineWidth',lw);
    plot(lx,lje,'k','LineWidth',lw); hold off
    legend('Je_x \cdot E_x','Je_y \cdot E_y','Je_z \cdot E_z','Je \cdot E');
    cd(outdir);
end
