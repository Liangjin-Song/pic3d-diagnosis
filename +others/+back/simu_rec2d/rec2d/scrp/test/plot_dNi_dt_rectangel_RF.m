%% test the dNi/dt at the front
% writen by Liangjin Song on 20190916
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

tdn=zeros(1,nt);

for t=1:nt
    cd(indir);
    th=tt(t);
    tn=th+dt;
    tp=th-dt;

    np=read_data('Densi',tp);
    nn=read_data('Densi',tn);

    bzp=read_data('Bz',tp);
    bzp=bzp/c;
    bzn=read_data('Bz',tn);
    bzn=bzn/c;

    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [~,xp]=max(lbzp);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,xn]=max(lbzn);

    anp=get_sub_matrix(np,xp,y0,top,bottom,left,right);
    ann=get_sub_matrix(nn,xn,y0,top,bottom,left,right);

    tdn(t)=sum(sum(ann-anp))*wci;
end
figure;
plot(tt,tdn,'k','LineWidth',2);
xlabel('\Omega_{ci} t');
ylabel('dNi/dt at front');
cd(outdir);
