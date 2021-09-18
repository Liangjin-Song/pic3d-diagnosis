%% plot energy balance at RF 
% writen by Liangjin Song on 20190326 
%{
%% parameters 
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/dB_dt/time/';
dt=0.5;
tt=25:dt:55;
ndx=4800;
ndy=2400;
di=40;
Lx=ndx/di;
Ly=ndy/di;
c=0.6;
mu=1/(c^2);
z0=15;
qi=0.000230;
qe=-qi;
wci=0.000750;
divsor=1;
nt=length(tt);


db=zeros(1,nt);
tr=zeros(1,nt);
en=zeros(1,nt);
co=zeros(1,nt);
to=zeros(1,nt);

y0=1800;

left=3*di;
right=3*di;
top=3*di;
bottom=3*di;

%% loop 
for t=1:nt
    % half time 
    th=tt(t);
    % previous time
    tp=th-dt;
    % next time 
    tn=th+dt;
    
    % read data 
    cd(indir);

    % Bx
    bxp=read_data('Bx',tp);
    bxp=bxp/c;
    bxh=read_data('Bx',th);
    bxh=bxh/c;
    bxn=read_data('Bx',tn);
    bxn=bxn/c;

    % By
    byp=read_data('By',tp);
    byp=byp/c;
    byh=read_data('By',th);
    byh=byh/c;
    byn=read_data('By',tn);
    byn=byn/c;

    % Bz
    bzp=read_data('Bz',tp);
    bzp=bzp/c;
    bzh=read_data('Bz',th);
    bzh=bzh/c;
    bzn=read_data('Bz',tn);
    bzn=bzn/c;

    % Electric field
    exh=read_data('Ex',th);
    eyh=read_data('Ey',th);
    ezh=read_data('Ez',th);

    % Density
    nih=read_data('Densi',th);
    neh=read_data('Dense',th);

    % ions velocity
    vxih=read_data('vxi',th);
    vyih=read_data('vyi',th);
    vzih=read_data('vzi',th);

    % electrons velocity
    vxeh=read_data('vxe',th);
    vyeh=read_data('vye',th);
    vzeh=read_data('vze',th);

    %% calculate transport item
    Bh=sqrt(bxh.^2+byh.^2+bzh.^2);
    [vx_drf,vy_drf,vz_drf]=calc_drift_velocity(exh,eyh,ezh,bxh,byh,bzh);
    transp=calc_transport_item(0,vx_drf,vy_drf,vz_drf,Bh,divsor);

    %% Local energy conversion
    [Jxh,Jyh,Jzh]=calc_current_density(nih,neh,qi,qe,vxih,vyih,vzih,vxeh,vyeh,vzeh);
    lenergy=calc_local_energy_conversion_item(Jxh,Jyh,Jzh,exh,eyh,ezh,Bh,mu);

    %% compression item
    compre=calc_compression_item(vx_drf,vy_drf,vz_drf,Bh,divsor);

    %% get line 
    bn=sqrt(bxn.^2+byn.^2+bzn.^2);
    bp=sqrt(bxp.^2+byp.^2+bzp.^2);
    bh=sqrt(bxh.^2+byh.^2+bzh.^2);
    [lbn,~]=get_line_data(bn,Lx,Ly,z0,1,0);
    [lbp,~]=get_line_data(bp,Lx,Ly,z0,1,0);
    [lbh,~]=get_line_data(bh,Lx,Ly,z0,1,0);
    lbn(1:(3*ndx/4))=0;
    lbp(1:(3*ndx/4))=0;
    lbh(1:(3*ndx/4))=0;

    [~,x1]=max(lbp);
    [~,x2]=max(lbn);
    mbp=get_sub_matrix(bp,x1,y0,top,bottom,left,right);
    mbn=get_sub_matrix(bn,x2,y0,top,bottom,left,right);
    db(t)=(mean(mbn(:))-mean(mbp(:)))*wci;

    %% get the RF position
    [~,x0]=max(lbh);

    ltr=get_sub_matrix(transp,x0,y0,top,bottom,left,right);
    len=get_sub_matrix(lenergy,x0,y0,top,bottom,left,right);
    lco=get_sub_matrix(compre,x0,y0,top,bottom,left,right);
    ltot=ltr+len+lco;

    tr(t)=mean(ltr(:));
    en(t)=mean(len(:)); 
    co(t)=mean(lco(:)); 
    to(t)=mean(ltot(:));
end
% tt=tt(1)+0.5:dt:tt(end);
%}
% tt=tt(1)+0.1:tt(end);
plot(tt,tr,'r','Linewidth',2); hold on
plot(tt,en,'g','Linewidth',2)
plot(tt,co,'b','Linewidth',2)
plot(tt,to,'k','Linewidth',2)
plot(tt,db,'--k','Linewidth',2)
plot([0,100],[0,0],'--y','LineWidth',2);
xlabel('\Omega_{ci}t');
ylabel('dB/dt');
hl=legend('Transport','Local energy conversion','Compression','Sum','dB/dt','dB/dt=0','Location','Best');
% hl=legend('Total','dB/dt','Location','Best');
% set(hl,'Orientation','horizon');
set(hl,'fontsize',16);
set(gca,'fontsize',16);
xlim([tt(1),tt(end)]);
set(gcf,'Position',[500,500,900,700]);
cd(outdir)
