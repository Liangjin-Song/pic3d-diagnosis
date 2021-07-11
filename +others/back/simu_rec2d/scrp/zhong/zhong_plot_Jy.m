%% plot J dot Ee' and the cut line
% writen by Liangjin Song on 20191026
clear;
indir='/data/simulation/zhong/M100B01Bg035/data';
outdir='/data/simulation/zhong/M100B01Bg035/out';
tt=26;
c=0.6;
wci=0.00075;
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
    vix=read_data('vxi',tt(t));
    viy=read_data('vyi',tt(t));
    viz=read_data('vzi',tt(t));
    ni=read_data('Densi',tt(t));

    % electron
    vex=read_data('vxe',tt(t));
    vey=read_data('vye',tt(t));
    vez=read_data('vze',tt(t));
    ne=read_data('Dense',tt(t));

    [jx,jy,jz]=calc_current_density(ni,ne,qi,qe,vix,viy,viz,vex,vey,vez);

    ex=read_data('Ex',tt(t));
    ey=read_data('Ey',tt(t));
    ez=read_data('Ez',tt(t));

    bx=read_data('Bx',tt(t));
    bx=bx/c;
    by=read_data('By',tt(t));
    by=by/c;
    bz=read_data('Bz',tt(t));
    bz=bz/c;

    ss=read_data('stream',tt(t));

    ed=calc_energy_dissipation(jx,jy,jz,ex,ey,ez,vex,vey,vez,bx,by,bz);

    figure;
    plot_overview(jy,ss,norm,Lx,Ly);
    caxis([-2.5,0]);
    % hold on
    % plot([10,20],[-22,8],'--r','LineWidth',2);
    xlim([5,25]);
    ylim([-15,-5]);

    cd(outdir);
    % print('-depsc','-painters','jy-v2.eps');
end
