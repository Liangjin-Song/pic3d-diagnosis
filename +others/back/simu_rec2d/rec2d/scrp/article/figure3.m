%% plot figure 3
% writen by Liangjin Song on 20191130
%{
clear;
prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters.m';
% prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters_m25.m';
run(prmfile);

mu0=1/(c*c);

normB2=1/(2*mu0);
normB=1;

nt=length(tt);

%% figure 1a, Bz line of five moments
t1=35;
t2=40;
t3=44;
t4=48;
t5=53;

cd(indir);
bz1=read_data('Bz',t1);
bz2=read_data('Bz',t2);
bz3=read_data('Bz',t3);
bz4=read_data('Bz',t4);
bz5=read_data('Bz',t5);
[lb1,lx]=get_line_data(bz1,Lx,Ly,z0,c,0);
[lb2,~]=get_line_data(bz2,Lx,Ly,z0,c,0);
[lb3,~]=get_line_data(bz3,Lx,Ly,z0,c,0);
[lb4,~]=get_line_data(bz4,Lx,Ly,z0,c,0);
[lb5,~]=get_line_data(bz5,Lx,Ly,z0,c,0);

%% figure 1a and 1b, magnetic energy and magnetic field 
% dB^/2mu0/dt
tdb2=zeros(1,nt);
tje2=zeros(1,nt);
teb2=zeros(1,nt);
tco2=zeros(1,nt);
tot2=zeros(1,nt);

% dB/dt
tdb=zeros(1,nt);
ttr=zeros(1,nt);
tlc=zeros(1,nt);
tco=zeros(1,nt);
tto=zeros(1,nt);

for t=1:nt
    cd(indir);
    th=tt(t);
    tp=th-dt;
    tn=th+dt;

    % magnetic field
    bx=read_data('Bx',th);
    bx=bx/c;
    by=read_data('By',th);
    by=by/c;
    bz=read_data('Bz',th);
    bz=bz/c;

    bxp=read_data('Bx',tp);
    bxp=bxp/c;
    byp=read_data('By',tp);
    byp=byp/c;
    bzp=read_data('Bz',tp);
    bzp=bzp/c;

    bxn=read_data('Bx',tn);
    bxn=bxn/c;
    byn=read_data('By',tn);
    byn=byn/c;
    bzn=read_data('Bz',tn);
    bzn=bzn/c;

    % electric field
    ex=read_data('Ex',th);
    ey=read_data('Ey',th);
    ez=read_data('Ez',th);

    % ion velocity
    vix=read_data('vxi',th);
    viy=read_data('vyi',th);
    viz=read_data('vzi',th);

    % electric velocity
    vex=read_data('vxe',th);
    vey=read_data('vye',th);
    vez=read_data('vze',th);

    % density
    ni=read_data('Densi',th);
    ne=read_data('Dense',th);

    %% dB^2/2mu0/dt
    [je,eb,co]=calc_dB2_vrf_timing(bx,by,bz,ex,ey,ez,ni,ne,vix,viy,viz,vex,vey,vez,qi,qe,mu0,grids,bzp,bzn,Lx,Ly,z0,wci,di);

    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);
    % integrating in a rectangle
    sje=get_sub_matrix(je,x0,y0,top,bottom,left,right);
    seb=get_sub_matrix(eb,x0,y0,top,bottom,left,right);
    sco=get_sub_matrix(co,x0,y0,top,bottom,left,right);

    % dB/dt
    b2p=(bxp.^2+byp.^2+bzp.^2)/(2*mu0);
    b2n=(bxn.^2+byn.^2+bzn.^2)/(2*mu0);

    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [~,x1]=max(lbzp);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,x2]=max(lbzn);

    sb2p=get_sub_matrix(b2p,x1,y0,top,bottom,left,right);
    sb2n=get_sub_matrix(b2n,x2,y0,top,bottom,left,right);

    tdb2(t)=sum(sum(sb2n-sb2p))*wci/normB2;
    tje2(t)=sum(sum(sje))/normB2;
    teb2(t)=sum(sum(seb))/normB2;
    tco2(t)=sum(sum(sco))/normB2;
    tot2(t)=tje2(t)+teb2(t)+tco2(t);

    %% dB/dt
    [comp,lcon,tran]=calc_dB_vrf_timing(bx,by,bz,ex,ey,ez,vix,viy,viz,vex,vey,vez,ni,ne,qi,qe,mu0,grids,bzp,bzn,Lx,Ly,z0,wci,di);

    scomp=get_sub_matrix(comp,x0,y0,top,bottom,left,right);
    slcon=get_sub_matrix(lcon,x0,y0,top,bottom,left,right);
    stran=get_sub_matrix(tran,x0,y0,top,bottom,left,right);

    % dB/dt
    bp=sqrt(bxp.^2+byp.^2+bzp.^2);
    bn=sqrt(bxn.^2+byn.^2+bzn.^2);

    sbp=get_sub_matrix(bp,x1,y0,top,bottom,left,right);
    sbn=get_sub_matrix(bn,x2,y0,top,bottom,left,right);

    tdb(t)=sum(sum(sbn-sbp))*wci/normB;
    ttr(t)=sum(sum(stran))/normB;
    tlc(t)=sum(sum(slcon))/normB;
    tco(t)=sum(sum(scomp))/normB;
    tto(t)=ttr(t)+tlc(t)+tco(t);
