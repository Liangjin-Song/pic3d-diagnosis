%% plot the ion density change at the front
% writen by Liangjin Song on 20191029
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
grids=1;
wci=0.000250;
c=0.6;
z0=12.5;

y0=2250;
top=2*di;
bottom=2*di;
left=3*di;
right=3*di;

tnt=zeros(1,nt);
tdv=zeros(1,nt);
tvn=zeros(1,nt);
tot=zeros(1,nt);

for t=1:nt
    cd(indir);
    tm=tt(t);
    tp=tm-dt;
    tn=tm+dt;

    vx=read_data('vxe',tm);
    vy=read_data('vye',tm);
    vz=read_data('vze',tm);
    n=read_data('Dense',tm);
    nn=read_data('Dense',tn);
    np=read_data('Dense',tp);

    bz=read_data('Bz',tm);
    bz=bz/c;
    bzp=read_data('Bz',tp);
    bzp=bzp/c;
    bzn=read_data('Bz',tn);
    bzn=bzn/c;

    nvx=vx.*n;
    nvy=vy.*n;
    nvz=vz.*n;
    dv=calc_divergence(nvx,nvy,nvz,grids);
    dv=-dv;

    [gx,gy,gz]=calc_gradient(n,grids);
    vn=vx.*gx+vy.*gy+vz.*gz;

    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);
    [~,xp]=max(lbzp);
    [~,xn]=max(lbzn);

    sdv=get_sub_matrix(dv,x0,y0,top,bottom,left,right);
    svn=get_sub_matrix(vn,x0,y0,top,bottom,left,right);
    snn=get_sub_matrix(nn,xn,y0,top,bottom,left,right);
    snp=get_sub_matrix(np,xp,y0,top,bottom,left,right);

    tnt(t)=(sum(sum(snn))-sum(sum(snp)))*wci;
    tdv(t)=sum(sum(sdv));
    tvn(t)=sum(sum(svn));
    tot(t)=tdv(t)+tvn(t);
end
lw=2;
figure;
plot(tt,tvn,'r','LineWidth',lw); hold on
plot(tt,tdv,'b','LineWidth',lw);
plot(tt,tot,'--k','LineWidth',lw);
plot(tt,tnt,'k','LineWidth',lw); hold off
legend('v_e \cdot \nabla Ne','-\nabla \cdot (n_ev_e)','Sum','dN_e/dt');
xlabel('\Omega_{ci}t');
ylabel('dN_e/dt');
cd(outdir);
