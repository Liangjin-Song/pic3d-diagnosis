%% plot Bz line of the RF
% writen by Liangjin Song on 20190624 
%
%{
indir='/home/liangjin/Simulation/AsyBg0/rec2d_M25B1.5T06Bs6Bg00/data/';
outdir='/home/liangjin/Simulation/AsyBg0/rec2d_M25B1.5T06Bs6Bg00/out/line/bz/';
rf_file='/home/liangjin/Simulation/AsyBg0/rec2d_M25B1.5T06Bs6Bg00/out/RF/RF_position.txt';
c=0.6;
ndx=2400;
ndy=1200;
di=2.3*5;
%}
indir='/home/liangjin/Simulation/AsyBg0/rec2d_M400B1.5T06Bs6Bg00/data/v2/';
outdir='/home/liangjin/Simulation/AsyBg0/rec2d_M400B1.5T06Bs6Bg00/out/line/bz/';
rf_file='/home/liangjin/Simulation/AsyBg0/rec2d_M400B1.5T06Bs6Bg00/out/RF/RF_position.txt';
c=0.6;
ndx=6000;
ndy=3000;
di=1.724*20;

Lx=ndx/di;
Ly=ndy/di;
xrange=[Lx/2,Lx];

% time and RF position in z direction 
rf=importdata(rf_file);
tt=rf.data(:,1);
pz=rf.data(:,2);
nt=length(tt);

for t=1:nt
    cd(indir);
    bz=read_data('Bz',tt(t));
    [lbz,lx]=get_line_data(bz,Lx,Ly,pz(t),c,0);

    plot(lx,lbz,'k','LineWidth',1);
    xlabel('X[c/\omega_{pi}]');
    ylabel('Bz');
    xlim(xrange);
    set(gca,'FontSize',16);
    cd(outdir);
    print('-r300','-dpng',['Bz_t',num2str(tt(t),'%06.2f'),'.png']);
    close(gcf);
end
