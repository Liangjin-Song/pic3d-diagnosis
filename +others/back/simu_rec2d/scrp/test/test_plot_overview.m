%% plot overview of one moment 
% writen by Liangjin Song on 20190624
tt=20:50;
indir='/home/liangjin/Simulation/AsyBg0/rec2d_M400B1.5T06Bs6Bg00/data/v2/';
c=0.6;
ndx=6000;
ndy=3000;
di=1.724*20;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);
xrange=[Lx/2,Lx];
yrange=[0,Ly/2];
for t=1:nt
    cd(indir);
    ss=read_data('stream',tt(t));
    bz=read_data('Bz',tt(t));
    bx=read_data('Bx',tt(t));
    [~,lx]=get_line_data(bz,Lx,Ly,0,1,0);
    [~,lz]=get_line_data(bz,Lx,Ly,0,1,1);
    index=get_current_sheet_index(bx,1);
    cs=lz(index(:));
    plot_overview(bz,ss,c,Lx,Ly); hold on
    title(['\Omegat=',num2str(tt(t))]);
    plot(lx,cs,'r','LineWidth',1);
    xlim(xrange);
    ylim(yrange);
    set(gcf,'Position',get(0,'ScreenSize'));
    pause
end
