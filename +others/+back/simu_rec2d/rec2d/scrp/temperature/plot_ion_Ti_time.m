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

ttp=zeros(1,nt);

for t=1:nt
    cd(indir);
    tm=tt(t);
    p=read_data('presi',tm);
    n=read_data('Densi',tm);

    bz=read_data('Bz',tm);
    bz=bz/c;
    [pxx,~,~,pyy,~,pzz]=reshap_pressure(p,ndy,ndx);
    tp=calc_scalar_temperature(pxx,pyy,pzz,n);

    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);
    % integrating in a rectangle
    stp=get_sub_matrix(tp,x0,y0,top,bottom,left,right);
    ttp(t)=sum(sum(stp));
end
linewidth=2;
figure;
plot(tt,ttp,'k','LineWidth',linewidth);
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('Ti');
cd(outdir);
