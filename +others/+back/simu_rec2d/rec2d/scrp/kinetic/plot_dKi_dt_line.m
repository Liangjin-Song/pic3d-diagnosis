%% plot time evolution of the ion bulk kinetic energy  at the reconnection front
% writen by Liangjin Song on 20190518 
%
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/line/kinetic/ion/dK_dt/';
tt=50:100;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
mi=0.166668;
q=0.000125;
wci=0.000750;
nt=length(tt)-1;
z0=15;
c=0.6;
grids=1;

for t=1:nt
    cd(indir);
    tp=tt(t);
    tn=tt(t+1);
    th=(tp+tn)/2;

    nh=read_data('Densi',th);
    vxh=read_data('vxi',th);
    vyh=read_data('vyi',th);
    vzh=read_data('vzi',th);

    bxh=read_data('Bx',th);
    bxh=bxh/c;
    byh=read_data('By',th);
    byh=byh/c;
    bzh=read_data('Bz',th);
    bzh=bzh/c;

    bzp=read_data('Bz',tp);
    bzp=bzp/c;
    bzn=read_data('Bz',tn);
    bzn=bzn/c;

    exh=read_data('Ex',th);
    eyh=read_data('Ey',th);
    ezh=read_data('Ez',th);

    ph=read_data('presi',tt(t));

    %% bulk kinetic energy
    m=mi;
    [Kh,fluxh,weh,wph]=calc_partial_t(q,m,nh,vxh,vyh,vzh,exh,eyh,ezh,ph,grids);
    %% convective, which is defined at half grids in x and z directions
    [lbzp,lx]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    vrx=calc_instant_RF_velocity(lbzp,lbzn,lx,wci,di);
    cvh=calc_convective(vrx,vxh,vyh,vzh,Kh,grids);

    %% get a mean value of a ractangle
    [lbzh,lx]=get_line_data(bzh,Lx,Ly,z0,1,0);
    [lfx,~]=get_line_data(fluxh,Lx,Ly,z0,1,0);
    [lwe,~]=get_line_data(weh,Lx,Ly,z0,1,0);
    [lwp,~]=get_line_data(wph,Lx,Ly,z0,1,0);
    [lcv,~]=get_line_data(cvh,Lx,Ly,z0,1,0);
    ltot=lfx+lwe+lwp+lcv;

    h=figure;
    fontsize=14;
    linewidth=2;
    set(h,'Visible','on');
    [ax,h1,h2]=plotyy(lx,[lfx;lwe;lwp;lcv;ltot],lx,lbzh);
    % set y axes
    set(ax(1),'XColor','k','YColor','k','FontSize',fontsize);
    set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
    [~,in]=max(lbzh);
    x0=lx(in);
    xrange=[x0-3,x0+3];
    set(ax(1),'XLim',xrange);
    set(ax(2),'XLim',xrange);

    % set label
    set(get(ax(1),'Ylabel'),'String','dKi/dt','FontSize',fontsize);
    set(get(ax(2),'Ylabel'),'String','Bz','FontSize',fontsize);
    xlabel('X[c/\omega_{pi}]','FontSize',fontsize);

    % set line
    set(h1(1),'Color','g','LineWidth',linewidth);
    set(h1(2),'Color','b','LineWidth',linewidth);
    set(h1(3),'Color','c','LineWidth',linewidth);
    set(h1(4),'Color','m','LineWidth',linewidth);
    set(h1(5),'Color','k','LineWidth',linewidth);
    set(h2,'Color','r','LineWidth',linewidth);
    % set legend
    hl=legend([h1(:);h2],'Flux','Work by E field','Work by pressure','Convective','Total','Bz','Location','Best');
    set(gca,'FontSize',fontsize)
    %% save figures
    cd(outdir);
    print('-r200','-dpng',['dKi_dt_Bz_t',num2str(th,'%06.2f'),'.png']);
    close(gcf);
end
