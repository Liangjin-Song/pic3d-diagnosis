%% plot dTe/dt at the front
% writen by Liangjin Song on 20190810 
clear;
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M25SBg00Sx/out/temperature/electron/time/';
tt=60:0.5:90;
di=20;
ndx=4000;
ndy=2000;
Lx=ndx/di; Ly=ndy/di;
nt=length(tt);
z0=25;
c=0.6;
grids=1;
wci=0.003000;

y0=1500;
top=2*di;
bottom=2*di;
left=3*di;
right=3*di;

ttp=zeros(1,nt);

for t=1:nt
    cd(indir);
    tm=tt(t);
    p=read_data('prese',tm);
    n=read_data('Dense',tm);

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
ylabel('Te');
cd(outdir);
