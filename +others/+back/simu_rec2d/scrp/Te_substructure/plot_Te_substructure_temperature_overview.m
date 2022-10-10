%% plot the temperature overview 
% writen by Liangjin Song on 20190814 
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/Te_substructure/overview/';
tt=43;
di=40;
c=0.6;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);

for t=1:nt
    cd(indir);
    pe=read_data('prese',tt(t));
    ne=read_data('Dense',tt(t));
    pi=read_data('presi',tt(t));
    ni=read_data('Densi',tt(t));

    ss=read_data('stream',tt(t));

    bx=read_data('Bx',tt(t));
    bx=bx/c;
    by=read_data('By',tt(t));
    by=by/c;
    bz=read_data('Bz',tt(t));
    bz=bz/c;

    [Ti_aver,Ti_perp,Ti_para,Ti_anis]=calc_temperature(pi,bx,by,bz,ni);
    [Te_aver,Te_perp,Te_para,Te_anis]=calc_temperature(pe,bx,by,bz,ne);

    % ion
    plot_overview(Ti_aver,ss,1,Lx,Ly);
    xlim([70,110]);
    ylim([7,23]);
    cd(outdir);
    print('-r300','-dpng',['Ti_aver_',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);

    plot_overview(Ti_perp,ss,1,Lx,Ly);
    xlim([70,110]);
    ylim([7,23]);
    cd(outdir);
    print('-r300','-dpng',['Ti_perp_',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);

    plot_overview(Ti_para,ss,1,Lx,Ly);
    xlim([70,110]);
    ylim([7,23]);
    cd(outdir);
    print('-r300','-dpng',['Ti_para_',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);

    plot_overview(Ti_anis,ss,1,Lx,Ly);
    xlim([70,110]);
    ylim([7,23]);
    cd(outdir);
    print('-r300','-dpng',['Ti_anis_',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);

    % electron
    plot_overview(Te_aver,ss,1,Lx,Ly);
    xlim([70,110]);
    ylim([7,23]);
    cd(outdir);
    print('-r300','-dpng',['Te_aver_',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);

    plot_overview(Te_perp,ss,1,Lx,Ly);
    xlim([70,110]);
    ylim([7,23]);
    cd(outdir);
    print('-r300','-dpng',['Te_perp_',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);

    plot_overview(Te_para,ss,1,Lx,Ly);
    xlim([70,110]);
    ylim([7,23]);
    cd(outdir);
    print('-r300','-dpng',['Te_para_',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);

    plot_overview(Te_anis,ss,1,Lx,Ly);
    xlim([70,110]);
    ylim([7,23]);
    cd(outdir);
    print('-r300','-dpng',['Te_anis_',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);
end
