%% plot pressure, including thermal pressure and magnetic pressure
% writen by Liangjin Song on 20190921
clear;
indir='/data/simulation/rec2d_M100B02T02Bs6Bg10/data/';
outdir='/data/simulation/rec2d_M100B02T02Bs6Bg10/out/zhong/';
tt0=0;
tt1=50;
c=0.6;
wci=0.0005;
di=34.64;
ndx=2400;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
vA=di*wci;

x0=21;
dirt=1;

mu0=c^(-2);

xrange=[200,400];

cd(indir);

%% 0
bx0=read_data('Bx',tt0);
bx0=bx0/c;
by0=read_data('By',tt0);
by0=by0/c;
bz0=read_data('Bz',tt0);
bz0=bz0/c;

pe0=read_data('prese',tt0);
pi0=read_data('presi',tt0);

%% 1
bx1=read_data('Bx',tt1);
bx1=bx1/c;
by1=read_data('By',tt1);
by1=by1/c;
bz1=read_data('Bz',tt1);
bz1=bz1/c;

pe1=read_data('prese',tt1);
pi1=read_data('presi',tt1);

%% thermal
p0=pe0+pi0;
p1=pe1+pi1;
[pxx0,~,~,pyy0,~,pzz0]=reshap_pressure(p0,ndy/2,ndx/2);
pp0=(pxx0+pyy0+pzz0)/3;

[pxx1,~,~,pyy1,~,pzz1]=reshap_pressure(p1,ndy/2,ndx/2);
pp1=(pxx1+pyy1+pzz1)/3;

%% magnetic pressure 
bt0=bx0.^2+by0.^2+bz0.^2;
bt1=bx1.^2+by1.^2+bz1.^2;

bp0=bt0/(2*mu0);
bp1=bt1/(2*mu0);

[lbp0,ly]=get_line_data(bp0,Lx,Ly,x0,1,dirt);
[lbp1,ly]=get_line_data(bp1,Lx,Ly,x0,1,dirt);

[lpp0,ly]=get_line_data(pp0,Lx,Ly,x0,1,dirt);
[lpp1,ly]=get_line_data(pp1,Lx,Ly,x0,1,dirt);

lp0=lbp0+lpp0;
lp1=lbp1+lpp1;

lw=2;
subplot(3,2,1);
plot(lbp0,'r','LineWidth',lw);
xlim(xrange);
ylabel('Pb');
set(gca,'xticklabel',[]);

subplot(3,2,3);
plot(lpp0,'b','LineWidth',lw);
xlim(xrange);
ylabel('Pt');
set(gca,'xticklabel',[]);

subplot(3,2,5);
plot(lp0,'k','LineWidth',lw);
xlim(xrange);
ylabel('P_{total}');

subplot(3,2,2);
plot(lbp1,'r','LineWidth',lw);
xlim(xrange);
ylabel('Pb');
set(gca,'xticklabel',[]);

subplot(3,2,4);
plot(lpp1,'b','LineWidth',lw);
xlim(xrange);
ylabel('Pt');
set(gca,'xticklabel',[]);

subplot(3,2,6);
plot(lp1,'k','LineWidth',lw);
xlim(xrange);
ylabel('P_{total}');
