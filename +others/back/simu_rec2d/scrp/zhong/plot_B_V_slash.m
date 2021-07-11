%% plot magnetic field slash
% writen by Liangjin Song on 20190906
clear;
indir='/data/simulation/zhong/M100B01Bg05/data/';
outdir='/data/simulation/zhong/M100B01Bg05/out/';
tt=25;
c=0.6;
% wci=0.00075;
wci=0.0007499;
% di=40;
di=32.66;
Lx=1200/di;
Ly=1200/di;
vA=di*wci;
nt=length(tt);

ndx=600;
ndy=600;
xx=0:Lx/ndx:Lx-Lx/ndx;
yy=-Ly/2:Ly/ndy:Ly/2-Ly/ndy;

n0=225;

% nx0=427;
% ny0=281;
% k=2;

nx0=233;
% ny0=227;
ny0=273;
% ny0=140;
k=3;


% xrange=[160,300];
% xrange=[120,400];
% xrange=[190,290];
xrange=[11,18];
fs=15;

for t=1:nt
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

    subplot(8,1,1);
    plot(sx,sbx,'r','LineWidth',2); hold on
    plot([0,1000],[0,0],'--k','LineWidth',2); hold off
    xlim(xrange);
    % ylim([-1,1]);
    ylabel('B_x');
    set(gca,'xticklabel',[]);
    set(gca,'FontSize',fs);

    subplot(8,1,2);
    plot(sx,sby,'g','LineWidth',2);
    xlim(xrange);
    ylim([-0.7,-0.4]);
    ylabel('B_y');
    set(gca,'xticklabel',[]);
    set(gca,'FontSize',fs);

    subplot(8,1,3);
    plot(sx,sbz,'b','LineWidth',2); hold on
    plot([0,1000],[0,0],'--k','LineWidth',2); hold off
    xlim(xrange);
    ylabel('B_z');
    set(gca,'xticklabel',[]);
    set(gca,'FontSize',fs);

    subplot(8,1,4);
    plot(sx,sb,'k','LineWidth',2);
    xlim(xrange);
    ylim([0,1.5])
    ylabel('B_{tot}');
    set(gca,'xticklabel',[]);
    set(gca,'FontSize',fs);

    subplot(8,1,5);
    plot(sx,sne,'k','LineWidth',2);
    xlim(xrange);
    ylim([0,1.5])
    ylabel('Ne');
    set(gca,'xticklabel',[]);
    set(gca,'FontSize',fs);

    subplot(8,1,6);
    plot(sx,svx,'r','LineWidth',2); hold on
    plot([0,1000],[0,0],'--k','LineWidth',2); hold off
    xlim(xrange);
    ylabel('vex');
    set(gca,'xticklabel',[]);
    set(gca,'FontSize',fs);

    subplot(8,1,7);
    plot(sx,svy,'g','LineWidth',2); hold on
    plot([0,1000],[0,0],'--k','LineWidth',2); hold off
    xlim(xrange);
    ylabel('vey');
    set(gca,'xticklabel',[]);
    set(gca,'FontSize',fs);

    subplot(8,1,8);
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
end
