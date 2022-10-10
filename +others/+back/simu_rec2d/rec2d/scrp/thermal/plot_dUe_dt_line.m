%% writen by Liangjin Song on 20190522
% plot partial Ue/t line
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/thermal/electron/line/';
tt=0:0.5:100;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di; Ly=ndy/di;
nt=length(tt);
z0=15;
c=0.6;
grids=1;
wci=0.000750;

for t=1:nt
    cd(indir);
    tm=tt(t);
    p=read_data('prese',tm);

    vx=read_data('vxe',tm);
    vy=read_data('vye',tm);
    vz=read_data('vze',tm);

    qflux=read_data('qfluxe',tm);

    bx=read_data('Bx',tm);
    bx=bx/c;
    by=read_data('By',tm);
    by=by/c;
    bz=read_data('Bz',tm);
    bz=bz/c;

    ex=read_data('Ex',tm);
    ey=read_data('Ey',tm);
    ez=read_data('Ez',tm);

    [pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ndy,ndx);
    [qx,qy,qz]=reshape_qflux(qflux,ndy,ndx);

    [U,enp,htf,thp,con]=calc_dU_dt(pxx,pxy,pxz,pyy,pyz,pzz,qx,qy,qz,vx,vy,vz,bx,by,bz,ex,ey,ez,grids,Lx,Ly,z0);

    % get line
    [lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,0);
    [lenp,~]=get_line_data(enp,Lx,Ly,z0,1,0);
    [lhtf,~]=get_line_data(htf,Lx,Ly,z0,1,0);
    [lthp,~]=get_line_data(thp,Lx,Ly,z0,1,0);
    [lcon,~]=get_line_data(con,Lx,Ly,z0,1,0);
    ltot=lenp+lhtf+lthp+lcon;

    % plot figure
    h=figure;
    fontsize=12;
    linewidth=2;
    set(h,'Visible','off');
    [ax,h1,h2]=plotyy(lx,[lenp;lhtf;lthp;lcon;ltot],lx,lbz);
    % set y axes
    set(ax(1),'XColor','k','YColor','k','FontSize',fontsize);
    set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
    [~,in]=max(lbz);
    x0=lx(in);
    if x0-3<0
        x1=0;
    else
        x1=x0-3;
    end
    if x0+3>Lx
        x2=Lx;
    else
        x2=x0+3;
    end
    xrange=[x1,x2];
    set(ax(1),'XLim',xrange);
    set(ax(2),'XLim',xrange);

    % set label
    set(get(ax(1),'Ylabel'),'String','dUe/dt','FontSize',fontsize);
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
    hl=legend([h1(:);h2],'-\nabla \cdot (u_{e}V_{e}+P_{e} \cdot V_{e})','-\nabla \cdot q_{e}','V_{e}\cdot (\nabla \cdot P_{e})','v_{RF}\cdot \nabla U_{e}','Sum','Bz','Location','SouthEast');
    %% save figures
    cd(outdir);
    print('-r300','-dpng',['dUe_dt_Bz_t',num2str(tm,'%06.2f'),'.png']);
    close(gcf);
end
