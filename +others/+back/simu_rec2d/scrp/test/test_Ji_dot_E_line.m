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
qi=1;
q=qi;

z0=15;
dirt=0;
norm=n0*vA*vA;

nt=length(tt);
for t=1:nt
    cd(indir);
    ex=read_data('Ex',tt(t));
    ey=read_data('Ey',tt(t));
    ez=read_data('Ez',tt(t));

    ne=read_data('Densi',tt(t));
    vx=read_data('vxi',tt(t));
    vy=read_data('vyi',tt(t));
    vz=read_data('vzi',tt(t));

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
    xrange=[104,112];
    figure;
    plot(lx,ljex,'r','LineWidth',lw); hold on
    plot(lx,ljey,'g','LineWidth',lw);
    plot(lx,ljez,'b','LineWidth',lw);
    plot(lx,lje,'k','LineWidth',lw); hold off
    xlabel('X[c/\omega_{pi}]');
    ylabel('Ji \cdot E');
    legend('Ji_x \cdot E_x','Ji_y \cdot E_y','Ji_z \cdot E_z','Ji \cdot E');
    xlim(xrange);
    cd(outdir);
end
