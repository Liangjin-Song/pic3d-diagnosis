%% plot pressure, including thermal pressure and magnetic pressure
% writen by Liangjin Song on 20190921
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


[pixx,~,~,piyy,~,pizz]=reshap_pressure(pi,ndy,ndx);
[pexx,~,~,peyy,~,pezz]=reshap_pressure(pe,ndy,ndx);

[lpixx,ly]=get_line_data(pixx,Lx,Ly,x0,1,dirt);
[lpiyy,ly]=get_line_data(piyy,Lx,Ly,x0,1,dirt);
[lpizz,ly]=get_line_data(pizz,Lx,Ly,x0,1,dirt);

[lpexx,ly]=get_line_data(pexx,Lx,Ly,x0,1,dirt);
[lpeyy,ly]=get_line_data(peyy,Lx,Ly,x0,1,dirt);
[lpezz,ly]=get_line_data(pezz,Lx,Ly,x0,1,dirt);



lw=2;
subplot(3,2,1);
plot(lpixx,'r','LineWidth',lw);
xlim(xrange);
ylabel('Pixx');
set(gca,'xticklabel',[]);

subplot(3,2,3);
plot(lpiyy,'b','LineWidth',lw);
xlim(xrange);
ylabel('Piyy');
set(gca,'xticklabel',[]);

subplot(3,2,5);
plot(lpizz,'k','LineWidth',lw);
xlim(xrange);
ylabel('Pizz');

subplot(3,2,2);
plot(lpexx,'r','LineWidth',lw);
xlim(xrange);
ylabel('Pexx');
set(gca,'xticklabel',[]);

subplot(3,2,4);
plot(lpeyy,'b','LineWidth',lw);
xlim(xrange);
ylabel('Peyy');
set(gca,'xticklabel',[]);

subplot(3,2,6);
plot(lpezz,'k','LineWidth',lw);
xlim(xrange);
ylabel('Pezz');
%}




subplot(1,2,1);
plot(lpixx,'r','LineWidth',lw); hold on
plot(lpiyy,'g','LineWidth',lw);
plot(lpizz,'b','LineWidth',lw);
xlim(xrange);
ylabel('Pi');
legend('Pxx','Pyy','Pzz');

subplot(1,2,2);
plot(lpexx,'r','LineWidth',lw); hold on
plot(lpeyy,'g','LineWidth',lw);
plot(lpezz,'b','LineWidth',lw);
xlim(xrange);
ylabel('Pe');
legend('Pxx','Pyy','Pzz');




cd(outdir);
