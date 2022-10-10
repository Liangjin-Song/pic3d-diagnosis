%% analysis of Je dot E, plot electric field line at the DF
% writen by Liangjin Song on 20200601
clear;
prmfile='/data/simulation/rec2d_M100SBg00Sx/out/JeE/parm.m';
run(prmfile);
norme=vA;

cd(indir);
% field
ex=read_data('Ex',tt);
ey=read_data('Ey',tt);
ez=read_data('Ez',tt);

bz=read_data('Bz',tt);
bz=bz/c;

[lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,0);
[lex,~]=get_line_data(ex,Lx,Ly,z0,norme,0);
[ley,~]=get_line_data(ey,Lx,Ly,z0,norme,0);
[lez,~]=get_line_data(ez,Lx,Ly,z0,norme,0);

nn=length(lx);
nzero=zeros(1,nn);

% figures
[ax,h1,h2]=plotyy(lx,[lex;ley;lez;nzero],lx,lbz);
fontsize=14;
linewidth=2;

% set y axes
set(ax(1),'XColor','k','YColor','k','FontSize',fontsize);
set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
set(ax,'XLim',xrange);
% set label
set(get(ax(1),'Ylabel'),'String','E','Fontsize',fontsize);
set(get(ax(2),'Ylabel'),'String','Bz','Fontsize',fontsize);
xlabel('X[c/\omega_{pi}]','FontSize',fontsize);
% set line
set(h1(1),'Color','m','LineWidth',linewidth);
set(h1(2),'Color','g','LineWidth',linewidth);
set(h1(3),'Color','b','LineWidth',linewidth);
% set(h1(4),'Color','k','LineWidth',linewidth);
% set(h1(5),'Color','k','LineWidth',1);
set(h2,'Color','r','LineWidth',linewidth);
% set legend
hl=legend([h1(1:3);h2],'Ex','Ey','Ez','Bz');
% set(hl,'Orientation','horizon');
set(gca,'Position',[.15 .16 .7 .8]);

cd(outdir);
