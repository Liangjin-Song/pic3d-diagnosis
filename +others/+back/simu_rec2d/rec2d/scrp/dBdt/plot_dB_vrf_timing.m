%% plot the magnetic field variation at the front
% writen by Liangjin Song on 20191113
clear;
indir='/data/simulation/M100SBg00Sx_low_vte/ppc=100/';
outdir='/data/simulation/M100SBg00Sx_low_vte/out/ppc=100/dt/';
tt=25:0.5:60;
dt=0.5;

di=60;
ndx=6000;
ndy=3000;
Lx=ndx/di; Ly=ndy/di;
nt=length(tt);

z0=12.5;
c=0.6;
grids=1;
wci=0.000250;

qi=0.000667;
qe=-qi;

mu0=1/(c*c);

y0=2250;
top=2*di;
bottom=2*di;
left=3*di;
right=3*di;

db=zeros(1,nt);
tr=zeros(1,nt);
lc=zeros(1,nt);
co=zeros(1,nt);
to=zeros(1,nt);

for t=1:nt
    cd(indir);
    th=tt(t);
    tp=th-dt;
    tn=th+dt;

    % magnetic field
    bx=read_data('Bx',th);
    bx=bx/c;
    by=read_data('By',th);
    by=by/c;
    bz=read_data('Bz',th);
    bz=bz/c;

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

    % electric field
    ex=read_data('Ex',th);
    ey=read_data('Ey',th);
    ez=read_data('Ez',th);

    % ion velocity
    vix=read_data('vxi',th);
    viy=read_data('vyi',th);
    viz=read_data('vzi',th);

    % electric velocity
    vex=read_data('vxe',th);
    vey=read_data('vye',th);
    vez=read_data('vze',th);

    % density
    ni=read_data('Densi',th);
    ne=read_data('Dense',th);

    [comp,lcon,tran]=calc_dB_vrf_timing(bx,by,bz,ex,ey,ez,vix,viy,viz,vex,vey,vez,ni,ne,qi,qe,mu0,grids,bzp,bzn,Lx,Ly,z0,wci,di);

    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);
    % integrating in a rectangle
    scomp=get_sub_matrix(comp,x0,y0,top,bottom,left,right);
    slcon=get_sub_matrix(lcon,x0,y0,top,bottom,left,right);
    stran=get_sub_matrix(tran,x0,y0,top,bottom,left,right);

    % dB/dt
    bp=sqrt(bxp.^2+byp.^2+bzp.^2);
    bn=sqrt(bxn.^2+byn.^2+bzn.^2);

    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [~,x1]=max(lbzp);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,x2]=max(lbzn);

    sbp=get_sub_matrix(bp,x1,y0,top,bottom,left,right);
    sbn=get_sub_matrix(bn,x2,y0,top,bottom,left,right);

    db(t)=sum(sum(sbn-sbp))*wci;
    tr(t)=sum(sum(stran));
    lc(t)=sum(sum(slcon));
    co(t)=sum(sum(scomp));
    to(t)=tr(t)+lc(t)+co(t);
end
linewidth=2;
figure;
%{
plot(tt,co,'r','LineWidth',linewidth); hold on
plot(tt,lc,'g','LineWidth',linewidth);
plot(tt,tr,'b','LineWidth',linewidth);
%}
plot(tt,to,'k','LineWidth',linewidth); hold on
plot(tt,db,'--k','LineWidth',linewidth);
plot([0,100],[0,0],'--y','LineWidth',linewidth); hold off
% legend('-B\nabla \cdot v_E', '-\mu_0 J \cdot E/B', '(v_{RF}-2v_E) \cdot \nabla B', 'Sum', 'dB/dt', 'dB/dt=0');
legend('Sum', 'dB/dt', 'dB/dt=0');
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('dB/dt');
cd(outdir);
