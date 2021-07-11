% plot the time variation of ion force at the front
% writen by Liangjin Song on 20191206
clear;
prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters.m';
run(prmfile);

normf=1;

dirt=0;
q=qi;
m=mi;

tt=25:dt:53;
nt=length(tt);

tjxb=zeros(1,nt);
tgdp=zeros(1,nt);
tmom=zeros(1,nt);
ttot=zeros(1,nt);
tfx=zeros(1,nt);

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

    p=read_data('presi',th);
    n=read_data('Densi',th);

    vx=read_data('vxi',th);
    vy=read_data('vyi',th);
    vz=read_data('vzi',th);

    vxp=read_data('vxi',tp);
    vxn=read_data('vxi',tn);
    bzp=read_data('Bz',tp);
    bzp=bzp/c;
    bzn=read_data('Bz',tn);
    bzn=bzn/c;

    [jx,jy,jz]=calc_plasma_current_density(q,n,vx,vy,vz);
    [jxb,grdp,momv]=calc_MHD_moment(jx,jy,jz,bx,by,bz,vx,vy,vz,p,n,m,grids);

    [lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,dirt);
    [~,x0]=max(lbz);
    sjxb=get_sub_matrix(jxb.x,x0,y0,top,bottom,left,right);
    sgdp=get_sub_matrix(grdp.x,x0,y0,top,bottom,left,right);
    smom=get_sub_matrix(momv.x,x0,y0,top,bottom,left,right);
    sgdp=-sgdp;
    smom=-smom;

    [lbzp,lx]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [~,xp]=max(lbzp);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,xn]=max(lbzn);
    v_RF=calc_instant_RF_velocity(lbzp,lbzn,lx,wci,di);
    v=sqrt(vx.^2+vy.^2+vz.^2);



    svp=get_sub_matrix(vxp,xp,y0,top,bottom,left,right);
    svn=get_sub_matrix(vxn,xn,y0,top,bottom,left,right);
    sn=get_sub_matrix(n,x0,y0,top,bottom,left,right);
    sfx=m*sn.*(svn-svp)*wci;

    tjxb(t)=sum(sum(sjxb))/normf;
    tgdp(t)=sum(sum(sgdp))/normf;
    tmom(t)=sum(sum(smom))/normf;
    ttot(t)=tjxb(t)+tgdp(t)+tmom(t);
    tfx(t)=sum(sum(sfx))/normf;
end
linewidth=2;
fontsize=16;
figure;
plot(tt,tjxb,'r','Linewidth',linewidth); hold on
plot(tt,tgdp,'g','LineWidth',linewidth); 
plot(tt,tmom,'b','LineWidth',linewidth);
plot(tt,ttot,'k','LineWidth',linewidth);
plot(tt,tfx,'--r','LineWidth',linewidth);
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('F_{ix}');
hl=legend('J_i \times B','-\nabla \cdot P','-\rho_i(v \cdot \nabla)v','Sum','mndv_x/dt','Location','Best');
cd(outdir);
