%% plot energy balance at RF 
% writen by Liangjin Song on 20190326 
%
%% parameters 
clear;
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M25SBg00Sx/out/dB_dt/time/';
dt=0.5;
tt=60:dt:90;
ndx=4000;
ndy=2000;
di=20;
Lx=ndx/di;
Ly=ndy/di;
c=0.6;
mu=1/(c^2);
z0=25;
qi=0.000105;
qe=-qi;
wci=0.003;
divsor=1;
nt=length(tt);

% average=40;
average=20;

db=zeros(1,nt-1);
tr=zeros(1,nt-1);
en=zeros(1,nt-1);
co=zeros(1,nt-1);
to=zeros(1,nt-1);
%% loop 
for t=1:nt-1
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
    [ltr,~]=get_line_data(transp,Lx,Ly,z0,1,0);
    [len,~]=get_line_data(lenergy,Lx,Ly,z0,1,0);
    [lco,~]=get_line_data(compre,Lx,Ly,z0,1,0);
    ltr(1:(3*ndx/4))=0;
    len(1:(3*ndx/4))=0;
    lco(1:(3*ndx/4))=0;
    ltot=ltr+len+lco;
    bn=sqrt(bxn.^2+byn.^2+bzn.^2);
    bp=sqrt(bxp.^2+byp.^2+bzp.^2);
    bh=sqrt(bxh.^2+byh.^2+bzh.^2);
    [lbn,~]=get_line_data(bn,Lx,Ly,z0,1,0);
    [lbp,~]=get_line_data(bp,Lx,Ly,z0,1,0);
    [lbh,~]=get_line_data(bh,Lx,Ly,z0,1,0);
    lbn(1:(3*ndx/4))=0;
    lbp(1:(3*ndx/4))=0;
    lbh(1:(3*ndx/4))=0;

    [mb1,in1]=max(lbp);
    [mb2,in2]=max(lbn);
    dbt=(mb2-mb1)*wci;
    % dbdt=(lbn-lbp)*wci;

    %% get the RF position
    [~,in]=max(lbh);

    atr=ltr(in); aen=len(in); aco=lco(in); ato=ltot(in);

    for i=1:average
        n=in+i;
        n1=in1+i;
        n2=in2+i;
        if n>ndx
            n=n-ndx;
        end
        if n1>ndx
            n1=n1-ndx;
        end
        if n2>ndx
            n2=n2-ndx;
        end
        atr=atr+ltr(n);
        aen=aen+len(n);
        aco=aco+lco(n);
        ato=ato+ltot(n);
        dbt=dbt+(lbn(n2)-lbp(n1))*wci;
    end
    tr(t)=atr/(average+1);
    en(t)=aen/(average+1);
    co(t)=aco/(average+1);
    to(t)=ato/(average+1);
    db(t)=dbt/(average+1);

end
tt=tt(1)+0.5:dt:tt(end);
%}
% tt=tt(1)+0.1:tt(end);
plot(tt,tr,'r','Linewidth',2); hold on
plot(tt,en,'g','Linewidth',2)
plot(tt,co,'b','Linewidth',2)
plot(tt,to,'k','Linewidth',2)
plot(tt,db,'--k','Linewidth',2)
plot([0,100],[0,0],'--y','LineWidth',2);
xlabel('\Omegat');
ylabel('Energy Balance');
hl=legend('Transport','Local energy conversion','Compression','Sum','dB/dt','dB/dt=0','Location','Best');
% hl=legend('Total','dB/dt','Location','Best');
% set(hl,'Orientation','horizon');
set(hl,'fontsize',16);
set(gca,'fontsize',16);
xlim([tt(1),tt(end)]);
cd(outdir)
