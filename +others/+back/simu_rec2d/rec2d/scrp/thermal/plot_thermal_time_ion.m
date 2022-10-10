%% plot thermal energy density overview 
% writen by Liangjin Song on 20190517 
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/thermal/ion/';
tt=0:0.5:100;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);
z0=15;
c=0.6;

y0=1800;
top=1.5*di;
bottom=1.5*di;
left=0.5*di;
right=5*di;

tu=zeros(1,nt);
for t=1:nt
    cd(indir);
    p=read_data('presi',tt(t));
    bz=read_data('Bz',tt(t));
    [pxx,~,~,pyy,~,pzz]=reshap_pressure(p,ndy,ndx);
    U=calc_thermal_energy(pxx,pyy,pzz);
    [lbz,~]=get_line_data(bz,Lx,Ly,z0,c,0);
    [~,x0]=max(lbz);
    su=get_sub_matrix(U,x0,y0,top,bottom,left,right);
    tu(t)=sum(sum(su));
end
figure;
plot(tt,tu,'k','LineWidth',2);
xlabel('\Omega_{ci}t')
ylabel('U_{i}');
cd(outdir);
