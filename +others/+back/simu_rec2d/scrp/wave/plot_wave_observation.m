%% the wave observation at a position
% writen by Liangjin Song on 20190918
%
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/wave/';
tt=0:0.5:55;
dt=0.5;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di; Ly=ndy/di;
nt=length(tt);
z0=15;
c=0.6;
grids=1;
wci=0.000750;

x0=4400;
y0=1600;
top=0.1*di;
bottom=0.1*di;
left=0.1*di;
right=0.1*di;

tbx=zeros(1,nt);
tby=zeros(1,nt);
tbz=zeros(1,nt);
tb=zeros(1,nt);

tex=zeros(1,nt);
tey=zeros(1,nt);
tez=zeros(1,nt);
te=zeros(1,nt);

tni=zeros(1,nt);
tne=zeros(1,nt);

for t=1:nt
    cd(indir);
    tm=tt(t);

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

    sbx=get_sub_matrix(bx,x0,y0,top,bottom,left,right);
    sby=get_sub_matrix(by,x0,y0,top,bottom,left,right);
    sbz=get_sub_matrix(bz,x0,y0,top,bottom,left,right);
    sb=get_sub_matrix(b,x0,y0,top,bottom,left,right);

    sex=get_sub_matrix(ex,x0,y0,top,bottom,left,right);
    sey=get_sub_matrix(ey,x0,y0,top,bottom,left,right);
    sez=get_sub_matrix(ez,x0,y0,top,bottom,left,right);
    se=get_sub_matrix(e,x0,y0,top,bottom,left,right);

    sni=get_sub_matrix(ni,x0,y0,top,bottom,left,right);
    sne=get_sub_matrix(ne,x0,y0,top,bottom,left,right);

    tbx(t)=sum(sum(sbx));
    tby(t)=sum(sum(sby));
    tbz(t)=sum(sum(sbz));
    tb(t)=sum(sum(sb));

    tex(t)=sum(sum(sex));
    tey(t)=sum(sum(sey));
    tez(t)=sum(sum(sez));
    te(t)=sum(sum(se));

    tni(t)=sum(sum(sni));
    tne(t)=sum(sum(sne));
end
lw=2;
%}
xrange=[tt(1),tt(end)];
h=figure;
subplot(5,2,1);
plot(tt,tbx,'r','LineWidth',lw);
ylabel('Bx');
set(gca,'xtick',[])
xlim(xrange);

subplot(5,2,3);
plot(tt,tby,'g','LineWidth',lw);
ylabel('By');
set(gca,'xtick',[])
xlim(xrange);

subplot(5,2,5);
plot(tt,tbz,'b','LineWidth',lw);
ylabel('Bz');
set(gca,'xtick',[])
xlim(xrange);

subplot(5,2,7);
plot(tt,tb,'k','LineWidth',lw);
ylabel('B');
set(gca,'xtick',[])
xlim(xrange);

subplot(5,2,2);
plot(tt,tex,'r','LineWidth',lw);
ylabel('Ex');
set(gca,'xtick',[])
xlim(xrange);

subplot(5,2,4);
plot(tt,tey,'g','LineWidth',lw);
ylabel('Ey');
set(gca,'xtick',[])
xlim(xrange);

subplot(5,2,6);
plot(tt,tez,'b','LineWidth',lw);
ylabel('Ez');
set(gca,'xtick',[])
xlim(xrange);

subplot(5,2,8);
plot(tt,te,'k','LineWidth',lw);
ylabel('E');
set(gca,'xtick',[])
xlim(xrange);

subplot(5,2,9);
plot(tt,tni,'r','LineWidth',lw);
ylabel('Ni');
xlabel('\Omega_{ci}t')
xlim(xrange);

subplot(5,2,10);
plot(tt,tne,'g','LineWidth',lw);
ylabel('Ne');
xlabel('\Omega_{ci}t')
xlim(xrange);

annotation(h,'textbox',...
    [0.472772277227723 0.942844493309572 0.0967821754810245 0.0399568025867574],...
    'String',{'X=110di  Y=10di'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

cd(outdir);
