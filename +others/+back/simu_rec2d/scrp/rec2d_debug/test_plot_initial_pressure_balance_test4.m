%% plot pressure, including thermal pressure and magnetic pressure
% writen by Liangjin Song on 20190921
clear;
indir='/data/simulation/test/symmetric/data/';
outdir='/data/simulation/test/symmetric/out/';
tt=0;
c=0.6;
di=40;
ndx=1280;
ndy=1280;
Lx=ndx/di;
Ly=ndy/di;

x0=24;
dirt=1;

mu0=c^(-2);

xrange=[0,ndx/4];

cd(indir);

bx=read_datat('Bx',tt);
bx=bx/c;
by=read_datat('By',tt);
by=by/c;
bz=read_datat('Bz',tt);
bz=bz/c;

pe=read_datat('prese',tt);
pi=read_datat('presi',tt);


p=pe+pi;
% [pxx,~,~,pyy,~,pzz]=reshap_pressure(p,ndy,ndx);
[pxx,~,~,pyy,~,pzz]=reshap_pressure(p,ndy/2,ndx/2);
% pp=(pxx+pyy+pzz)/3;
pp=pzz/4;

%% magnetic pressure 
bt=bx.^2+by.^2+bz.^2;
bp=bt/(2*mu0);

[lbp,~]=get_line_data(bp,Lx,Ly,x0,1,dirt);
[lpp,ly]=get_line_data(pp,Lx,Ly,x0,1,dirt);

lp=lbp+lpp;

lw=2;
subplot(3,1,1);
plot(lbp,'r','LineWidth',lw);
xlim(xrange);
ylabel('Pb');
set(gca,'xticklabel',[]);

subplot(3,1,2);
plot(lpp,'b','LineWidth',lw);
xlim(xrange);
ylabel('Pt');
set(gca,'xticklabel',[]);

subplot(3,1,3);
plot(lp,'k','LineWidth',lw);
xlim(xrange);
ylabel('P_{total}');
cd(outdir);

