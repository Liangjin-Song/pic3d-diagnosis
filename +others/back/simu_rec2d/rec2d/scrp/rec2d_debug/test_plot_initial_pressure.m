%% plot pressure, including thermal pressure and magnetic pressure
% writen by Liangjin Song on 20190921
clear;
indir='/data/simulation/test/asymmetric_norelitivity/data/';
outdir='/data/simulation/test/asymmetric_norelitivity/out/';
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

bx=read_data('Bx',tt);
bx=bx/c;
by=read_data('By',tt);
by=by/c;
bz=read_data('Bz',tt);
bz=bz/c;

pe=read_data('prese',tt);
pi=read_data('presi',tt);


p=pe+pi;
[pxx,~,~,pyy,~,pzz]=reshap_pressure(p,ndy/2,ndx/2);

[lpxx,ly]=get_line_data(pxx,Lx,Ly,x0,1,dirt);
[lpyy,ly]=get_line_data(pyy,Lx,Ly,x0,1,dirt);
[lpzz,ly]=get_line_data(pzz,Lx,Ly,x0,1,dirt);

lw=2;
subplot(3,1,1);
plot(lpxx,'r','LineWidth',lw);
xlim(xrange);
ylabel('Pxx');
set(gca,'xticklabel',[]);

subplot(3,1,2);
plot(lpyy,'b','LineWidth',lw);
xlim(xrange);
ylabel('Pyy');
set(gca,'xticklabel',[]);

subplot(3,1,3);
plot(lpzz,'k','LineWidth',lw);
xlim(xrange);
ylabel('Pzz');

cd(outdir);