end
tdb=tdb*10;
tto=tto*10;
tdb2=tdb2*10;
tot2=tot2*10;
%}
f=figure;
lw=2;
fs=16;
thw=[0.1,0.13];
tlu=[0.10,0.03];
tlr=[0.13,0.32];

set(f,'Units','centimeter','Position',[10,10,18,23]);
ha1 = tight_subplot(3,1,thw,tlu,tlr);

%% Bz moments
axes(ha1(1));
plot(lx,lb1,'r','LineWidth',lw); hold on
plot(lx,lb2,'g','LineWidth',lw);
plot(lx,lb3,'b','LineWidth',lw);
plot(lx,lb4,'k','LineWidth',lw);
plot(lx,lb5,'m','LineWidth',lw); hold off
xlim([Lx/2,Lx]);
xlabel('X[c/\omega_{pi}]');
ylabel('Bz');
l1=legend(['\Omega_{ci}t=',num2str(t1)],['\Omega_{ci}t=',num2str(t2)],['\Omega_{ci}t=',num2str(t3)],['\Omega_{ci}t=',num2str(t4)],['\Omega_{ci}t=',num2str(t5)]);
set(l1,...
    'Position',[0.703280196130564 0.779544413088017 0.171014489859774 0.169373545043706]);
set(gca,'FontSize',fs);

%% dB^2/2mu0/dt
axes(ha1(2));
plot(tt,tje2,'r','LineWidth',lw); hold on
plot(tt,teb2,'g','LineWidth',lw);
plot(tt,tco2,'b','LineWidth',lw);
plot(tt,tot2,'k','LineWidth',lw);
plot(tt,tdb2,'--r','LineWidth',lw); hold on
plot([0,100],[0,0],'--k','LineWidth',1); hold off
% plot([0,100],[0,0],'--y','LineWidth',lw);
l2=legend('- J \cdot E', '- \nabla \cdot (E \times B)/\mu_0', 'v_{DF} \cdot \nabla (B^2 /2\mu_0)', '10*Sum', '10*d(B^2/2\mu_0)/dt'); %,'d(B^2/2\mu_0)/dt = 0');
set(l2,...
    'Position',[0.703236721065885 0.434936526067015 0.278260863475178 0.201276096314399]);
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('d(B^2/2\mu_0)/dt');
set(gca,'FontSize',fs);

% dB/dt
axes(ha1(3));
plot(tt,tco,'r','LineWidth',lw); hold on
plot(tt,tlc,'g','LineWidth',lw);
plot(tt,ttr,'b','LineWidth',lw);
plot(tt,tto,'k','LineWidth',lw);
plot(tt,tdb,'--r','LineWidth',lw); hold on
plot([0,100],[0,0],'--k','LineWidth',1); hold off
% plot([0,100],[0,0],'--y','LineWidth',lw);
l3=legend('-B\nabla \cdot v_E', '-\mu_0 J \cdot E/B', '(v_{DF}-2v_E) \cdot \nabla B', '10*Sum', '10*dB/dt'); % , 'dB/dt=0');
set(l3,...
    'Position',[0.701787445012498 0.12539128473974 0.255072458369145 0.174593962538823]);
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('dB/dt');
set(gca,'FontSize',fs);

%% box
annotation(f,'textbox',...
    [0.00869565217391304 0.946795824599376 0.0818840559625972 0.0429234329412266],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fs+4,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.0072463768115942 0.626610209750187 0.0833333312817242 0.0429234329412266],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',fs+4,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.0072463768115942 0.306610209750187 0.0833333312817242 0.0429234329412266],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',fs+4,...
    'FontName','Times New Roman');


% cd(outdir);
