%% plot the beta value at the begining
% writen by Liangjin Song on 20190928
clear;
indir='/data/simulation/test/20190928/asy/data/';
outdir='/data/simulation/test/20190928/asy/out/';
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

xrange=[0,ndx/2];

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
[pxx,~,~,pyy,~,pzz]=reshap_pressure(p,ndy,ndx);
% pp=(pxx+pyy+pzz)/3;
pp=pzz;

%% magnetic pressure 
bt=bx.^2+by.^2+bz.^2;
bp=bt/(2*mu0);

[lbp,~]=get_line_data(bp,Lx,Ly,x0,1,dirt);
[lpp,~]=get_line_data(pp,Lx,Ly,x0,1,dirt);
lbeta=lpp./lbp;

lw=2;
plot(lbeta,'k','LineWidth',lw);
ylabel('Beta');
cd(outdir);
