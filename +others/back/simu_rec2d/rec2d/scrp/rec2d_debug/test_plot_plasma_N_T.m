%% plot ion and electron temperature and density
% writen by Liangjin Song on 20190927
clear;
indir='/data/simulation/test/20190928/asy_ppn1500/data/';
outdir='/data/simulation/test/20190928/asy_ppn1500/out/';
tt=0;
c=0.6;
di=40;
ndx=1280;
ndy=1280;
Lx=ndx/di;
Ly=ndy/di;

x0=24;
dirt=1;

% xrange=[ndy/4,ndy/2];
xrange=[0,ndy/2];

cd(indir);

ni=read_datat('Densi',tt);
ne=read_datat('Dense',tt);

pe=read_datat('prese',tt);
pi=read_datat('presi',tt);

[pixx,pixy,pixz,piyy,piyz,pizz]=reshap_pressure(pi,ndy,ndx);
% [pixx,pixy,pixz,piyy,piyz,pizz]=reshap_pressure(pi,ndy/2,ndx/2);
ti=calc_scalar_temperature(pixx,piyy,pizz,ni);

[pexx,pexy,pexz,peyy,peyz,pezz]=reshap_pressure(pe,ndy,ndx);
% [pexx,pexy,pexz,peyy,peyz,pezz]=reshap_pressure(pe,ndy/2,ndx/2);
te=calc_scalar_temperature(pexx,peyy,pezz,ne);

[lni,~]=get_line_data(ni,Lx,Ly,x0,1,dirt);
[lti,~]=get_line_data(ti,Lx,Ly,x0,1,dirt);
[lpixx,~]=get_line_data(pixx,Lx,Ly,x0,1,dirt);
[lpiyy,~]=get_line_data(piyy,Lx,Ly,x0,1,dirt);
[lpizz,~]=get_line_data(pizz,Lx,Ly,x0,1,dirt);

[lne,~]=get_line_data(ne,Lx,Ly,x0,1,dirt);
[lte,~]=get_line_data(te,Lx,Ly,x0,1,dirt);
[lpexx,~]=get_line_data(pexx,Lx,Ly,x0,1,dirt);
[lpeyy,~]=get_line_data(peyy,Lx,Ly,x0,1,dirt);
[lpezz,~]=get_line_data(pezz,Lx,Ly,x0,1,dirt);

lw=2;
subplot(3,2,1);
plot(lni,'k','LineWidth',lw);
xlim(xrange);
ylabel('Ni');
set(gca,'xticklabel',[]);

subplot(3,2,3);
plot(lti,'k','LineWidth',lw);
xlim(xrange);
ylabel('Ti');
set(gca,'xticklabel',[]);

subplot(3,2,5)
plot(lpixx,'r','LineWidth',lw); hold on
plot(lpiyy,'g','LineWidth',lw);
plot(lpizz,'b','LineWidth',lw);
xlim(xrange);
ylabel('Pi');
legend('Pxx','Pyy','Pzz');

subplot(3,2,2);
plot(lne,'k','LineWidth',lw);
xlim(xrange);
ylabel('Ne');
set(gca,'xticklabel',[]);

subplot(3,2,4);
plot(lte,'k','LineWidth',lw);
xlim(xrange);
ylabel('Te');
set(gca,'xticklabel',[]);

subplot(3,2,6)
plot(lpexx,'r','LineWidth',lw); hold on
plot(lpeyy,'g','LineWidth',lw);
plot(lpezz,'b','LineWidth',lw);
xlim(xrange);
ylabel('Pe');
legend('Pxx','Pyy','Pzz');

cd(outdir);
