%% plot magnetic field slash
% writen by Liangjin Song on 20190906
clear;
indir='/data/simulation/zhong/M100B01Bg035/data';
outdir='/data/simulation/zhong/M100B01Bg035/out';
tt=26;
t=1;
c=0.6;
wci=0.00075;
% di=40;
di=32.66;
Lx=1200/di;
Ly=1200/di;
vA=di*wci;
nt=length(tt);

ndx=600;
ndy=1200;
xx=0:Lx/ndx:Lx-Lx/ndx;
yy=-Ly/2:Ly/ndy:Ly/2-Ly/ndy;

n0=225;

% nx0=427;
% ny0=281;
% k=2;

% nx0=233;
% ny0=273;
nx0=241+2;
ny0=274+3;
k=2;

% nx0=150;
% ny0=150;

% nx0=242-5; % t=25
% ny0=132;

% nx0=240;  % t=24
% ny0=135;

% nx0=234;  % t=23
% ny0=135;

% nx0=245;  % t=26
% ny0=136;

% nx0=245+4;  % t=27
% ny0=136;

xrange=[10,20];
% xrange=[0,Lx];
fs=14;

% for t=1:nt
    cd(indir);
    bx=read_datat('Bx',tt(t));
    bx=bx/c;
    by=read_datat('By',tt(t));
    by=by/c;
    bz=read_datat('Bz',tt(t));
    bz=bz/c;
    b=sqrt(bx.^2+by.^2+bz.^2);

    ez=read_datat('Ez',tt(t));
    ez=ez/vA;

    vex=read_datat('vxe',tt(t));
    vex=vex/vA;
    vey=read_datat('vye',tt(t));
    vey=vey/vA;
    vez=read_datat('vze',tt(t));
    vez=vez/vA;

    ne=read_datat('Dense',tt(t));
    ne=ne/n0;

    [sbx,sx,sy]=get_line_by_k(bx,nx0,ny0,k);
    [sby,sx,sy]=get_line_by_k(by,nx0,ny0,k);
    [sbz,sx,sy]=get_line_by_k(bz,nx0,ny0,k);
    [sb,sx,sy]=get_line_by_k(b,nx0,ny0,k);

    [svx,sx,sy]=get_line_by_k(vex,nx0,ny0,k);
    [svy,sx,sy]=get_line_by_k(vey,nx0,ny0,k);
    [svz,sx,sy]=get_line_by_k(vez,nx0,ny0,k);

    [sne,sx,sy]=get_line_by_k(ne,nx0,ny0,k);

    [sez,sx,sy]=get_line_by_k(ez,nx0,ny0,k);

    sx=xx(sx(:));

    %}

    thw=[0.008,0.13];
    tlu=[0.10,0.03];
    tlr=[0.18,0.05];
    f1=figure(1);
    set(f1,'Units','centimeter','Position',[10,10,14,20]);
    ha1 = tight_subplot(8,1,thw,tlu,tlr);
    axes(ha1(1));
    plot(sx,sbx,'r','LineWidth',2); hold on
    plot([0,1000],[0,0],'--k','LineWidth',2); hold off
    xlim(xrange);
    % ylim([-1,1]);
    ylabel('B_x');
    set(gca,'xticklabel',[]);
    set(gca,'FontSize',fs);

    axes(ha1(2));
    plot(sx,sby,'g','LineWidth',2);
    xlim(xrange);
    % ylim([-0.7,-0.4]);
    ylabel('B_y');
    set(gca,'xticklabel',[]);
    set(gca,'FontSize',fs);

    axes(ha1(3));
    plot(sx,sbz,'b','LineWidth',2); hold on
    plot([0,1000],[0,0],'--k','LineWidth',2); hold off
    xlim(xrange);
    ylabel('B_z');
    set(gca,'xticklabel',[]);
    set(gca,'FontSize',fs);

    axes(ha1(4));
    plot(sx,sb,'k','LineWidth',2);
    xlim(xrange);
    ylim([0,1.5])
    ylabel('B_{tot}');
    set(gca,'xticklabel',[]);
    set(gca,'FontSize',fs);

    axes(ha1(5));
    plot(sx,sne,'k','LineWidth',2);
    xlim(xrange);
    ylim([0,1.5])
    ylabel('Ne');
    set(gca,'xticklabel',[]);
    set(gca,'FontSize',fs);

    axes(ha1(6));
    plot(sx,svx,'r','LineWidth',2); hold on
    plot([0,1000],[0,0],'--k','LineWidth',2); hold off
    xlim(xrange);
    ylabel('vex');
    set(gca,'xticklabel',[]);
    set(gca,'FontSize',fs);

    axes(ha1(7));
    plot(sx,svy,'g','LineWidth',2); hold on
    plot([0,1000],[0,0],'--k','LineWidth',2); hold off
    xlim(xrange);
    ylabel('vey');
    set(gca,'xticklabel',[]);
    set(gca,'FontSize',fs);

    axes(ha1(8));
    plot(sx,svz,'b','LineWidth',2); hold on
    plot([0,1000],[0,0],'--k','LineWidth',2); hold off
    xlim(xrange);
    ylabel('vez');
    % set(gca,'xticklabel',[]);
    xlabel('X [c/\omega_{pi}]');
    set(gca,'FontSize',fs);
    
    %{
    subplot(9,1,9);
    plot(sx,sez,'r','LineWidth',2); hold on
    plot([0,1000],[0,0],'--k','LineWidth',2); hold off
    xlim(xrange);
    ylabel('E_z');
    xlabel('X [c/\omega_{pi}]');
    set(gca,'FontSize',fs);
    %}

    cd(outdir);
    % print('-r300','-dpng',['B_slash_k=',num2str(k),'_t',num2str(tt(t),'%06.2f'),'.png']);
    % print('-depsc','-painters','k=3_tight.eps');
% end
