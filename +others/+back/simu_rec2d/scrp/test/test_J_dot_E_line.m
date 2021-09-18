%% plot J dot E, Ji dot E, Je dot E
% writen by Liangjin Song on 20191028
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/je/';
tt=45;
c=0.6;
n0=1304.33557;
wci=0.000750;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);
vA=di*wci;

qi=1;
qe=-1;

z0=15;
dirt=0;

cd(indir);

ex=read_data('Ex',tt);
ey=read_data('Ey',tt);
ez=read_data('Ez',tt);

ni=read_data('Densi',tt);
vix=read_data('vxi',tt);
viy=read_data('vyi',tt);
viz=read_data('vzi',tt);

ne=read_data('Dense',tt);
vex=read_data('vxe',tt);
vey=read_data('vye',tt);
vez=read_data('vze',tt);

jix=qi*(ni.*vix);
jiy=qi*(ni.*viy);
jiz=qi*(ni.*viz);

jex=qe*(ne.*vex);
jey=qe*(ne.*vey);
jez=qe*(ne.*vez);

jx=jix+jex;
jy=jiy+jey;
jz=jiz+jez;

ec=jx.*ex+jy.*ey+jz.*ez;
eci=jix.*ex+jiy.*ey+jiz.*ez;
ece=jex.*ex+jey.*ey+jez.*ez;

[lec,lx]=get_line_data(ec,Lx,Ly,z0,n0*vA*vA,dirt);
[leci,~]=get_line_data(eci,Lx,Ly,z0,n0*vA*vA,dirt);
[lece,~]=get_line_data(ece,Lx,Ly,z0,n0*vA*vA,dirt);

figure;
lw=2;
xrange=[104,112];
plot(lx,lec,'k','LineWidth',lw); hold on
plot(lx,leci,'r','LineWidth',lw);
plot(lx,lece,'b','LineWidth',lw);
plot([0,120],[0,0],'--y','LineWidth',1); hold off
xlim(xrange);
xlabel('X [c/\omega_{pi}]');
ylabel('J \cdot E');
legend('J \cdot E','Ji \cdot E','Je \cdot E');

cd(outdir);
