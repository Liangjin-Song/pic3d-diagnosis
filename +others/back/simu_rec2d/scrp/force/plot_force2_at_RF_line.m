%% plot force density, including lorentz and pressure
% writen by Liangjin Song on 20190705
clear;
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M25SBg00Sx/out/force/2RF/';
tt=50:0.5:97;
c=0.6;
n0=2857.11157;
vA=0.06;
ndx=4000;
ndy=2000;
di=20;
Lx=ndx/di;
Ly=ndy/di;
x0=25;
qi=0.000105;
qe=-qi;
dirt=0;
grids=1;
norm=qi*n0*vA;

nt=length(tt);
for t=1:nt
    cd(indir);
    % magnetic field
    bx=read_data('Bx',tt(t));
    bx=bx/c;
    by=read_data('By',tt(t));
    by=by/c;
    bz=read_data('Bz',tt(t));
    bz=bz/c;

    % current density
    vix=read_data('vxi',tt(t));
    viy=read_data('vyi',tt(t));
    viz=read_data('vzi',tt(t));

    vex=read_data('vxe',tt(t));
    vey=read_data('vye',tt(t));
    vez=read_data('vze',tt(t));

    ni=read_data('Densi',tt(t));
    ne=read_data('Dense',tt(t));

    pi=read_data('presi',tt(t));
    pe=read_data('prese',tt(t));

    % force in x direction
    [jx,jy,jz]=calc_current_density(ni,ne,qi,qe,vix,viy,viz,vex,vey,vez);
    [llx,px]=calc_force2_at_RF(jx,jy,jz,bx,by,bz,pi,pe,grids);
    llx=simu_filter2d(llx);
    px=simu_filter2d(px);

    [lbz,lx]=get_line_data(bz,Lx,Ly,x0,1,dirt);
    [ll,~]=get_line_data(llx,Lx,Ly,x0,norm,dirt);
    [lp,~]=get_line_data(px,Lx,Ly,x0,norm,dirt);
    lm=ll+lp;

    [~,in]=max(lbz);
    xx=lx(in);
    xx1=xx-3;
    xx2=xx+3;
    xrange=[xx1,xx2];

    %% plot figure
    fontsize=16;
    linewidth=2;
    h=figure;
    set(h,'Visible','off');
    [ax,h1,h2]=plotyy(lx,[ll;lp;lm],lx,lbz); hold on
    plot([0,200],[0,0],'--m','LineWidth',linewidth);
    % set y axes
    set(ax(1),'XColor','k','YColor','k','FontSize',fontsize);
    set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
    set(ax(1),'XLim',xrange);
    set(ax(2),'XLim',xrange);

    % set label
    set(get(ax(2),'Ylabel'),'String','Bz[B_{0}]','FontSize',fontsize);
    set(get(ax(1),'Ylabel'),'String','fx[J_{0}B_{0}]','FontSize',fontsize);
    xlabel('X[c/\omega_{pi}]','FontSize',fontsize);

    % set line
    set(h1(1),'Color','g','LineWidth',linewidth);
    set(h1(2),'Color','b','LineWidth',linewidth);
    set(h1(3),'Color','k','LineWidth',linewidth);
    set(h2,'Color','r','LineWidth',linewidth);
    % set legend
    set(gcf,'Position',[100 100 1200 900]);
    set(gca,'Position',[.13 .18 .75 .75]);
    hl=legend([h1(:);h2],'Lorentz','pressure','Sum','Bz','Location','Best');
    set(hl,'Orientation','horizon');
    set(gca,'FontSize',16);

    %% save figures
    cd(outdir);
    print('-r300','-dpng',['Force_balance_Bz_t',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);
end
