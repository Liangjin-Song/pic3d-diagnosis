%% plot B, J dot E', Ey, Ve cross B, Vi cross B
% writen by Liangjin Song on 20191118
clear;
indir='/data/simulation/zhong/M100B01Bg05/data/';
outdir='/data/simulation/zhong/M100B01Bg05/out/';
tt=25;
c=0.6;
% wci=0.00075;
wci=0.0007499;
% di=40;
di=32.66;
Lx=1200/di;
Ly=1200/di;
vA=di*wci;
nt=length(tt);

qi=1;
qe=-qi;

ndx=600;
ndy=600;
xx=0:Lx/ndx:Lx-Lx/ndx;
yy=-Ly/2:Ly/ndy:Ly/2-Ly/ndy;

n0=225;

% nx0=427;
% ny0=281;
% k=2;

nx0=233;
% ny0=227;
ny0=273;
% ny0=140;
k=3;


% xrange=[160,300];
% xrange=[120,400];
% xrange=[190,290];
xrange=[11,18];
fs=12;

cd(indir);

bx=read_datat('Bx',tt);
bx=bx/c;
by=read_datat('By',tt);
by=by/c;
bz=read_datat('Bz',tt);
bz=bz/c;

ex=read_datat('Ex',tt);
ey=read_datat('Ey',tt);
ez=read_datat('Ez',tt);

vix=read_datat('vxi',tt);
viy=read_datat('vyi',tt);
viz=read_datat('vzi',tt);

vex=read_datat('vxe',tt);
vey=read_datat('vye',tt);
vez=read_datat('vze',tt);

ne=read_datat('Dense',tt);
ni=read_datat('Densi',tt);

%% current density
[jx,jy,jz]=calc_current_density(ni,ne,qi,qe,vix,viy,viz,vex,vey,vez);

%% J dot E'
% ed=calc_energy_dissipation(jx,jy,jz,ex,ey,ez,vix,viy,viz,bx,by,bz);
[ed,epx,epy,epz]=calc_energy_dissipation(jx,jy,jz,ex,ey,ez,vix,viy,viz,bx,by,bz);

%% vi and ve cross B
[cix,ciy,ciz]=calc_cross(vix,viy,viz,bx,by,bz);
ciy=-ciy;
[cex,cey,cez]=calc_cross(vex,vey,vez,bx,by,bz);
cey=-cey;

%% get the line
[sbx,sx,sy]=get_line_by_k(bx,nx0,ny0,k);

[svix,sx,sy]=get_line_by_k(vix,nx0,ny0,k);
[sviy,sx,sy]=get_line_by_k(viy,nx0,ny0,k);
[sviz,sx,sy]=get_line_by_k(viz,nx0,ny0,k);


[sed,sx,sy]=get_line_by_k(ed,nx0,ny0,k);
[sepx,sx,sy]=get_line_by_k(epx,nx0,ny0,k);
[sepy,sx,sy]=get_line_by_k(epy,nx0,ny0,k);
[sepz,sx,sy]=get_line_by_k(epz,nx0,ny0,k);

[sey,sx,sy]=get_line_by_k(ey,nx0,ny0,k);

[sciy,sx,sy]=get_line_by_k(ciy,nx0,ny0,k);

[scey,sx,sy]=get_line_by_k(cey,nx0,ny0,k);

sed=sed/(n0*vA*vA);
sepx=sepx/(n0*vA*vA);
sepy=sepy/(n0*vA*vA);
sepz=sepz/(n0*vA*vA);

svix=svix/vA;
sviy=sviy/vA;
sviz=sviz/vA;

sey=sey/vA;
sciy=sciy/vA;
scey=scey/vA;

sx=xx(sx(:));

thw=[0.008,0.13];
tlu=[0.10,0.03];
tlr=[0.18,0.05];
f1=figure(1);
set(f1,'Units','centimeter','Position',[10,10,14,20]);
ha1 = tight_subplot(4,1,thw,tlu,tlr);

axes(ha1(1));
plot(sx,sbx,'r','LineWidth',2); hold on
plot([0,1000],[0,0],'--k','LineWidth',2); hold off
xlim(xrange);
% ylim([-1,1]);
ylabel('B_x');
set(gca,'xticklabel',[]);
set(gca,'FontSize',fs);

axes(ha1(2));
plot(sx,svix,'r','LineWidth',2); hold on
plot(sx,sviy,'g','LineWidth',2);
plot(sx,sviz,'b','LineWidth',2);
plot([0,1000],[0,0],'--k','LineWidth',2); hold off
legend('Vix', 'Viy','Viz');
xlim(xrange);
ylabel('Vi');
set(gca,'xticklabel',[]);
set(gca,'FontSize',fs);


axes(ha1(3));
plot(sx,sed,'k','LineWidth',2); hold on
plot(sx,sepx,'r','LineWidth',2);
plot(sx,sepy,'g','LineWidth',2);
plot(sx,sepz,'b','LineWidth',2);
plot([0,1000],[0,0],'--k','LineWidth',2); hold off
legend('J_x \cdot E''','J_x \cdot E''_x','J_x \cdot E''_y','J_x \cdot E''_z');
xlim(xrange);
% ylim([-0.7,-0.4]);
ylabel('J \cdot E''');
set(gca,'xticklabel',[]);
set(gca,'FontSize',fs);

axes(ha1(4));
plot(sx,sey,'r','LineWidth',2); hold on
plot(sx,sciy,'g','LineWidth',2);
plot(sx,scey,'b','LineWidth',2);
plot([0,1000],[0,0],'--k','LineWidth',2); hold off
legend('E_y','(Vi \times B)_y', '(Ve \times B)_y');
xlim(xrange);
% set(gca,'xticklabel',[]);
xlabel('X [c/\omega_{pi}]');
set(gca,'FontSize',fs);

cd(outdir);
% print('-depsc','-painters','k=3_tight.eps');

