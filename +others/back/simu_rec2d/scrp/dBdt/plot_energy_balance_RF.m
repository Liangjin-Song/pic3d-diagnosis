%% plot energy balance at RF 
% writen by Liangjin Song on 20190326 
%% parameters 
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/dB_dt/RF/';
tt=0:100;
ndx=4800;
ndy=2400;
di=40;
Lx=ndx/di;
Ly=ndy/di;
c=0.6;
mu=1/(c^2);
z0=15;
qi=0.000230;
qe=-qi;
wci=0.000750;
divsor=1;
nt=length(tt);
norm=wci;
%% loop 
for t=1:nt-1
    % previous time
    tp=tt(t);
    % next time 
    tn=tt(t+1);
    % half time 
    th=(tp+tn)/2;
    
    % read data 
    cd(indir);

    % Bx
    bxp=read_data('Bx',tp);
    bxp=bxp/c;
    bxh=read_data('Bx',th);
    bxh=bxh/c;
    bxn=read_data('Bx',tn);
    bxn=bxn/c;

    % By
    byp=read_data('By',tp);
    byp=byp/c;
    byh=read_data('By',th);
    byh=byh/c;
    byn=read_data('By',tn);
    byn=byn/c;

    % Bz
    bzp=read_data('Bz',tp);
    bzp=bzp/c;
    bzh=read_data('Bz',th);
    bzh=bzh/c;
    bzn=read_data('Bz',tn);
    bzn=bzn/c;

    % Electric field
    exh=read_data('Ex',th);
    eyh=read_data('Ey',th);
    ezh=read_data('Ez',th);

    % Density
    nih=read_data('Densi',th);
    neh=read_data('Dense',th);

    % ions velocity
    vxih=read_data('vxi',th);
    vyih=read_data('vyi',th);
    vzih=read_data('vzi',th);

    % electrons velocity
    vxeh=read_data('vxe',th);
    vyeh=read_data('vye',th);
    vzeh=read_data('vze',th);

    %% calculate transport item
    Bh=sqrt(bxh.^2+byh.^2+bzh.^2);
    [lbzp,lx]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    v_RF=calc_instant_RF_velocity(lbzp,lbzn,lx,wci,di);
    [vx_drf,vy_drf,vz_drf]=calc_drift_velocity(exh,eyh,ezh,bxh,byh,bzh);
    transp=calc_transport_item(v_RF,vx_drf,vy_drf,vz_drf,Bh,divsor);

    %% Local energy conversion
    [Jxh,Jyh,Jzh]=calc_current_density(nih,neh,qi,qe,vxih,vyih,vzih,vxeh,vyeh,vzeh);
    lenergy=calc_local_energy_conversion_item(Jxh,Jyh,Jzh,exh,eyh,ezh,Bh,mu);

    %% compression item
    compre=calc_compression_item(vx_drf,vy_drf,vz_drf,Bh,divsor);

    %% get line 
    [ltr,~]=get_line_data(transp,Lx,Ly,z0,norm,0);
    [len,~]=get_line_data(lenergy,Lx,Ly,z0,norm,0);
    [lco,~]=get_line_data(compre,Lx,Ly,z0,norm,0);
    ltot=ltr+len+lco;
    [lbzh,~]=get_line_data(bzh,Lx,Ly,z0,1,0);
    [~,in]=max(lbzh);
    ptn=lx(in);

    %% get the RF position
    nx=length(lx);
    [~,in]=max(lbzh);
    in1=in-100;
    in2=in+100;
    if in2>nx
        in2=nx;
    end
    if in1<1
        in1=1;
    end
    ltr=ltr(in1:in2);
    len=len(in1:in2);
    lco=lco(in1:in2);
    ltot=ltot(in1:in2);
    lbzh=lbzh(in1:in2);
    lx=lx(in1:in2);

    %% plot figure
    fontsize=16;
    linewidth=1;
    h=figure;
    set(h,'Visible','off');
    [ax,h1,h2]=plotyy(lx,[ltr;len;lco;ltot],lx,lbzh);
    % set y axes
    set(ax(1),'XColor','k','YColor','k','FontSize',fontsize);
    set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
    xrange=[lx(1),lx(end)];
    set(ax(1),'XLim',xrange);
    set(ax(2),'XLim',xrange);

    % set label
    set(get(ax(2),'Ylabel'),'String','Bz','FontSize',fontsize);
    xlabel('X[c/\omega_{pi}]','FontSize',fontsize);

    % set line
    set(h1(1),'Color','g','LineWidth',linewidth);
    set(h1(2),'Color','b','LineWidth',linewidth);
    set(h1(3),'Color','c','LineWidth',linewidth);
    set(h1(4),'Color','k','LineWidth',linewidth);
    set(h2,'Color','r','LineWidth',linewidth);
    % set legend
    set(gcf,'Position',[100 100 1200 900]);
    set(gca,'Position',[.13 .18 .75 .75]);
    hl=legend([h1(:);h2],'Transport','Local energy conversion','Compression','Sum','Bz','Location','Best');
    set(hl,'Orientation','horizon');
    %% save figures
    cd(outdir);
    print('-r300','-dpng',['Energy_balance_Bz_t',num2str(th,'%06.2f'),'.png']);
    close(gcf);
end
