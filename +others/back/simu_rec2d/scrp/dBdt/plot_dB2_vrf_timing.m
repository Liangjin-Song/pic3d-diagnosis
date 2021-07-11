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

tdb=zeros(1,nt);
tje=zeros(1,nt);
teb=zeros(1,nt);
tco=zeros(1,nt);
tot=zeros(1,nt);

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

    [je,eb,co]=calc_dB2_vrf_timing(bx,by,bz,ex,ey,ez,ni,ne,vix,viy,viz,vex,vey,vez,qi,qe,mu0,grids,bzp,bzn,Lx,Ly,z0,wci,di);

    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);
    % integrating in a rectangle
    sje=get_sub_matrix(je,x0,y0,top,bottom,left,right);
    seb=get_sub_matrix(eb,x0,y0,top,bottom,left,right);
    sco=get_sub_matrix(co,x0,y0,top,bottom,left,right);

    % dB/dt
    b2p=bxp.^2+byp.^2+bzp.^2;
    b2n=bxn.^2+byn.^2+bzn.^2;

    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [~,x1]=max(lbzp);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,x2]=max(lbzn);

    sb2p=get_sub_matrix(b2p,x1,y0,top,bottom,left,right);
    sb2n=get_sub_matrix(b2n,x2,y0,top,bottom,left,right);

    tdb(t)=sum(sum(sb2n-sb2p))*wci;
    tje(t)=sum(sum(sje));
    teb(t)=sum(sum(seb));
    tco(t)=sum(sum(sco));
    tot(t)=tje(t)+teb(t)+tco(t);
end
linewidth=2;
figure;
plot(tt,tot,'k','LineWidth',linewidth); hold on
%{
plot(tt,tje,'r','LineWidth',linewidth);
plot(tt,teb,'g','LineWidth',linewidth);
plot(tt,tco,'b','LineWidth',linewidth);
%}
plot(tt,tdb,'--k','LineWidth',linewidth);
plot([0,100],[0,0],'--y','LineWidth',linewidth); hold off
% legend('-2 \mu_0 J \cdot E', '-2 \nabla \cdot (E \times B)', 'v_{RF} \cdot \nabla B^2', 'Sum', 'dB^2/dt','dB^2/dt = 0');
legend('Sum', 'dB^2/dt','dB^2/dt = 0');
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('dB^2/dt');
cd(outdir);
