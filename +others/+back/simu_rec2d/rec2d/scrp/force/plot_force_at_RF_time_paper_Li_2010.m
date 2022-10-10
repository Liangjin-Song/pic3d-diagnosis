%% plot the force as a function of time
% writen by Liangjin Song on 20190707 
clear;
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/force/time/';
tt=60:70;
c=0.6;
n0=2857.11157;
vA=0.06;
ndx=4000;
ndy=2000;
di=20;
Lx=ndx/di;
Ly=ndy/di;
x0=25;
qi=0.000105;
qe=-qi;
dirt=0;
grids=1;
norm=qi*n0*vA;

nt=length(tt);
tcur=zeros(1,nt);
tgrd=zeros(1,nt);
ttot=zeros(1,nt);
aver=20;

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

    [lbz,lx]=get_line_data(bz,Lx,Ly,x0,1,dirt);
    [lc,~]=get_line_data(curvx,Lx,Ly,x0,norm,dirt);
    [lp,~]=get_line_data(gradx,Lx,Ly,x0,norm,dirt);
    lm=lc+lp;

    [~,in0]=max(lbz);
    cur=0; grd=0; tot=0;
    % cur=lc(in0);
    % grd=lp(in0);
    % tot=lm(in0);
    for i=1:aver
        in=in0; % +i;
        cur=cur+lc(in);
        grd=grd+lp(in);
        tot=tot+lm(in);
        in=in+1;
    end
    tcur(t)=cur/aver;
    tgrd(t)=grd/aver;
    ttot(t)=tot/aver;
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
