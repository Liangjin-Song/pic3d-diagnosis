%% plot energy balance at RF 
% writen by Liangjin Song on 20190326 

%% parameters 

indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M25SBg00Sx/out/line/energy_balance/time/';
tt=0:97;
di=20;
ndx=4000;
ndy=2000;
Lx=ndx/di;
Ly=ndy/di;
c=0.6;
mu=1/(c^2);
z0=25;
qi=0.000105;
qe=-0.000105;
wci=0.003;
divsor=1;
nt=length(tt);
% shift=18;
shift=0;

db=zeros(1,nt-1);
tr=zeros(1,nt-1);
en=zeros(1,nt-1);
co=zeros(1,nt-1);
to=zeros(1,nt-1);
%% loop 
for t=1:nt-1
    % previous time
    tp=tt(t);
    % next time 
    tn=tt(t+1);
    % half time 
    th=(tp+tn)/2;
    
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
    [lbzp,lx]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    v_RF=calc_instant_RF_velocity(lbzp,lbzn,lx,wci,di);
    [vx_drf,vy_drf,vz_drf]=calc_drift_velocity(exh,eyh,ezh,bxh,byh,bzh);
    transp=calc_transport_item(v_RF,vx_drf,vy_drf,vz_drf,Bh,divsor);

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

    % [lbzh,~]=get_line_data(bzh,Lx,Ly,z0,1,0);
    % [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    % [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);

    [~,in1]=max(lbp);
    [~,in2]=max(lbn);
    in1=in1+shift;
    in2=in2+shift;
    if in1>ndx
        in1=in1-ndx;
    end
    if in2>ndx
        in2=in2-ndx;
    end
    db(t)=(lbn(in2)-lbp(in1))*wci;

    %% get the RF position
    nx=length(lx);
    [~,in]=max(lbh);

    in=in+shift;
    
    if in>ndx
        in=in-ndx;
    end
    aver=1;
    tr(t)=mean(ltr(in:in+aver));
    en(t)=mean(len(in:in+aver));
    co(t)=mean(lco(in:in+aver));
    to(t)=mean(ltot(in:in+aver));

end
tt=tt(1)+0.5:tt(end)-0.5;
plot(tt,tr,'r','Linewidth',2); hold on
plot(tt,en,'g','Linewidth',2)
plot(tt,co,'b','Linewidth',2)
plot(tt,to,'k','Linewidth',2)
plot(tt,db,'y','Linewidth',2)
xlabel('\Omegat');
ylabel('Energy Balance');
hl=legend('Transport','Local energy conversion','Compression','Total','dB/dt','Location','Best');
% hl=legend('Total','dB/dt','Location','Best');
set(hl,'Orientation','horizon');
set(hl,'fontsize',20);
set(gca,'fontsize',20);
cd(outdir)
