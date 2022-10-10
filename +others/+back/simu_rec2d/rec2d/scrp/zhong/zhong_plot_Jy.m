%% plot J dot Ee' and the cut line
% writen by Liangjin Song on 20191026
clear;
indir='/data/simulation/zhong/M100B01Bg05/data/';
outdir='/data/simulation/zhong/M100B01Bg05/out/';
tt=25;
c=0.6;
wci=0.0007499;
di=32.66;
Lx=1200/di;
Ly=1200/di;
vA=di*wci;
qi=1;
qe=-qi;
n0=225;
% norm=n0*vA*vA;
norm=n0*vA;
nt=length(tt);

for t=1:nt
    cd(indir);
    
    % current density
    % ion
    vix=read_datat('vxi',tt(t));
    viy=read_datat('vyi',tt(t));
    viz=read_datat('vzi',tt(t));
    ni=read_datat('Densi',tt(t));

    % electron
    vex=read_datat('vxe',tt(t));
    vey=read_datat('vye',tt(t));
    vez=read_datat('vze',tt(t));
    ne=read_datat('Dense',tt(t));

    [jx,jy,jz]=calc_current_density(ni,ne,qi,qe,vix,viy,viz,vex,vey,vez);

    ex=read_datat('Ex',tt(t));
    ey=read_datat('Ey',tt(t));
    ez=read_datat('Ez',tt(t));

    bx=read_datat('Bx',tt(t));
    bx=bx/c;
    by=read_datat('By',tt(t));
    by=by/c;
    bz=read_datat('Bz',tt(t));
    bz=bz/c;

    ss=read_datat('stream',tt(t));

    ed=calc_energy_dissipation(jx,jy,jz,ex,ey,ez,vex,vey,vez,bx,by,bz);

    figure;
    plot_overview(jy,ss,norm,Lx,Ly);
    hold on
    plot([10,20],[-22,8],'--r','LineWidth',2);
    xlim([5,25]);
    ylim([-15,-5]);

    cd(outdir);
    print('-depsc','-painters','jy-v2.eps');
end
