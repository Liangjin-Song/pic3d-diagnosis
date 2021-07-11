%% plot the magnetic field square variation at the front
% writen by Liangjin Song on 20191113
indir='/data/simulation/M100SBg00Sx_low_vte/ppc=100/';
outdir='/data/simulation/M100SBg00Sx_low_vte/out/ppc=100/partial/';
tt=10:0.5:50;
dt=0.5;
di=60;
ndx=6000;
ndy=3000;
Lx=ndx/di;
Ly=ndy/di;
% electron
qi=0.000667;
qe=-qi;
wci=0.000250;
nt=length(tt);
c=0.6;
grids=1;
mu0=1/(c*c);

x0=4500;
y0=2250;
top=1.5*di;
bottom=1.5*di;
left=2*di;
right=2*di;

tje=zeros(1,nt);
teb=zeros(1,nt);
tot=zeros(1,nt);
tb2=zeros(1,nt);

for t=1:nt
    cd(indir);
    th=tt(t);
    tn=th+dt;
    tp=th-dt;

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

    [je,eb]=calc_partial_B2_t(bx,by,bz,ex,ey,ez,ni,ne,vix,viy,viz,vex,vey,vez,qi,qe,mu0,grids);
    sje=get_sub_matrix(je,x0,y0,top,bottom,left,right);
    seb=get_sub_matrix(eb,x0,y0,top,bottom,left,right);
    
    b2p=bxp.^2+byp.^2+bzp.^2;
    b2n=bxn.^2+byn.^2+bzn.^2;
    sb2p=get_sub_matrix(b2p,x0,y0,top,bottom,left,right);
    sb2n=get_sub_matrix(b2n,x0,y0,top,bottom,left,right);

    tb2(t)=sum(sum(sb2n-sb2p))*wci;
    tje(t)=sum(sum(sje));
    teb(t)=sum(sum(seb));
    tot(t)=tje(t)+teb(t);
end
linewidth=2;
figure;
plot(tt,tje,'r','LineWidth',linewidth); hold on
plot(tt,teb,'b','LineWidth',linewidth);
plot(tt,tot,'k','LineWidth',linewidth);
plot(tt,tb2,'--k','LineWidth',linewidth);
plot([0,100],[0,0],'--y','LineWidth',linewidth); hold off
legend('-2 \mu_0 J \cdot E', '-2 \nabla \cdot (E \times B)', 'Sum', '\partial B^2/\partial t','\partial B^2/\partial t = 0');
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('\partial B^2/\partial t');
cd(outdir);
