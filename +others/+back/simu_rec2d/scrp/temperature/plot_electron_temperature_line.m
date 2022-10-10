%% plot electron temperature line
% writen by Liangjin Song on 20190810 
clear;
indir='E:\Simulation\rec2d_M100SBg00Sx\data';
outdir='E:\Simulation\rec2d_M100SBg00Sx\out\line';
tt=50;
di=40;
z0=15;
c=0.6;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);
for t=1:nt
    cd(indir);
    p=read_data('prese',tt(t));
    n=read_data('Dense',tt(t));
    bz=read_data('Bz',tt(t));
    bz=bz/c;
    [pxx,~,~,pyy,~,pzz]=reshap_pressure(p,ndy,ndx);
    tp=calc_scalar_temperature(pxx,pyy,pzz,n);

    [lt,lx]=get_line_data(tp,Lx,Ly,z0,0.5/(3.6232e+04),0);
    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    xrange=[0,Lx];
    % xrange=[70,110];
    ylab='T_{e}';
    h=figure;
    set(h,'visible','off');
    plotyy_with_bz(lt,lbz,lx,ylab,xrange);

   cd(outdir);
   print('-r300','-dpng',['electron_temperature_t',num2str(tt(t),'%06.2f'),'.png']);
   close(gcf);
end
