%% analysis of Je dot E, plot energy conversion line at the DF
% writen by Liangjin Song on 20200601
clear;
prmfile='/data/simulation/rec2d_M100SBg00Sx/out/JeE/parm.m';
run(prmfile);
normje=qi*n0*vA*vA;

cd(indir);
vex=read_data('vxe',tt);
vey=read_data('vye',tt);
vez=read_data('vze',tt);
ne=read_data('Dense',tt);

% field
ex=read_data('Ex',tt);
ey=read_data('Ey',tt);
ez=read_data('Ez',tt);

bz=read_data('Bz',tt);
bz=bz/c;

[jex,jey,jez]=calc_plasma_current_density(qe,ne,vex,vey,vez);
jex=jex.*ex;
jey=jey.*ey;
jez=jez.*ez;
je=jex+jey+jez;

% line 
[lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,0);
[ljex,~]=get_line_data(jex,Lx,Ly,z0,normje,0);
[ljey,~]=get_line_data(jey,Lx,Ly,z0,normje,0);
[ljez,~]=get_line_data(jez,Lx,Ly,z0,normje,0);
[lje,~]=get_line_data(je,Lx,Ly,z0,normje,0);

nn=length(lx);
nzero=zeros(1,nn);

% figures
[ax,h1,h2]=plotyy(lx,[ljex;ljey;ljez;lje;nzero],lx,lbz);
fontsize=14;
linewidth=2;

% set y axes
set(ax(1),'XColor','k','YColor','k','FontSize',fontsize);
set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
set(ax,'XLim',xrange);
% set label
set(get(ax(1),'Ylabel'),'String','J_e \cdot E','Fontsize',fontsize);
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
hl=legend([h1(1:4);h2],'JexEx','JeyEy','JezEz','Je\cdot E','Bz');
% set(hl,'Orientation','horizon');
set(gca,'FontSize',fontsize)
set(gca,'Position',[.15 .16 .7 .8]);

cd(outdir);
