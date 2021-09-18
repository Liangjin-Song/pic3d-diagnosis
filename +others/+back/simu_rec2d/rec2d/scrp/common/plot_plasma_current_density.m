%% plot plasma current density
% writen by Liangjin Song on 20190521
%
clear;
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M25SBg00Sx/out/line/current_density/';
tt=40:0.5:97;
di=20;
ndx=4000;
ndy=2000;
Lx=ndx/di;
Ly=ndy/di;
n0=2857.11157;
vA=0.060000;
z0=25;
nt=length(tt);
norm=n0*vA;
for t=1:nt
    cd(indir)
    ni=read_data('Densi',tt(t));
    ne=read_data('Dense',tt(t));

    vix=read_data('vxi',tt(t));
    vex=read_data('vxe',tt(t));

    viy=read_data('vyi',tt(t));
    vey=read_data('vye',tt(t));

    viz=read_data('vzi',tt(t));
    vez=read_data('vze',tt(t));

    % current density 
    [jx,jy,jz]=calc_current_density(ni,ne,1,-1,vix,viy,viz,vex,vey,vez);
    [jix,jiy,jiz]=calc_plasma_current_density(1,ni,vix,viy,viz);
    [jex,jey,jez]=calc_plasma_current_density(-1,ne,vex,vey,vez);

    [ljx,lx]=get_line_data(jx,Lx,Ly,z0,norm,0);
    [ljy,~]=get_line_data(jx,Lx,Ly,z0,norm,0);
    [ljz,~]=get_line_data(jz,Lx,Ly,z0,norm,0);

    [ljix,~]=get_line_data(jix,Lx,Ly,z0,norm,0);
    [ljiy,~]=get_line_data(jiy,Lx,Ly,z0,norm,0);
    [ljiz,~]=get_line_data(jiz,Lx,Ly,z0,norm,0);

    [ljex,~]=get_line_data(jex,Lx,Ly,z0,norm,0);
    [ljey,~]=get_line_data(jey,Lx,Ly,z0,norm,0);
    [ljez,~]=get_line_data(jez,Lx,Ly,z0,norm,0);


    % plot figures
    h=figure;
    set(h,'Visible','off');
    % plot y direction
    plot(lx,ljy,'k','LineWidth',2); hold on
    plot(lx,ljiy,'r','LineWidth',2);
    plot(lx,ljey,'g','LineWidth',2); hold off
    xlabel('X[c/\omega_{pi}]');
    ylabel('Current Density');
    legend('Jy','Jiy','Jey','Location','NorthWest');
    xlim([100,200]);
    set(gca,'FontSize',14);
    
    % save figures
    cd(outdir);
    print('-r200','-dpng',['plasma_current_density_t',num2str(tt(t),'%06.2f')]);
    close(gcf);
end
