%% plot dTe/dt at the front
% writen by Liangjin Song on 20190810 
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/temperature/ion/time/';
tt=30:0.5:55;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di; Ly=ndy/di;
nt=length(tt);
z0=15;
c=0.6;
grids=1;
wci=0.000750;

y0=1800;
top=2*di;
bottom=2*di;
left=3*di;
right=3*di;

tthf=zeros(1,nt);
ttst=zeros(1,nt);
ttpn=zeros(1,nt);
ttbc=zeros(1,nt);
ttco=zeros(1,nt);
ttot=zeros(1,nt);

for t=1:nt
    cd(indir);
    tm=tt(t);
    p=read_data('presi',tm);
    qflux=read_data('qfluxi',tm);

    vx=read_data('vxi',tm);
    vy=read_data('vyi',tm);
    vz=read_data('vzi',tm);

    n=read_data('Densi',tm);

    bx=read_data('Bx',tm);
    bx=bx/c;
    by=read_data('By',tm);
    by=by/c;
    bz=read_data('Bz',tm);
    bz=bz/c;

    ex=read_data('Ex',tm);
    ey=read_data('Ey',tm);
    ez=read_data('Ez',tm);

    [T,hfx,tst,tpn,bct,con]=calc_dT_dt(p,qflux,vx,vy,vz,n,bx,by,bz,ex,ey,ez,grids,Lx,Ly,z0);

    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);
    % integrating in a rectangle
    shfx=get_sub_matrix(hfx,x0,y0,top,bottom,left,right);
    stst=get_sub_matrix(tst,x0,y0,top,bottom,left,right);
    stpn=get_sub_matrix(tpn,x0,y0,top,bottom,left,right);
    sbct=get_sub_matrix(bct,x0,y0,top,bottom,left,right);
    scon=get_sub_matrix(con,x0,y0,top,bottom,left,right);

    tthf(t)=sum(sum(shfx));
    ttst(t)=sum(sum(stst));
    ttpn(t)=sum(sum(stpn));
    ttbc(t)=sum(sum(sbct));
    ttco(t)=sum(sum(scon));
    ttot(t)=tthf(t)+ttst(t)+ttpn(t)+ttbc(t)+ttco(t);
end
linewidth=2;
figure;
plot(tt,tthf,'r','LineWidth',linewidth); hold on
plot(tt,ttst,'g','LineWidth',linewidth);
plot(tt,ttpn,'b','LineWidth',linewidth);
plot(tt,ttbc,'c','LineWidth',linewidth);
plot(tt,ttco,'m','LineWidth',linewidth);
plot(tt,ttot,'k','LineWidth',linewidth);
plot([0,100],[0,0],'--r','LineWidth',linewidth); hold off
xlim([tt(1),tt(end)]);
legend('-2*\nabla \cdot q_{i}/3*n_{i}','-2*(P''_{i}\cdot \nabla) \cdot v_{i}/3*n_{i}','-2*p_{i}\nabla \cdot v_{i}/3*n_{i}','-v_{i}\cdot \nabla T_{i}','v_{RF}\cdot \nabla T_{i}','Sum','dT_{i}/dt=0','Location','Best');
xlabel('\Omega_{ci}t');
ylabel('dT_{i}/dt');
cd(outdir);
