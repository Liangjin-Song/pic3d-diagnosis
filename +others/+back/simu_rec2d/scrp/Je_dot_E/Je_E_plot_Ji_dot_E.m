%% analysis of Ji dot E, plot energy conversion line at the DF
% writen by Liangjin Song on 20200704
clear;
prmfile='/data/simulation/rec2d_M100SBg00Sx/out/JeE/parm.m';
run(prmfile);
normje=qi*n0*vA*vA;

cd(indir);
vix=read_data('vxi',tt);
viy=read_data('vyi',tt);
viz=read_data('vzi',tt);
ni=read_data('Densi',tt);

% field
ex=read_data('Ex',tt);
ey=read_data('Ey',tt);
ez=read_data('Ez',tt);

bz=read_data('Bz',tt);
bz=bz/c;

[jix,jiy,jiz]=calc_plasma_current_density(qi,ni,vix,viy,viz);
jix=jix.*ex;
jiy=jiy.*ey;
jiz=jiz.*ez;
ji=jix+jiy+jiz;

% line 
[lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,0);
[ljix,~]=get_line_data(jix,Lx,Ly,z0,normje,0);
[ljiy,~]=get_line_data(jiy,Lx,Ly,z0,normje,0);
[ljiz,~]=get_line_data(jiz,Lx,Ly,z0,normje,0);
[lji,~]=get_line_data(ji,Lx,Ly,z0,normje,0);

nn=length(lx);
nzero=zeros(1,nn);

% figures
[ax,h1,h2]=plotyy(lx,[ljix;ljiy;ljiz;lji;nzero],lx,lbz);
fontsize=14;
linewidth=2;

% set y axes
set(ax(1),'XColor','k','YColor','k','FontSize',fontsize);
set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
set(ax,'XLim',xrange);
% set label
set(get(ax(1),'Ylabel'),'String','J_i \cdot E','Fontsize',fontsize);
set(get(ax(2),'Ylabel'),'String','Bz','Fontsize',fontsize);
xlabel('X[c/\omega_{pi}]','FontSize',fontsize);
% set line
set(h1(1),'Color','m','LineWidth',linewidth);
set(h1(2),'Color','g','LineWidth',linewidth);
set(h1(3),'Color','b','LineWidth',linewidth);
set(h1(4),'Color','k','LineWidth',linewidth);
% set(h1(5),'Color','k','LineWidth',1);
set(h2,'Color','r','LineWidth',linewidth);
% set legend
hl=legend([h1(1:4);h2],'JixEx','JiyEy','JizEz','Ji\cdot E','Bz');
% set(hl,'Orientation','horizon');
set(gca,'FontSize',fontsize)
set(gca,'Position',[.15 .16 .7 .8]);

cd(outdir);
