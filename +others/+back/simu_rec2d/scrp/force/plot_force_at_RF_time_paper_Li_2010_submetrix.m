%% plot the force as a function of time
% writen by Liangjin Song on 20190707 
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/force/time/';
tt=25:0.5:55;
c=0.6;
n0=1304.33557;
vA=0.03;
ndx=4800;
ndy=2400;
di=40;
Lx=ndx/di;
Ly=ndy/di;
z0=15;
qi=0.000230;
qe=-qi;
dirt=0;
grids=1;
% norm=qi*n0*vA;
norm=1;

nt=length(tt);
tcur=zeros(1,nt);
tgrd=zeros(1,nt);
ttot=zeros(1,nt);

y0=1800;

left=3*di;
right=3*di;
top=3*di;
bottom=3*di;

for t=1:nt
    cd(indir);
    bx=read_data('Bx',tt(t));
    bx=bx/c;
    by=read_data('By',tt(t));
    by=by/c;
    bz=read_data('Bz',tt(t));
    bz=bz/c;

    pi=read_data('presi',tt(t));
    pe=read_data('prese',tt(t));

    % force in x direction
    [curvx,gradx]=calc_force_at_RF_paper_Li_2010(bx,by,bz,pi,pe,c,grids);
    curvx=simu_filter2d(curvx);
    gradx=simu_filter2d(gradx);
    total=curvx+gradx;

    [lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,dirt);
    [~,x0]=max(lbz);
    cur=get_sub_matrix(curvx,x0,y0,top,bottom,left,right);
    grd=get_sub_matrix(gradx,x0,y0,top,bottom,left,right);
    tot=get_sub_matrix(total,x0,y0,top,bottom,left,right);
    tcur(t)=mean(cur(:));
    tgrd(t)=mean(grd(:));
    ttot(t)=mean(tot(:));
end


%% plot figures
linewidth=2;
fontsize=16;
figure;
plot(tt,tcur,'g','LineWidth',linewidth); hold on
plot(tt,tgrd,'b','LineWidth',linewidth);
plot(tt,ttot,'k','LineWidth',linewidth);
plot([tt(1),tt(end)],[0,0],'--m','LineWidth',linewidth);
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('fx[J_{0}B_{0}]');
hl=legend('(B\cdot\nabla)B/\mu_{0}','-\nabla(B^2/2\mu_{0}+P_{th})','total','Location','Best');
set(hl,'Orientation','horizon');
set(gcf,'Position',[100 100 1200 900]);
set(gca,'Position',[.13 .18 .75 .75]);
set(gca,'FontSize',fontsize);
cd(outdir);
