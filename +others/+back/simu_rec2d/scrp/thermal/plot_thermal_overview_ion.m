%% plot thermal energy density overview 
% writen by Liangjin Song on 20190517 
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/overview/thermal/ion/';
% tt=0:0.5:100;
tt=45;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);
for t=1:nt
    cd(indir);
    p=read_data('presi',tt(t));
    stream=read_data('stream',tt(t));
    [pxx,~,~,pyy,~,pzz]=reshap_pressure(p,ndy,ndx);
    U=calc_thermal_energy(pxx,pyy,pzz);
    plot_overview(U,stream,1,Lx,Ly);

%     cd(outdir);
%     print('-r300','-dpng',['ion_thermal_energy_t',num2str(tt(t),'%06.2f'),'.png']);
%     close(gcf);
end
