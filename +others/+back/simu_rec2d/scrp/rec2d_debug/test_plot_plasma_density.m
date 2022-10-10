%% plot ion and electron temperature and density
% writen by Liangjin Song on 20190927
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

% xrange=[ndy/4,ndy/2];
xrange=[0,ndy/2];

cd(indir);

ni=read_datat('Densi',tt);
ne=read_datat('Dense',tt);



[lni,~]=get_line_data(ni,Lx,Ly,x0,1,dirt);
[lne,~]=get_line_data(ne,Lx,Ly,x0,1,dirt);

%{
lw=2;
subplot(2,2,1);
plot(lni,'k','LineWidth',lw);
xlim(xrange);
ylabel('Ni');
set(gca,'xticklabel',[]);

subplot(2,2,3);
plot(lti,'k','LineWidth',lw);
xlim(xrange);
ylabel('Ti');
set(gca,'xticklabel',[]);

subplot(2,2,2);
plot(lne,'k','LineWidth',lw);
xlim(xrange);
ylabel('Ne');

subplot(2,2,4);
plot(lte,'k','LineWidth',lw);
xlim(xrange);
ylabel('Te');
%}

plot(lni,'r'); hold on
plot(lne,'g');

cd(outdir);
