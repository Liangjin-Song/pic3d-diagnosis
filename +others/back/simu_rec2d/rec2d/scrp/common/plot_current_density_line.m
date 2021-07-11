%% plot current density
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

    [ljx,lx]=get_line_data(jx,Lx,Ly,z0,norm,0);
    [ljy,~]=get_line_data(jy,Lx,Ly,z0,norm,0);
    [ljz,~]=get_line_data(jz,Lx,Ly,z0,norm,0);

    % plot figures
    h=figure;
    set(h,'Visible','off');
    plot(lx,ljde,'r','LineWidth',2); hold on
    plot(lx,ljide,'g','LineWidth',2);
    plot(lx,ljede,'b','LineWidth',2); hold off
    xlabel('X[c/\omega_{pi}]');
    ylabel('Current Density');
    legend('Jy','Jy','Jz','Location','NorthWest');
    xlim([100,200]);
    set(gca,'FontSize',14);
    
    % save figures
    cd(outdir);
    print('-r200','-dpng',['current_density_t',num2str(tt(t),'%06.2f')]);
    close(gcf);
end
