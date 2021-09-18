%% plot energy conversion line total, including J dot E, Ji dot E and Je dot E
% writen by Liangjin Song on 20190619 
clear;
indir='/data/simulation/M100SBg00Sx_low_vte/ppc=100/';
outdir='/data/simulation/M100SBg00Sx_low_vte/out/ppc=100/line/energy/conversion/';
tt=0:0.5:75;
di=60;
Lx=6000/di;
Ly=3000/di;
c=0.6;
n0=600.01105;
vA=0.015000;
qi=1;
qe=-1;
z0=12.5;
norm=n0*vA*vA;
shift=3;
xrange=[Lx*3/4,Lx];

nt=length(tt);
for t=1:nt
    cd(indir);
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
    % field
    ex=read_data('Ex',tt(t));
    ey=read_data('Ey',tt(t));
    ez=read_data('Ez',tt(t));

    bz=read_data('Bz',tt(t));
    bz=bz/c;

    % current density 
    [Jx,Jy,Jz]=calc_current_density(ni,ne,qi,qe,vix,viy,viz,vex,vey,vez);
    [Jix,Jiy,Jiz]=calc_plasma_current_density(qi,ni,vix,viy,viz);
    [Jex,Jey,Jez]=calc_plasma_current_density(qe,ne,vex,vey,vez);

    % energy conversion 
    Etot=calc_energy_conversion(Jx,Jy,Jz,ex,ey,ez);
    Ei=calc_energy_conversion(Jix,Jiy,Jiz,ex,ey,ez);
    Ee=calc_energy_conversion(Jex,Jey,Jez,ex,ey,ez);

    % line 
    [lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,0);
    [lEt,~]=get_line_data(Etot,Lx,Ly,z0,norm,0);
    [lEi,~]=get_line_data(Ei,Lx,Ly,z0,norm,0);
    [lEe,~]=get_line_data(Ee,Lx,Ly,z0,norm,0);

    nn=length(lx);
    nzero=zeros(1,nn);

    % figures
    fontsize=14;
    linewidth=1;
    h=figure;
    set(h,'Visible','off');
    [ax,h1,h2]=plotyy(lx,[lEt;lEi;lEe;nzero],lx,lbz);

    %{
    [~,in]=max(lbz);
    px=lx(in);
    xrg1=px-shift;
    xrg2=px+shift;
    if xrg1<0
        xrg1=0;
    end
    if xrg2>100
        xrg2=120;
    end
    xrange=[xrg1,xrg2];
    %}
    % set y axes
    set(ax(1),'XColor','k','YColor','k','FontSize',fontsize);
    set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
    set(ax,'XLim',xrange);
    % set label
    set(get(ax(1),'Ylabel'),'String','Energy conversion','Fontsize',fontsize);
    set(get(ax(2),'Ylabel'),'String','Bz','Fontsize',fontsize);
    xlabel('X[c/\omega_{pi}]','FontSize',fontsize);
    % set line
    set(h1(1),'Color','k','LineWidth',linewidth);
    set(h1(2),'Color','g','LineWidth',linewidth);
    set(h1(3),'Color','b','LineWidth',linewidth);
    set(h1(4),'Color','y','LineWidth',0.5);
    set(h2,'Color','r','LineWidth',linewidth);
    % set legend
    set(gca,'Position',[.15 .16 .7 .8]);
    hl=legend([h1(1:3);h2],'J\cdotE','Ji\cdotE','Je\cdotE','Bz','Location','SouthEast');
    set(hl,'Orientation','horizon');

    cd(outdir);
    print('-r300','-dpng',['total_energy_conversion_t',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);
end
