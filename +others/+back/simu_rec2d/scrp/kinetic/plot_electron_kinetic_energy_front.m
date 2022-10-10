%% plot the electron kinetic energy at the front
% writen by Liangjin Song on 20191115
%{
clear;
indir='/data/simulation/M100SBg00Sx_low_vte/ppc=100/';
outdir='/data/simulation/M100SBg00Sx_low_vte/out/ppc=100/time/';
tt=25:0.5:60;
dt=0.5;
di=60;
ndx=6000;
ndy=3000;
Lx=ndx/di;
Ly=ndy/di;
% electron
m=0.026666;
q=-0.000667;
wci=0.000250;
nt=length(tt);
z0=12.5;
c=0.6;
grids=1;

y0=2250;
top=3*di;
bottom=3*di;
left=5*di;
right=5*di;

pkt=zeros(1,nt);

for t=1:nt
    cd(indir);
    th=tt(t);
    
    n=read_data('Dense',th);

    vx=read_data('vxe',th);
    vy=read_data('vye',th);
    vz=read_data('vze',th);

    bz=read_data('Bz',th);
    bz=bz/c;

    K=0.5*m*n.*(vx.^2+vy.^2+vz.^2);

    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);

    aK=get_sub_matrix(K,x0,y0,top,bottom,left,right);
    pkt(t)=sum(sum(aK));
end
%}
figure;
plot(tt,pkt,'k','LineWidth',2);
xlabel('\Omega_{ci}t');
ylabel('K_e');
xlim([tt(1),tt(end)]);
cd(outdir);
