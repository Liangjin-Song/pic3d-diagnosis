% plot the time variation of ion force at the front
% writen by Liangjin Song on 20191206
clear;
prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters.m';
run(prmfile);

normf=1;

tt=25:dt:53;
nt=length(tt);

tcur=zeros(1,nt);
tgrd=zeros(1,nt);
tfex=zeros(1,nt);
ttot=zeros(1,nt);
tfs=zeros(1,nt);

dirt=0;

for t=1:nt
    cd(indir);
    th=tt(t);
    tp=th-dt;
    tn=th+dt;


    bx=read_data('Bx',th);
    bx=bx/c;
    by=read_data('By',th);
    by=by/c;
    bz=read_data('Bz',th);
    bz=bz/c;

    ex=read_data('Ex',th);
    ey=read_data('Ey',th);
    ez=read_data('Ez',th);

    pi=read_data('presi',th);

    ni=read_data('Densi',th);

    vxp=read_data('vxi',tp);
    vxn=read_data('vxi',tn);
    bzp=read_data('Bz',tp);
    bzp=bzp/c;
    bzn=read_data('Bz',tn);
    bzn=bzn/c;
    
    pe=0;
    [curvx,gradx]=calc_force_at_RF_paper_Li_2010(bx,by,bz,pi,pe,c,grids);
    fex=qi*ex;

    [lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,dirt);
    [~,x0]=max(lbz);
    cur=get_sub_matrix(curvx,x0,y0,top,bottom,left,right);
    grd=get_sub_matrix(gradx,x0,y0,top,bottom,left,right);
    sfex=get_sub_matrix(fex,x0,y0,top,bottom,left,right);
    

    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [~,xp]=max(lbzp);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,xn]=max(lbzn);

    svp=get_sub_matrix(vxp,xp,y0,top,bottom,left,right);
    svn=get_sub_matrix(vxn,xn,y0,top,bottom,left,right);
    sni=get_sub_matrix(ni,x0,y0,top,bottom,left,right);
    sfx=mi*sni.*(svn-svp)*wci;

    tcur(t)=sum(sum(cur))/normf;
    tgrd(t)=sum(sum(grd))/normf;
    tfex(t)=sum(sum(sfex))/normf;
    ttot(t)=tcur(t)+tgrd(t)+tfex(t);
    tfx(t)=sum(sum(sfx))/normf;
end

linewidth=2;
fontsize=16;
figure;
plot(tt,tfex,'r','Linewidth',linewidth); hold on
plot(tt,tcur,'g','LineWidth',linewidth); hold on
plot(tt,tgrd,'b','LineWidth',linewidth);
plot(tt,ttot,'k','LineWidth',linewidth);
plot(tt,tfx,'--r','LineWidth',linewidth);
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('fx[J_{0}B_{0}]');
hl=legend('qi*E_x','(B\cdot\nabla)B/\mu_{0}','-\nabla(B^2/2\mu_{0}+P_{th})','Sum','mndv_x/dt','Location','Best');
cd(outdir);
