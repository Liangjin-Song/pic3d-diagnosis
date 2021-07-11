%% plot kinetic energy
% writen by Liangjin Song on 20191130
%{
clear;
prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters.m';
% prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters_m25.m';
run(prmfile);

normk=0.5*mi*n0*vA*vA;

nt=length(tt);

tpki=zeros(1,nt);
tpke=zeros(1,nt);

tfx=zeros(1,nt);
twe=zeros(1,nt);
twp=zeros(1,nt);
tcv=zeros(1,nt);
tot=zeros(1,nt);
pkt=zeros(1,nt);

for t=1:nt
    cd(indir);
    th=tt(t);
    tn=th+dt;
    tp=th-dt;

    % ion
    nih=read_data('Densi',th);
    vixh=read_data('vxi',th);
    viyh=read_data('vyi',th);
    vizh=read_data('vzi',th);

    nin=read_data('Densi',tn);
    vixn=read_data('vxi',tn);
    viyn=read_data('vyi',tn);
    vizn=read_data('vzi',tn);

    nip=read_data('Densi',tp);
    vixp=read_data('vxi',tp);
    viyp=read_data('vyi',tp);
    vizp=read_data('vzi',tp);

    % electron
    neh=read_data('Dense',th);
    vexh=read_data('vxe',th);
    veyh=read_data('vye',th);
    vezh=read_data('vze',th);

    nen=read_data('Dense',tn);
    vexn=read_data('vxe',tn);
    veyn=read_data('vye',tn);
    vezn=read_data('vze',tn);

    nep=read_data('Dense',tp);
    vexp=read_data('vxe',tp);
    veyp=read_data('vye',tp);
    vezp=read_data('vze',tp);

    bxh=read_data('Bx',th);
    bxh=bxh/c;
    byh=read_data('By',th);
    byh=byh/c;
    bzh=read_data('Bz',th);
    bzh=bzh/c;

    bzp=read_data('Bz',tp);
    bzp=bzp/c;
    bzn=read_data('Bz',tn);
    bzn=bzn/c;

    exh=read_data('Ex',th);
    eyh=read_data('Ey',th);
    ezh=read_data('Ez',th);

    pih=read_data('presi',tt(t));
    peh=read_data('prese',tt(t));

    %% ion bulk kinetic energy
    Kip=calc_bulk_kinetic_energy(mi,nip,vixp,viyp,vizp);
    Kin=calc_bulk_kinetic_energy(mi,nin,vixn,viyn,vizn);

    [Kih,fluxih,weih,wpih,cvih]=calc_kinetic_dK_dt_vRF_timing(qi,mi,nih,vixh,viyh,vizh,exh,eyh,ezh,pih,grids,Lx,Ly,z0,bzp,bzn,wci,di);


    %% electron bulk kinetic energy
    Kep=calc_bulk_kinetic_energy(me,nep,vexp,veyp,vezp);
    Kep=simu_filter2d(Kep);
    Ken=calc_bulk_kinetic_energy(me,nen,vexn,veyn,vezn);
    Ken=simu_filter2d(Ken);

    [Keh,fluxeh,weeh,wpeh,cveh]=calc_kinetic_dK_dt_vRF_timing(qe,me,neh,vexh,veyh,vezh,exh,eyh,ezh,peh,grids,Lx,Ly,z0,bzp,bzn,wci,di);
    Keh=simu_filter2d(Keh);
    fluxeh=simu_filter2d(fluxeh);
    weeh=simu_filter2d(weeh);
    wpeh=simu_filter2d(wpeh);
    cveh=simu_filter2d(cveh);

    %% get a mean value of a ractangle
    [lbz,~]=get_line_data(bzh,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);

    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [~,x1]=max(lbzp);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,x2]=max(lbzn);

    %% ion
    iafx=get_sub_matrix(fluxih,x0,y0,top,bottom,left,right);
    iawe=get_sub_matrix(weih,x0,y0,top,bottom,left,right);
    iawp=get_sub_matrix(wpih,x0,y0,top,bottom,left,right);
    iacv=get_sub_matrix(cvih,x0,y0,top,bottom,left,right);

    aKp=get_sub_matrix(Kip,x1,y0,top,bottom,left,right);
    aKn=get_sub_matrix(Kin,x2,y0,top,bottom,left,right);
    ipkt=sum(sum(aKn-aKp))*wci;

    %% electron
    eafx=get_sub_matrix(fluxeh,x0,y0,top,bottom,left,right);
    eawe=get_sub_matrix(weeh,x0,y0,top,bottom,left,right);
    eawp=get_sub_matrix(wpeh,x0,y0,top,bottom,left,right);
    eacv=get_sub_matrix(cveh,x0,y0,top,bottom,left,right);

    aKp=get_sub_matrix(Kep,x1,y0,top,bottom,left,right);
    aKn=get_sub_matrix(Ken,x2,y0,top,bottom,left,right);
    epkt=sum(sum(aKn-aKp))*wci;

    %% Sum
    tfx(t)=sum(sum(iafx+eafx))/normk;
    twe(t)=sum(sum(iawe+eawe))/normk;
    twp(t)=sum(sum(iawp+eawp))/normk;
    tcv(t)=sum(sum(iacv+eacv))/normk;
    tot(t)=tfx(t)+twe(t)+twp(t)+tcv(t);
    pkt(t)=(ipkt+epkt)/normk;

    %% ion kinetic energy variation
    aK=get_sub_matrix(Kih,x0,y0,top,bottom,left,right);
    tpki(t)=sum(sum(aK));

    %% electron kinetic energy variation
    aK=get_sub_matrix(Keh,x0,y0,top,bottom,left,right);
    tpke(t)=sum(sum(aK));
