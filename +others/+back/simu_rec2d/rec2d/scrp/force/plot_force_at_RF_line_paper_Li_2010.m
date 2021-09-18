%% plot force at RF line paper Li 2010
% writen by Liangjin Song on 20190707
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/force/';
tt=20:0.5:60;
c=0.6;
n0=1304.33557;
vA=0.03;
ndx=4800;
ndy=2400;
di=40;
Lx=ndx/di;
Ly=ndy/di;
x0=15;
qi=0.000230;
qe=-qi;
dirt=0;
grids=1;
% norm=qi*n0*vA;
norm=1;

nt=length(tt);
for t=1:nt
    cd(indir);
    bx=read_data('Bx',tt(t));
    bx=bx/c;
    by=read_data('By',tt(t));
    by=by/c;
    bz=read_data('Bz',tt(t));
    bz=bz/c;

    pi=read_data('presi',tt(t));
    pe=read_data('prese',tt(t));

    % force in x direction
    [curvx,gradx]=calc_force_at_RF_paper_Li_2010(bx,by,bz,pi,pe,c,grids);
    % curvx=simu_filter2d(curvx);
    % gradx=simu_filter2d(gradx);

    [lbz,lx]=get_line_data(bz,Lx,Ly,x0,1,dirt);
    [lc,~]=get_line_data(curvx,Lx,Ly,x0,norm,dirt);
    [lp,~]=get_line_data(gradx,Lx,Ly,x0,norm,dirt);
    lm=lc+lp;

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
    [ax,h1,h2]=plotyy(lx,[lc;lp;lm],lx,lbz); hold on
    plot([0,250],[0,0],'--m','LineWidth',linewidth);
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
    hl=legend([h1(:);h2],'curvature','pressure','Sum','Bz','Location','Best');
    set(hl,'Orientation','horizon');
    set(gca,'FontSize',16);

    %% save figures
    cd(outdir);
    print('-r300','-dpng',['Force_balance_Bz_t',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);
end
