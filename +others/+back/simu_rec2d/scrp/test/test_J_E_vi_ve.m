%% subplot J E vi and ve
% writen by Liangjin Song on 20191028
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/je/';
tt=45;
c=0.6;
n0=1304.33557;
wci=0.000750;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);
vA=di*wci;

qi=1;
qe=-1;

z0=15;
dirt=0;

for t=1:nt
    cd(indir);

    ex=read_data('Ex',tt(t));
    ey=read_data('Ey',tt(t));
    ez=read_data('Ez',tt(t));

    ni=read_data('Densi',tt(t));
    vix=read_data('vxi',tt(t));
    viy=read_data('vyi',tt(t));
    viz=read_data('vzi',tt(t));

    ne=read_data('Dense',tt(t));
    vex=read_data('vxe',tt(t));
    vey=read_data('vye',tt(t));
    vez=read_data('vze',tt(t));

    %% current
    [jx,jy,jz]=calc_current_density(ni,ne,qi,qe,vix,viy,viz,vex,vey,vez);

    %% ion current
    jix=(ni.*vix)*qi;
    jiy=(ni.*viy)*qi;
    jiz=(ni.*viz)*qi;

    % electron current
    jex=(ne.*vex)*qe;
    jey=(ne.*vey)*qe;
    jez=(ne.*vez)*qe;

    [ljx,lx]=get_line_data(jx,Lx,Ly,z0,n0*vA,dirt);
    [ljy,~]=get_line_data(jy,Lx,Ly,z0,n0*vA,dirt);
    [ljz,~]=get_line_data(jz,Lx,Ly,z0,n0*vA,dirt);

    [ljex,~]=get_line_data(jex,Lx,Ly,z0,n0*vA,dirt);
    [ljey,~]=get_line_data(jey,Lx,Ly,z0,n0*vA,dirt);
    [ljez,~]=get_line_data(jez,Lx,Ly,z0,n0*vA,dirt);

    [ljix,~]=get_line_data(jix,Lx,Ly,z0,n0*vA,dirt);
    [ljiy,~]=get_line_data(jiy,Lx,Ly,z0,n0*vA,dirt);
    [ljiz,~]=get_line_data(jiz,Lx,Ly,z0,n0*vA,dirt);

    [lvex,~]=get_line_data(vex,Lx,Ly,z0,vA,dirt);
    [lvey,~]=get_line_data(vey,Lx,Ly,z0,vA,dirt);
    [lvez,~]=get_line_data(vez,Lx,Ly,z0,vA,dirt);

    [lvix,~]=get_line_data(vix,Lx,Ly,z0,vA,dirt);
    [lviy,~]=get_line_data(viy,Lx,Ly,z0,vA,dirt);
    [lviz,~]=get_line_data(viz,Lx,Ly,z0,vA,dirt);

    [lex,~]=get_line_data(ex,Lx,Ly,z0,vA,dirt);
    [ley,~]=get_line_data(ey,Lx,Ly,z0,vA,dirt);
    [lez,~]=get_line_data(ez,Lx,Ly,z0,vA,dirt);

    figure;
    lw=2;
    xrange=[104,114];
    subplot(3,2,1)
    plot(lx,ljx,'r','LineWidth',lw); hold on
    plot(lx,ljy,'g','LineWidth',lw);
    plot(lx,ljz,'b','LineWidth',lw); 
    plot([0,120],[0,0],'--y','LineWidth',1); hold off
    xlim(xrange);
    legend('Jx','Jy','Jz');
    set(gca,'xticklabel',[]);

    subplot(3,2,2)
    plot(lx,lex,'r','LineWidth',lw); hold on
    plot(lx,ley,'g','LineWidth',lw);
    plot(lx,lez,'b','LineWidth',lw);
    plot([0,120],[0,0],'--y','LineWidth',1); hold off
    xlim(xrange);
    legend('Ex','Ey','Ez');
    set(gca,'xticklabel',[]);

    subplot(3,2,3)
    plot(lx,ljix,'r','LineWidth',lw); hold on
    plot(lx,ljiy,'g','LineWidth',lw);
    plot(lx,ljiz,'b','LineWidth',lw); hold off
    xlim(xrange);
    legend('Jix','Jiy','Jiz');
    set(gca,'xticklabel',[]);

    subplot(3,2,4)
    plot(lx,ljex,'r','LineWidth',lw); hold on
    plot(lx,ljey,'g','LineWidth',lw);
    plot(lx,ljez,'b','LineWidth',lw);
    plot([0,120],[0,0],'--y','LineWidth',1); hold off
    xlim(xrange);
    legend('Jex','Jey','Jez');
    set(gca,'xticklabel',[]);

    subplot(3,2,5)
    plot(lx,lvix,'r','LineWidth',lw); hold on
    plot(lx,lviy,'g','LineWidth',lw);
    plot(lx,lviz,'b','LineWidth',lw); hold off
    xlim(xrange);
    legend('vix','viy','viz');
    xlabel('X [c/\omega{pi}]');

    subplot(3,2,6)
    plot(lx,lvex,'r','LineWidth',lw); hold on
    plot(lx,lvey,'g','LineWidth',lw);
    plot(lx,lvez,'b','LineWidth',lw);
    plot([0,120],[0,0],'--y','LineWidth',1); hold off
    xlim(xrange);
    legend('vex','vey','vez');
    xlabel('X [c/\omega{pi}]');

    cd(outdir);
    % print('-r300','-dpng',['B_slash_k=',num2str(k),'_t',num2str(tt(t),'%06.2f'),'.png']);
end

