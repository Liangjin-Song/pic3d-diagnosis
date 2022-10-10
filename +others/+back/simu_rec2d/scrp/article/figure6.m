%% plot figure 4
% writen by Liangjin Song on 20191130
clear;
%{
prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters.m';

% prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters_m25.m';
run(prmfile);

normi=Ti;
norme=Te;

normpi=(3/2*n0*Ti);
normpe=(3/2*n0*Te);

nt=length(tt);

%% temperature
tthfe=zeros(1,nt);
ttste=zeros(1,nt);
ttpne=zeros(1,nt);
ttbce=zeros(1,nt);
ttcoe=zeros(1,nt);
ttote=zeros(1,nt);
tdtte=zeros(1,nt);

tthfi=zeros(1,nt);
ttsti=zeros(1,nt);
ttpni=zeros(1,nt);
ttbci=zeros(1,nt);
ttcoi=zeros(1,nt);
ttoti=zeros(1,nt);
tdtti=zeros(1,nt);

%% Pi-D
tixx=zeros(1,nt);
tixy=zeros(1,nt);
tixz=zeros(1,nt);
tiyy=zeros(1,nt);
tiyz=zeros(1,nt);
tizz=zeros(1,nt);
tiot=zeros(1,nt);
tist=zeros(1,nt);

texx=zeros(1,nt);
texy=zeros(1,nt);
texz=zeros(1,nt);
teyy=zeros(1,nt);
teyz=zeros(1,nt);
tezz=zeros(1,nt);
teot=zeros(1,nt);
test=zeros(1,nt);

% field alginment of Pi-D
% Diagnol
tediag=zeros(1,nt);
% Non-Diagnol
tendia=zeros(1,nt);
% total
tealgn=zeros(1,nt);

% Diagnol
tidiag=zeros(1,nt);
% Non-Diagnol
tindia=zeros(1,nt);
% total
tialgn=zeros(1,nt);

% p nabla dot v
tipvt=zeros(1,nt);
tipvx=zeros(1,nt);
tipvz=zeros(1,nt);
tipva=zeros(1,nt);

tepvt=zeros(1,nt);
tepvx=zeros(1,nt);
tepvz=zeros(1,nt);
tepva=zeros(1,nt);


for t=1:nt
    cd(indir);
    tm=tt(t);
    tp=tm-dt;
    tn=tm+dt;

    %% electron
    pep=read_data('prese',tp);
    nep=read_data('Dense',tp);
    pen=read_data('prese',tn);
    nen=read_data('Dense',tn);

    pe=read_data('prese',tm);
    qfluxe=read_data('qfluxe',tm);

    vex=read_data('vxe',tm);
    vey=read_data('vye',tm);
    vez=read_data('vze',tm);

    ne=read_data('Dense',tm);

    %% ion
    pip=read_data('presi',tp);
    nip=read_data('Densi',tp);
    pin=read_data('presi',tn);
    nin=read_data('Densi',tn);

    pi=read_data('presi',tm);
    qfluxi=read_data('qfluxi',tm);

    vix=read_data('vxi',tm);
    viy=read_data('vyi',tm);
    viz=read_data('vzi',tm);

    ni=read_data('Densi',tm);

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

    %% electron temperature
    [T,hfx,tst,tpn,bct,con]=calc_dT_dt_v_RF_timing(pe,qfluxe,vex,vey,vez,ne,grids,Lx,Ly,z0,bzp,bzn,wci,di);

    [Ppxx,~,~,Ppyy,~,Ppzz]=reshap_pressure(pep,ndy,ndx);
    tppp=calc_scalar_temperature(Ppxx,Ppyy,Ppzz,nep);
    [Pnxx,~,~,Pnyy,~,Pnzz]=reshap_pressure(pen,ndy,ndx);
    tppn=calc_scalar_temperature(Pnxx,Pnyy,Pnzz,nen);

    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);
    [~,xp]=max(lbzp);
    [~,xn]=max(lbzn);
    % integrating in a rectangle
    shfx=get_sub_matrix(hfx,x0,y0,top,bottom,left,right);
    stst=get_sub_matrix(tst,x0,y0,top,bottom,left,right);
    stpn=get_sub_matrix(tpn,x0,y0,top,bottom,left,right);
    sbct=get_sub_matrix(bct,x0,y0,top,bottom,left,right);
    scon=get_sub_matrix(con,x0,y0,top,bottom,left,right);

    stppp=get_sub_matrix(tppp,xp,y0,top,bottom,left,right);
    stppn=get_sub_matrix(tppn,xn,y0,top,bottom,left,right);

    tdtte(t)=(sum(sum(stppn))-sum(sum(stppp)))*wci/norme;
    tthfe(t)=sum(sum(shfx))/norme;
    ttste(t)=sum(sum(stst))/norme;
    ttpne(t)=sum(sum(stpn))/norme;
    ttbce(t)=sum(sum(sbct))/norme;
    ttcoe(t)=sum(sum(scon))/norme;
    ttote(t)=tthfe(t)+ttste(t)+ttpne(t)+ttbce(t)+ttcoe(t);

    %% ion temperature
    [T,hfx,tst,tpn,bct,con]=calc_dT_dt_v_RF_timing(pi,qfluxi,vix,viy,viz,ni,grids,Lx,Ly,z0,bzp,bzn,wci,di);

    [Ppxx,~,~,Ppyy,~,Ppzz]=reshap_pressure(pip,ndy,ndx);
    tppp=calc_scalar_temperature(Ppxx,Ppyy,Ppzz,nip);
    [Pnxx,~,~,Pnyy,~,Pnzz]=reshap_pressure(pin,ndy,ndx);
    tppn=calc_scalar_temperature(Pnxx,Pnyy,Pnzz,nin);

    % integrating in a rectangle
    shfx=get_sub_matrix(hfx,x0,y0,top,bottom,left,right);
    stst=get_sub_matrix(tst,x0,y0,top,bottom,left,right);
    stpn=get_sub_matrix(tpn,x0,y0,top,bottom,left,right);
    sbct=get_sub_matrix(bct,x0,y0,top,bottom,left,right);
    scon=get_sub_matrix(con,x0,y0,top,bottom,left,right);

    stppp=get_sub_matrix(tppp,xp,y0,top,bottom,left,right);
    stppn=get_sub_matrix(tppn,xn,y0,top,bottom,left,right);

    tdtti(t)=(sum(sum(stppn))-sum(sum(stppp)))*wci/normi;

    tthfi(t)=sum(sum(shfx))/normi;
    ttsti(t)=sum(sum(stst))/normi;
    ttpni(t)=sum(sum(stpn))/normi;
    ttbci(t)=sum(sum(sbct))/normi;
    ttcoi(t)=sum(sum(scon))/normi;
    ttoti(t)=tthfi(t)+ttsti(t)+ttpni(t)+ttbci(t)+ttcoi(t);

    %% electron stress tensor, Pi-D
    [pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(pe,ndy,ndx);
    [ts,to,pdxx,pdxy,pdxz,pdyy,pdyz,pdzz]=calc_pi_D(pxx,pxy,pxz,pyy,pyz,pzz,vex,vey,vez,grids);
    [pvt,pvx,pvz]=calc_temperature_p_nabla_v(vex,vey,vez,pxx,pyy,pzz,grids);
    tpn=calc_divergence(vex,vey,vez,grids);
    ppp=(pxx+pyy+pzz)/3;
    ppp=ppp.*tpn;

    % electron Pi-D in field aligned coordinate system
    [~,egyro, engyr]=calc_pi_D_fac(pe,vex,vey,vez,bx,by,bz,grids);

    sxx=get_sub_matrix(pdxx,x0,y0,top,bottom,left,right);
    sxy=get_sub_matrix(pdxy,x0,y0,top,bottom,left,right);
    sxz=get_sub_matrix(pdxz,x0,y0,top,bottom,left,right);
    syy=get_sub_matrix(pdyy,x0,y0,top,bottom,left,right);
    syz=get_sub_matrix(pdyz,x0,y0,top,bottom,left,right);
    szz=get_sub_matrix(pdzz,x0,y0,top,bottom,left,right);
    sto=get_sub_matrix(to,x0,y0,top,bottom,left,right);

    sts=get_sub_matrix(ts,x0,y0,top,bottom,left,right);

    spvt=get_sub_matrix(pvt,x0,y0,top,bottom,left,right);
    spvx=get_sub_matrix(pvx,x0,y0,top,bottom,left,right);
    spvz=get_sub_matrix(pvz,x0,y0,top,bottom,left,right);
    spvp=get_sub_matrix(ppp,x0,y0,top,bottom,left,right);

    segyro=get_sub_matrix(egyro,x0,y0,top,bottom,left,right);
    sengyr=get_sub_matrix(engyr,x0,y0,top,bottom,left,right);

    texx(t)=sum(sum(sxx))/normpe;
    texy(t)=sum(sum(sxy))/normpe;
    texz(t)=sum(sum(sxz))/normpe;
    teyy(t)=sum(sum(syy))/normpe;
    teyz(t)=sum(sum(syz))/normpe;
    tezz(t)=sum(sum(szz))/normpe;
    teot(t)=sum(sum(sto))/normpe;
    test(t)=sum(sum(sts))/normpe;

    tepvt(t)=sum(sum(spvt))/normpe;
    tepvx(t)=sum(sum(spvx))/normpe;
    tepvz(t)=sum(sum(spvz))/normpe;
    tepva(t)=sum(sum(spvp))/normpe;

    tediag(t)=sum(sum(segyro))/normpe;
    tendia(t)=sum(sum(sengyr))/normpe;
    tealgn(t)=tediag(t)+tendia(t);


    %% ion stress tensor, Pi-D
    [pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(pi,ndy,ndx);
    [ts,to,pdxx,pdxy,pdxz,pdyy,pdyz,pdzz]=calc_pi_D(pxx,pxy,pxz,pyy,pyz,pzz,vix,viy,viz,grids);
    [pvt,pvx,pvz]=calc_temperature_p_nabla_v(vix,viy,viz,pxx,pyy,pzz,grids);
    tpn=calc_divergence(vix,viy,viz,grids);
    ppp=(pxx+pyy+pzz)/3;
    ppp=ppp.*tpn;

    % electron Pi-D in field aligned coordinate system
    [~,igyro, ingyr]=calc_pi_D_fac(pi,vix,viy,viz,bx,by,bz,grids);

    sxx=get_sub_matrix(pdxx,x0,y0,top,bottom,left,right);
    sxy=get_sub_matrix(pdxy,x0,y0,top,bottom,left,right);
    sxz=get_sub_matrix(pdxz,x0,y0,top,bottom,left,right);
    syy=get_sub_matrix(pdyy,x0,y0,top,bottom,left,right);
    syz=get_sub_matrix(pdyz,x0,y0,top,bottom,left,right);
    szz=get_sub_matrix(pdzz,x0,y0,top,bottom,left,right);
    sto=get_sub_matrix(to,x0,y0,top,bottom,left,right);

    sts=get_sub_matrix(ts,x0,y0,top,bottom,left,right);

    spvt=get_sub_matrix(pvt,x0,y0,top,bottom,left,right);
    spvx=get_sub_matrix(pvx,x0,y0,top,bottom,left,right);
    spvz=get_sub_matrix(pvz,x0,y0,top,bottom,left,right);
    spvp=get_sub_matrix(ppp,x0,y0,top,bottom,left,right);

    sigyro=get_sub_matrix(igyro,x0,y0,top,bottom,left,right);
    singyr=get_sub_matrix(ingyr,x0,y0,top,bottom,left,right);

    tixx(t)=sum(sum(sxx))/normpi;
    tixy(t)=sum(sum(sxy))/normpi;
    tixz(t)=sum(sum(sxz))/normpi;
    tiyy(t)=sum(sum(syy))/normpi;
    tiyz(t)=sum(sum(syz))/normpi;
    tizz(t)=sum(sum(szz))/normpi;
    tiot(t)=sum(sum(sto))/normpi;
    tist(t)=sum(sum(sts))/normpi;

    tipvt(t)=sum(sum(spvt))/normpi;
    tipvx(t)=sum(sum(spvx))/normpi;
    tipvz(t)=sum(sum(spvz))/normpi;
    tipva(t)=sum(sum(spvp))/normpi;

    tidiag(t)=sum(sum(sigyro))/normpi;
    tindia(t)=sum(sum(singyr))/normpi;
    tialgn(t)=tidiag(t)+tindia(t);

end
%}

load('figure6.mat');

f=figure;
lw=2;
fs=16;
thw=[0.035,0.27];
tlu=[0.08,0.04];
tlr=[0.1,0.03];
xrange=[tt(1),tt(end)];

set(f,'Units','centimeter','Position',[10,10,30,30]);
ha1 = tight_subplot(4,2,thw,tlu,tlr);

%% electron temperature
axes(ha1(1));
p1=plot(tt,tthfe,'r','LineWidth',lw); hold on
p2=plot(tt,ttste,'g','LineWidth',lw);
p3=plot(tt,ttpne,'b','LineWidth',lw);
p4=plot(tt,ttbce,'c','LineWidth',lw);
p5=plot(tt,ttcoe,'m','LineWidth',lw);
p6=plot(tt,ttote,'k','LineWidth',lw);
p7=plot(tt,tdtte,'--r','LineWidth',lw); hold on
p8=plot([0,100],[0,0],'--k','LineWidth',1); hold off
xlim(xrange);
% xlabel('\Omega_{ci}t');
set(gca,'xticklabel',[]);
ylabel('dT_{e}/dt');
set(gca,'FontSize',fs);

%% ion temperature
axes(ha1(2));
p1=plot(tt,tthfi,'r','LineWidth',lw); hold on
p2=plot(tt,ttsti,'g','LineWidth',lw);
p3=plot(tt,ttpni,'b','LineWidth',lw);
p4=plot(tt,ttbci,'c','LineWidth',lw);
p5=plot(tt,ttcoi,'m','LineWidth',lw);
p6=plot(tt,ttoti,'k','LineWidth',lw);
p7=plot(tt,tdtti,'--r','LineWidth',lw); hold on
p8=plot([0,100],[0,0],'--k','LineWidth',1); hold off
xlim(xrange);
% xlabel('\Omega_{ci}t');
set(gca,'xticklabel',[]);
ylabel('dT_{i}/dt');
set(gca,'FontSize',fs);

l=legend('-2*\nabla \cdot q/3*n','-2*(P''\cdot \nabla) \cdot v/3*n','-2*p\nabla \cdot v/3*n','-v\cdot \nabla T','v_{DF}\cdot \nabla T','Sum','dT/dt','Location','Best');



%% electron Pi-D
axes(ha1(3));
p1=plot(tt,texx,'r','LineWidth',lw); hold on
p2=plot(tt,texy*2,'c','LineWidth',lw); hold on
p3=plot(tt,texz*2,'m','LineWidth',lw); hold on
p4=plot(tt,teyy,'g','LineWidth',lw); hold on
p5=plot(tt,teyz*2,'--b','LineWidth',lw); hold on
p6=plot(tt,tezz,'b','LineWidth',lw); hold on
p7=plot(tt,teot,'k','LineWidth',lw); hold on
% p8=plot(tt,test,'--r','LineWidth',lw); hold off
p8=plot([0,100],[0,0],'--k','LineWidth',1); hold off

xlim(xrange);
set(gca,'xticklabel',[]);
ylabel('(P''_{e} \cdot \nabla)\cdot V_e');
set(gca,'FontSize',fs);



%% ion Pi-D
axes(ha1(4));
p1=plot(tt,tixx,'r','LineWidth',lw); hold on
p2=plot(tt,tixy*2,'c','LineWidth',lw); hold on
p3=plot(tt,tixz*2,'m','LineWidth',lw); hold on
p4=plot(tt,tiyy,'g','LineWidth',lw); hold on
p5=plot(tt,tiyz*2,'--b','LineWidth',lw); hold on
p6=plot(tt,tizz,'b','LineWidth',lw); hold on
p7=plot(tt,tiot,'k','LineWidth',lw); hold on
% p8=plot(tt,tist,'--r','LineWidth',lw); hold off
p8=plot([0,100],[0,0],'--k','LineWidth',1); hold off

xlim(xrange);
set(gca,'xticklabel',[]);
ylabel('(P''_{i} \cdot \nabla)\cdot V_i');
set(gca,'FontSize',fs);
l=legend('(Pi-D)_{xx}','2*(Pi-D)_{xy}','2*(Pi-D)_{xz}','(Pi-D)_{yy}','2*(Pi-D)_{yz}','(Pi-D)_{zz}','Sum');



axes(ha1(5));
plot(tt,tediag,'r','LineWidth',lw); hold on
plot(tt,tendia,'b','LineWidth',lw);
plot(tt,tealgn,'k','LineWidth',lw); hold off
% plot([0,100],[0,0],'--y','LineWidth',lw); hold off
xlim(xrange);
set(gca,'xticklabel',[]);
ylabel('(P''_{e} \cdot \nabla)\cdot V_e');
set(gca,'FontSize',fs);
l=legend('Diagonal','Off-Diagonal','Sum');



axes(ha1(6));
plot(tt,tidiag,'r','LineWidth',lw); hold on
plot(tt,tindia,'b','LineWidth',lw);
plot(tt,tialgn,'k','LineWidth',lw); hold on
plot([0,100],[0,0],'--k','LineWidth',1); hold off
xlim(xrange);
set(gca,'xticklabel',[]);
ylabel('(P''_{i} \cdot \nabla)\cdot V_i');
set(gca,'FontSize',fs);

axes(ha1(7));
plot(tt,tepvx,'r','LineWidth',lw); hold on
plot(tt,tepvz,'b','LineWidth',lw);
plot(tt,tepvt,'k','LineWidth',lw); hold on
% plot(tt,tepva,'--r','LineWidth',lw); hold off
plot([0,100],[0,0],'--k','LineWidth',1); hold off
xlim(xrange);
xlabel('\Omega_{ci}t');
ylabel('p\nabla \cdot V_e');
set(gca,'FontSize',fs);


axes(ha1(8));
plot(tt,tipvx,'r','LineWidth',lw); hold on
plot(tt,tipvz,'b','LineWidth',lw);
plot(tt,tipvt,'k','LineWidth',lw); hold on
plot([0,100],[0,0],'--k','LineWidth',1); hold off
% plot(tt,tipva,'--r','LineWidth',lw); hold off
xlim(xrange);
xlabel('\Omega_{ci}t');
l=legend('p\partial v_x/\partial x','p\partial v_z/\partial z','Sum');
ylabel('p\nabla \cdot V_i');
set(gca,'FontSize',fs);

annotation(f,'textbox',...
    [0.0183566433566434 0.943924406916483 0.0493881106767413 0.0399568025867574],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(f,'textbox',...
    [0.590909090909091 0.943924406916486 0.0502622365248162 0.0399568025867574],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(f,'textbox',...
    [0.0157342657342657 0.716062635858168 0.0493881106767413 0.0399568025867574],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(f,'textbox',...
    [0.591783216783217 0.718222463071993 0.0502622365248162 0.0399568025867574],...
    'String',{'(d)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(f,'textbox',...
    [0.013986013986014 0.491440605620588 0.0493881106767413 0.0399568025867574],...
    'String',{'(e)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(f,'textbox',...
    [0.59527972027972 0.482801296765297 0.0467657331325166 0.0399568025867574],...
    'String',{'(f)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(f,'textbox',...
    [0.0166083916083916 0.252779698493157 0.0502622365248162 0.0399568025867574],...
    'String',{'(g)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(f,'textbox',...
    [0.598776223776223 0.262498920955361 0.0502622365248162 0.0399568025867574],...
    'String',{'(h)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

% cd(outdir);
