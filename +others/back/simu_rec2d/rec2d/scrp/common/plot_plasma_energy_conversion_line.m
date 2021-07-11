%% plot Ji dot E and Je dot E
% writen by Liangjin Song on 20190521
%
clear;
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M25SBg00Sx/out/line/energy_conversion/';
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
norm=n0*vA^2;
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

    ex=read_data('Ex',tt(t));
    ey=read_data('Ey',tt(t));
    ez=read_data('Ez',tt(t));

    % current density 
    [jx,jy,jz]=calc_current_density(ni,ne,1,-1,vix,viy,viz,vex,vey,vez);
    [jix,jiy,jiz]=calc_plasma_current_density(1,ni,vix,viy,viz);
    [jex,jey,jez]=calc_plasma_current_density(-1,ne,vex,vey,vez);

    % energy conversion 
    jde=calc_energy_conversion(jx,jy,jz,ex,ey,ez);
    jide=calc_energy_conversion(jix,jiy,jiz,ex,ey,ez);
    jede=calc_energy_conversion(jex,jey,jez,ex,ey,ez);

    [ljde,lx]=get_line_data(jde,Lx,Ly,z0,norm,0);
    [ljide,~]=get_line_data(jide,Lx,Ly,z0,norm,0);
    [ljede,~]=get_line_data(jede,Lx,Ly,z0,norm,0);

    % plot figures
    h=figure;
    set(h,'Visible','off');
    plot(lx,ljde,'k','LineWidth',2); hold on
    plot(lx,ljide,'r','LineWidth',2);
    plot(lx,ljede,'g','LineWidth',2); hold off
    xlabel('X[c/\omega_{pi}]');
    ylabel('Energy Conversion');
    legend('J \cdot E','Ji \cdot E','Je \cdot E','Location','NorthWest');
    xlim([100,200]);
    set(gca,'FontSize',14);
    
    % save figures
    cd(outdir);
    print('-r200','-dpng',['plasma_energy_conversoin_t',num2str(tt(t),'%06.2f')]);
    close(gcf);
end
