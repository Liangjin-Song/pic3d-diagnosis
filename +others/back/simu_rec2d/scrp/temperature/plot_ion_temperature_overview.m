%% plot the ion temperature overview 
% writen by Liangjin Song on 20190810 
clear;
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M25SBg00Sx/out/overivew/T/Ti/';
tt=0:0.5:97;
di=20;
ndx=4000;
ndy=2000;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);
for t=1:nt
    cd(indir);
    p=read_data('presi',tt(t));
    n=read_data('Densi',tt(t));
    ss=read_data('stream',tt(t));
    [pxx,~,~,pyy,~,pzz]=reshap_pressure(p,ndy,ndx);
    tp=calc_scalar_temperature(pxx,pyy,pzz,n);
    plot_overview(tp,ss,1,Lx,Ly);
    cd(outdir);
    print('-r300','-dpng',['ion_temperature_t',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);
end
