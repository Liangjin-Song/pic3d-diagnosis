% plot the energy conversion at a certain time
% writen by Liangjin Song on 20200704
clear;
prmfile='/data/simulation/rec2d_M100SBg00Sx/out/JeE/parm.m';
run(prmfile);
norm=qi*n0*vA*vA;

cd(indir);
% ion
vix=read_data('vxi',tt);
viy=read_data('vyi',tt);
viz=read_data('vzi',tt);
ni=read_data('Densi',tt);
% electron
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

% current density 
[Jx,Jy,Jz]=calc_current_density(ni,ne,qi,qe,vix,viy,viz,vex,vey,vez);
[Jix,Jiy,Jiz]=calc_plasma_current_density(qi,ni,vix,viy,viz);
[Jex,Jey,Jez]=calc_plasma_current_density(qe,ne,vex,vey,vez);

% energy conversion 
Etot=calc_energy_conversion(Jx,Jy,Jz,ex,ey,ez);
Ei=calc_energy_conversion(Jix,Jiy,Jiz,ex,ey,ez);
Ee=calc_energy_conversion(Jex,Jey,Jez,ex,ey,ez);

% line 
[lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,0);
[lEt,~]=get_line_data(Etot,Lx,Ly,z0,norm,0);
[lEi,~]=get_line_data(Ei,Lx,Ly,z0,norm,0);
[lEe,~]=get_line_data(Ee,Lx,Ly,z0,norm,0);

nn=length(lx);
nzero=zeros(1,nn);

% figures
fontsize=14;
linewidth=2;
h=figure;
[ax,h1,h2]=plotyy(lx,[lEt;lEi;lEe;nzero],lx,lbz);

% set y axes
set(ax(1),'XColor','k','YColor','k','FontSize',fontsize);
set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
set(ax,'XLim',xrange);
% set label
set(get(ax(1),'Ylabel'),'String','J\cdot E','Fontsize',fontsize);
set(get(ax(2),'Ylabel'),'String','Bz','Fontsize',fontsize);
xlabel('X[c/\omega_{pi}]','FontSize',fontsize);
% set line
set(h1(1),'Color','k','LineWidth',linewidth);
set(h1(2),'Color','g','LineWidth',linewidth);
set(h1(3),'Color','b','LineWidth',linewidth);
set(h1(4),'Color','m','LineWidth',0.5);
set(h2,'Color','r','LineWidth',linewidth);
% set legend
set(gca,'Position',[.15 .16 .7 .8]);
hl=legend([h1(1:3);h2],'J\cdotE','Ji\cdotE','Je\cdotE','Bz','Location','SouthEast');
set(hl,'Orientation','horizon');

cd(outdir);
