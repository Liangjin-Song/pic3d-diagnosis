%% plot magnetic field slash
% writen by Liangjin Song on 20190906
clear;
indir='/data/simulation/zhong/M100B01Bg05/data/';
outdir='/data/simulation/zhong/M100B01Bg05/out/';
tt=25;
c=0.6;
wci=0.00075;
di=40;
Lx=1200/di;
Ly=1200/di;
vA=di*wci;
nt=length(tt);

x0=30.88;
dirt=1;

nx0=427;
ny0=281;
k=0;

% xrange=[0,1200];
xrange=[250,310];

for t=1:nt
    cd(indir);
    bx=read_data('Bx',tt(t));
    bx=bx/c;
    by=read_data('By',tt(t));
    by=by/c;
    bz=read_data('Bz',tt(t));
    bz=bz/c;

    vex=read_data('vxe',tt(t));
    vex=vex/vA;
    vey=read_data('vye',tt(t));
    vey=vey/vA;
    vez=read_data('vze',tt(t));
    vez=vez/vA;

    [lbx,ly]=get_line_data(bx,Lx,Ly,x0,1,dirt);
    [lby,~]=get_line_data(by,Lx,Ly,x0,1,dirt);
    [lbz,~]=get_line_data(bz,Lx,Ly,x0,1,dirt);

    [lvx,~]=get_line_data(vex,Lx,Ly,x0,1,dirt);
    [lvy,~]=get_line_data(vey,Lx,Ly,x0,1,dirt);
    [lvz,~]=get_line_data(vez,Lx,Ly,x0,1,dirt);


    subplot(6,1,1);
    plot(lbx,'r','LineWidth',2); hold on
    plot([0,1000],[0,0],'--k','LineWidth',2); hold off
    xlim(xrange);
    ylabel('Bx');
    set(gca,'xticklabel',[]);

    subplot(6,1,2);
    plot(lby,'g','LineWidth',2);
    xlim(xrange);
    ylabel('By');
    set(gca,'xticklabel',[]);

    subplot(6,1,3);
    plot(lbz,'b','LineWidth',2); hold on
    % plot([0,1000],[0,0],'--k','LineWidth',2); hold off
    xlim(xrange);
    ylabel('Bz');
    set(gca,'xticklabel',[]);


    subplot(6,1,4);
    plot(lvx,'r','LineWidth',2); hold on
    plot([0,1000],[0,0],'--k','LineWidth',2); hold off
    xlim(xrange);
    ylabel('vex');
    set(gca,'xticklabel',[]);

    subplot(6,1,5);
    plot(lvy,'g','LineWidth',2);
    xlim(xrange);
    ylabel('vey');
    set(gca,'xticklabel',[]);

    subplot(6,1,6);
    plot(lvz,'b','LineWidth',2); hold on
    plot([0,1000],[0,0],'--k','LineWidth',2); hold off
    xlim(xrange);
    ylabel('vez');

    cd(outdir);
    % print('-r300','-dpng',['B_slash_k=',num2str(k),'_t',num2str(tt(t),'%06.2f'),'.png']);
end
