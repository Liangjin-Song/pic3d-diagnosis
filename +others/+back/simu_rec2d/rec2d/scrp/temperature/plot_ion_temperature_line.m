%% plot ion temperature line
% writen by Liangjin Song on 20190810 
clear;
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M25SBg00Sx/out/line/T/Ti/';
tt=0:0.5:97;
di=20;
z0=25;
c=0.6;
ndx=4000;
ndy=2000;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);
for t=1:nt
    cd(indir);
    p=read_data('presi',tt(t));
    n=read_data('Densi',tt(t));
    bz=read_data('Bz',tt(t));
    bz=bz/c;
    [pxx,~,~,pyy,~,pzz]=reshap_pressure(p,ndy,ndx);
    tp=calc_scalar_temperature(pxx,pyy,pzz,n);

    [lt,lx]=get_line_data(tp,Lx,Ly,z0,1,0);
    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    xrange=[0,Lx];
    ylab='T_{i}';
    h=figure;
    set(h,'visible','off');
    plotyy_with_bz(lt,lbz,lx,ylab,xrange);

    cd(outdir);
    print('-r300','-dpng',['ion_temperature_t',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);
end
