%% the wave observation at a position
% writen by Liangjin Song on 20190918
%
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/wave/';
tt=54;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di; Ly=ndy/di;
z0=15;
c=0.6;
grids=1;
wci=0.000750;
norm=1;

cd(indir);
tm=tt;

bx=read_data('Bx',tm);
bx=bx/c;
by=read_data('By',tm);
by=by/c;
bz=read_data('Bz',tm);
bz=bz/c;
b=sqrt(bx.^2+by.^2+bz.^2);

ex=read_data('Ex',tm);
ey=read_data('Ey',tm);
ez=read_data('Ez',tm);
e=sqrt(ex.^2+ey.^2+ez.^2);

ni=read_data('Densi',tm);
ne=read_data('Dense',tm);

[lbx,lx]=get_line_data(bx,Lx,Ly,z0,norm,0);
[lby,~]=get_line_data(by,Lx,Ly,z0,norm,0);
[lbz,~]=get_line_data(bz,Lx,Ly,z0,norm,0);
[lb,~]=get_line_data(b,Lx,Ly,z0,norm,0);

[lex,~]=get_line_data(ex,Lx,Ly,z0,norm,0);
[ley,~]=get_line_data(ey,Lx,Ly,z0,norm,0);
[lez,~]=get_line_data(ez,Lx,Ly,z0,norm,0);
[le,~]=get_line_data(e,Lx,Ly,z0,norm,0);

[lni,~]=get_line_data(ni,Lx,Ly,z0,norm,0);
[lne,~]=get_line_data(ne,Lx,Ly,z0,norm,0);

lw=2;
xrange=[40,120];
h=figure;
subplot(5,2,1);
plot(lx,lbx,'r','LineWidth',lw);
ylabel('Bx');
set(gca,'xtick',[])
xlim(xrange);

subplot(5,2,3);
plot(lx,lby,'g','LineWidth',lw);
ylabel('By');
set(gca,'xtick',[])
xlim(xrange);

subplot(5,2,5);
plot(lx,lbz,'b','LineWidth',lw);
ylabel('Bz');
set(gca,'xtick',[])
xlim(xrange);

subplot(5,2,7);
plot(lx,lb,'k','LineWidth',lw);
ylabel('B');
set(gca,'xtick',[])
xlim(xrange);

subplot(5,2,2);
plot(lx,lex,'r','LineWidth',lw);
ylabel('Ex');
set(gca,'xtick',[])
xlim(xrange);

subplot(5,2,4);
plot(lx,ley,'g','LineWidth',lw);
ylabel('Ey');
set(gca,'xtick',[])
xlim(xrange);

subplot(5,2,6);
plot(lx,lez,'b','LineWidth',lw);
ylabel('Ez');
set(gca,'xtick',[])
xlim(xrange);

subplot(5,2,8);
plot(lx,le,'k','LineWidth',lw);
ylabel('E');
set(gca,'xtick',[])
xlim(xrange);

subplot(5,2,9);
plot(lx,lni,'r','LineWidth',lw);
ylabel('Ni');
xlabel('X [c/\omega_{pi}]')
xlim(xrange);

subplot(5,2,10);
plot(lx,lne,'g','LineWidth',lw);
ylabel('Ne');
xlabel('X [c/\omega_{pi}]')
xlim(xrange);

annotation(h,'textbox',...
    [0.472772277227723 0.942844493309572 0.0967821754810245 0.0399568025867574],...
    'String',{'\Omega_{ci}t=54'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

cd(outdir);