end
%}
load('figure4.mat');
f=figure;
lw=2;
fs=16;
thw=[0.03,0.15];
tlu=[0.15,0.08];
tlr=[0.08,0.03];

set(f,'Units','centimeter','Position',[10,10,30,13]);
ha1 = tight_subplot(1,2,thw,tlu,tlr);

%% electron and ion kinetic energy
axes(ha1(1));
[ax,h1,h2]=plotyy(tt,tpke,tt,tpki);
set(ax(1),'XColor','k','YColor','b','FontSize',fs);
set(ax(2),'XColor','k','YColor','r','FontSize',fs);
set(ax,'XLim',[tt(1),tt(end)]);
% set label
set(get(ax(1),'Ylabel'),'String','K_e','FontSize',fs);
set(get(ax(2),'Ylabel'),'String','K_i','FontSize',fs);
% set(gca,'xticklabel',[]);
xlabel('\Omega_{ci}t','FontSize',fs);
% set line
set(h1,'Color','b','LineWidth',lw);
set(h2,'Color','r','LineWidth',lw);
set(gca,'FontSize',fs);

%% bulk kinetic energy variation
axes(ha1(2));
p1=plot(tt,twe,'r','LineWidth',lw); hold on
p2=plot(tt,twp,'g','LineWidth',lw);
p3=plot(tt,tfx,'b','LineWidth',lw);
p4=plot(tt,tcv,'c','LineWidth',lw);
p5=plot(tt,tot,'k','LineWidth',lw);
p6=plot(tt,pkt,'--r','LineWidth',lw); hold on
plot([0,100],[0,0],'--k','LineWidth',1); hold off
% p7=plot([0,100],[0,0],'--y','LineWidth',lw); hold off
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci} t');
ylabel('dK/dt');
set(gca,'FontSize',fs);
% l=legend('J\cdot E','-(\nabla\cdot P_i)\cdot V_i-(\nabla\cdot P_e)\cdot V_e','-\nabla\cdot(K_iV_i+K_eV_e)','V_{DF}\cdot(\nabla K_i+ \nabla K_e)','Sum','dK/dt')
% set(l,'FontSize',fs-4)

l1=legend([p1,p3,p4],'J\cdot E','-\nabla\cdot(K_iV_i+K_eV_e)','V_{DF}\cdot(\nabla K_i+ \nabla K_e)');
set(l1,...
    'Position',[0.60343823273664 0.217630859228369 0.188811184512777 0.185950407989261], 'FontSize',fs);
set(l1,'Box','off');

ah=axes('position',get(gca,'position'),...
            'visible','off');
l2=legend(ah,[p2,p5,p6],'-(\nabla\cdot P_i)\cdot V_i-(\nabla\cdot P_e)\cdot V_e','Sum','dK/dt');

set(l2,...
    'Position',[0.607371799704252 0.71556474352589 0.224650344283848 0.185950407989261], 'FontSize',fs);
set(l2,'Box','off');

annotation(f,'textbox',...
    [0.00349650349650349 0.889495869431121 0.0493881106767413 0.0764462793292093],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.530594405594406 0.887429753728643 0.0502622365248162 0.0764462793292093],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

% cd(outdir);
