%% plot the electron kinetic energy in the vicinity of the X-line
% writen by Liangjin Song on 20190915
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/kinetic/electron/';
dt=0.5;
tt=0.5:dt:55;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
% electron
m=0.003067;
q=-0.000230;
wci=0.000750;
nt=length(tt);
z0=15;
c=0.6;
grids=1;

x0=3600;
y0=1800;
top=2*di;
bottom=2*di;
left=3*di;
right=3*di;

tke=zeros(1,nt);
for t=1:nt
    cd(indir);
    tm=tt(t);
    tp=tt(t)-dt;
    tn=tt(t)+dt;

    np=read_data('Dense',tp);
    vxp=read_data('vxe',tp);
    vyp=read_data('vye',tp);
    vzp=read_data('vze',tp);

    nn=read_data('Dense',tn);
    vxn=read_data('vxe',tn);
    vyn=read_data('vye',tn);
    vzn=read_data('vze',tn);

    pke=calc_bulk_kinetic_energy(m,np,vxp,vyp,vzp);
    nke=calc_bulk_kinetic_energy(m,nn,vxn,vyn,vzn);
    ke=(nke-pke)*wci;

    ake=get_sub_matrix(ke,x0,y0,top,bottom,left,right);
    tke(t)=sum(sum(ake));
end
% plot figure
figure;
plot(tt,tke,'k','LineWidth',2);
xlabel('\Omega_{ci}t');
ylabel('Ke near X-line');
cd(outdir);
