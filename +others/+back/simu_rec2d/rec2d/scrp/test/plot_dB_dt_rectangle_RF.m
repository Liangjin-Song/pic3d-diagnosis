%% test the dB/dt at the front
% writen by Liangjin Song on 20190916
%
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/test/';
dt=0.5;
tt=25:dt:55;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;

wci=0.000750;

nt=length(tt);
z0=15;
c=0.6;
grids=1;

y0=1800;
top=2*di;
bottom=2*di;
left=3*di;
right=3*di;

tdb=zeros(1,nt);

for t=1:nt
    cd(indir);
    th=tt(t);
    tn=th+dt;
    tp=th-dt;

    bxp=read_data('Bx',tp);
    bxp=bxp/c;
    byp=read_data('By',tp);
    byp=byp/c;
    bzp=read_data('Bz',tp);
    bzp=bzp/c;
    bxn=read_data('Bx',tn);
    bxn=bxn/c;
    byn=read_data('By',tn);
    byn=byn/c;
    bzn=read_data('Bz',tn);
    bzn=bzn/c;

    bp=sqrt(bxp.^2+byp.^2+bzp.^2);
    bn=sqrt(bxn.^2+byn.^2+bzn.^2);

    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [~,xp]=max(lbzp);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,xn]=max(lbzn);

    abp=get_sub_matrix(bp,xp,y0,top,bottom,left,right);
    abn=get_sub_matrix(bn,xn,y0,top,bottom,left,right);

    tdb(t)=sum(sum(abn-abp))*wci;
end
%}
figure;
plot(tt,tdb,'k','LineWidth',2);
xlabel('\Omega_{ci} t');
ylabel('dB/dt at front');
cd(outdir);
