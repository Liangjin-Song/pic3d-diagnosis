%% plot the ion temperature overview 
% writen by Liangjin Song on 20190810 
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/Te_substructure/overview/';
tt=43;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);
for t=1:nt
    cd(indir);
    p=read_data('prese',tt(t));
    n=read_data('Dense',tt(t));
    ss=read_data('stream',tt(t));
    [pxx,~,~,pyy,~,pzz]=reshap_pressure(p,ndy,ndx);
    tp=calc_scalar_temperature(pxx,pyy,pzz,n);
    plot_overview(tp,ss,1,Lx,Ly);
    xlim([70,110]);
    ylim([7,23]);
    cd(outdir);
%    print('-r300','-dpng',['electron_temperature_t',num2str(tt(t),'%06.2f'),'.png']);
%     close(gcf);
end
