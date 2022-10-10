%% plot figure 3
% writen by Liangjin Song on 20191130
%{
clear;
prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters.m';
% prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters_m25.m';
run(prmfile);

normi=(3/2*n0*Ti);
norme=(3/2*n0*Te);

nt=length(tt);

teni=zeros(1,nt);
thti=zeros(1,nt);
tthi=zeros(1,nt);
tcoi=zeros(1,nt);
toti=zeros(1,nt);
tpui=zeros(1,nt);

tene=zeros(1,nt);
thte=zeros(1,nt);
tthe=zeros(1,nt);
tcoe=zeros(1,nt);
tote=zeros(1,nt);
tpue=zeros(1,nt);

for t=1:nt
    cd(indir);
    tm=tt(t);
    tp=tm-dt;
    tn=tm+dt;

    pe=read_data('prese',tm);
    pep=read_data('prese',tp);
    pen=read_data('prese',tn);

    vex=read_data('vxe',tm);
    vey=read_data('vye',tm);
    vez=read_data('vze',tm);

    qfluxe=read_data('qfluxe',tm);


    pi=read_data('presi',tm);
    pip=read_data('presi',tp);
    pin=read_data('presi',tn);

    vix=read_data('vxi',tm);
    viy=read_data('vyi',tm);
    viz=read_data('vzi',tm);

    qfluxi=read_data('qfluxi',tm);

    bx=read_data('Bx',tm);
    bx=bx/c;
    by=read_data('By',tm);
    by=by/c;
    bz=read_data('Bz',tm);
    bz=bz/c;

    bzp=read_data('Bz',tp);
    bzp=bzp/c;
    bzn=read_data('Bz',tn);
    bzn=bzn/c;

    ex=read_data('Ex',tm);
    ey=read_data('Ey',tm);
    ez=read_data('Ez',tm);

    %% electron thermal energy 
    [pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(pe,ndy,ndx);
    [qx,qy,qz]=reshape_qflux(qfluxe,ndy,ndx);

    [pxxp,~,~,pyyp,~,pzzp]=reshap_pressure(pep,ndy,ndx);
    Up=calc_thermal_energy(pxxp,pyyp,pzzp);
    [pxxn,~,~,pyyn,~,pzzn]=reshap_pressure(pen,ndy,ndx);
    Un=calc_thermal_energy(pxxn,pyyn,pzzn);

    [U,enp,htf,thp,con]=calc_dU_dt_vrf_timing(pxx,pxy,pxz,pyy,pyz,pzz,qx,qy,qz,vex,vey,vez,bzn,bzp,grids,Lx,Ly,z0,wci,di);

    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);
    % integrating in a rectangle
    senp=get_sub_matrix(enp,x0,y0,top,bottom,left,right);
    shtf=get_sub_matrix(htf,x0,y0,top,bottom,left,right);
    sthp=get_sub_matrix(thp,x0,y0,top,bottom,left,right);
    scon=get_sub_matrix(con,x0,y0,top,bottom,left,right);

    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [~,x1]=max(lbzp);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,x2]=max(lbzn);

    sup=get_sub_matrix(Up,x1,y0,top,bottom,left,right);
    sun=get_sub_matrix(Un,x2,y0,top,bottom,left,right);


    tene(t)=sum(sum(senp))/norme;
    thte(t)=sum(sum(shtf))/norme;
    tthe(t)=sum(sum(sthp))/norme;
    tcoe(t)=sum(sum(scon))/norme;
    tote(t)=tene(t)+thte(t)+tthe(t)+tcoe(t);
    tpue(t)=sum(sum(sun-sup))*wci/norme;

    %% ion thermal energy
    [pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(pi,ndy,ndx);
    [qx,qy,qz]=reshape_qflux(qfluxi,ndy,ndx);

    [pxxp,~,~,pyyp,~,pzzp]=reshap_pressure(pip,ndy,ndx);
    Up=calc_thermal_energy(pxxp,pyyp,pzzp);
    [pxxn,~,~,pyyn,~,pzzn]=reshap_pressure(pin,ndy,ndx);
    Un=calc_thermal_energy(pxxn,pyyn,pzzn);

    [U,enp,htf,thp,con]=calc_dU_dt_vrf_timing(pxx,pxy,pxz,pyy,pyz,pzz,qx,qy,qz,vix,viy,viz,bzn,bzp,grids,Lx,Ly,z0,wci,di);

    senp=get_sub_matrix(enp,x0,y0,top,bottom,left,right);
    shtf=get_sub_matrix(htf,x0,y0,top,bottom,left,right);
    sthp=get_sub_matrix(thp,x0,y0,top,bottom,left,right);
    scon=get_sub_matrix(con,x0,y0,top,bottom,left,right);

    sup=get_sub_matrix(Up,x1,y0,top,bottom,left,right);
    sun=get_sub_matrix(Un,x2,y0,top,bottom,left,right);

    teni(t)=sum(sum(senp))/normi;
    thti(t)=sum(sum(shtf))/normi;
    tthi(t)=sum(sum(sthp))/normi;
    tcoi(t)=sum(sum(scon))/normi;
    toti(t)=teni(t)+thti(t)+tthi(t)+tcoi(t);
    tpui(t)=sum(sum(sun-sup))*wci/normi;
end
%}

f=figure;
lw=2;
fs=16;
thw=[0.03,0.28];
tbt=[0.20,0.08];
tlr=[0.1,0.03];

set(f,'Units','centimeter','Position',[10,10,28,11]);
ha1 = tight_subplot(1,2,thw,tbt,tlr);

%% electron thermal energy
axes(ha1(1));
p1=plot(tt,tene,'g','LineWidth',lw); hold on
p2=plot(tt,thte,'b','LineWidth',lw);
p3=plot(tt,tthe,'c','LineWidth',lw);
p4=plot(tt,tcoe,'m','LineWidth',lw);
p5=plot(tt,tote,'k','LineWidth',lw);
p6=plot(tt,tpue,'--r','LineWidth',lw); hold on
plot([0,100],[0,0],'--k','LineWidth',1); hold off
% p7=plot([0,100],[0,0],'--y','LineWidth',lw); hold off
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('dU_{e}/dt');
set(gca,'FontSize',fs);

%% ion thermal energy
axes(ha1(2));
p1=plot(tt,teni,'g','LineWidth',lw); hold on
p2=plot(tt,thti,'b','LineWidth',lw);
p3=plot(tt,tthi,'c','LineWidth',lw);
p4=plot(tt,tcoi,'m','LineWidth',lw);
p5=plot(tt,toti,'k','LineWidth',lw);
p6=plot(tt,tpui,'--r','LineWidth',lw); hold on
plot([0,100],[0,0],'--k','LineWidth',1); hold off
% p7=plot([0,100],[0,0],'--y','LineWidth',lw); hold off
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('dU_{i}/dt');
set(gca,'FontSize',fs);
l1=legend('-\nabla \cdot (uV+P \cdot V)','-\nabla \cdot q','V\cdot (\nabla \cdot P)','v_{DF}\cdot \nabla U','Sum','dU/dt','Location','Best');

set(l1,...
    'Position',[0.400466385963124 0.331826895557755 0.193820220365953 0.419315391400041],...
    'FontSize',fs);


%% textbox
annotation(f,'textbox',...
    [0.034566433566433 0.866533634358457 0.0537587399171158 0.0919282490496144],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fs+4,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.603370629370629 0.86429148189209 0.0555069916132656 0.0919282490496144],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',fs+4,...
    'FontName','Times New Roman');

% cd(outdir);
