%% plot the ion density change at the front
% writen by Liangjin Song on 20191029
clear;
indir='/data/simulation/rec2d_M100SBg00Sx_ppn=1000/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx_ppn=1000/out/partial/';
tt=0.5:0.5:90;
dt=0.5;
di=40;
ndx=4000;
ndy=2000;
Lx=ndx/di; Ly=ndy/di;
nt=length(tt);
grids=1;
wci=0.000750;
c=0.6;
z0=12.5;

%{
x0=4500;
y0=2250;
%}
x0=3000;
y0=1500;
top=1.5*di;
bottom=1.5*di;
left=2*di;
right=2*di;

tnt=zeros(1,nt);
tnv=zeros(1,nt);

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

    nvx=vx.*n;
    nvy=vy.*n;
    nvz=vz.*n;

    dv=calc_divergence(nvx,nvy,nvz,grids);
    dn=(nn-np)*wci;
    dv=-dv;

    sdv=get_sub_matrix(dv,x0,y0,top,bottom,left,right);
    sdn=get_sub_matrix(dn,x0,y0,top,bottom,left,right);
    tnt(t)=sum(sum(sdn));
    tnv(t)=sum(sum(sdv));
end
lw=2;
figure;
plot(tt,tnv,'r','LineWidth',lw); hold on
plot(tt,tnt,'k','LineWidth',lw); hold off
legend('-\nabla \cdot (N_ev_e)','\partial N_e/\partial t');
xlabel('\Omega_{ci}t');
ylabel('\partial N_e/\partial t');
cd(outdir);
