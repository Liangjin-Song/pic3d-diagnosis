% plot figure 2, force balance
% writen by Liangjin Song on 20191206
clear;
prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters.m';
% prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters_m25.m';
run(prmfile);

normf=vA*mi*n0;

nt=length(tt);

tte=zeros(1,nt);
tpb=zeros(1,nt);
tpt=zeros(1,nt);
tot=zeros(1,nt);
tfx=zeros(1,nt);
vrf=zeros(1,nt);
vix=zeros(1,nt);

dirt=0;

for t=1:nt
    cd(indir);
    th=tt(t);
    tp=th-dt;
    tn=th+dt;

    bx=read_data('Bx',tt(t));
    bx=bx/c;
    by=read_data('By',tt(t));
    by=by/c;
    bz=read_data('Bz',tt(t));
    bz=bz/c;

    bzp=read_data('Bz',tp);
    bzp=bzp/c;
    bzn=read_data('Bz',tn);
    bzn=bzn/c;

    vi=read_data('vxi',tt(t));

    pi=read_data('presi',tt(t));
    pe=read_data('prese',tt(t));

    n=read_data('Densi',th);

    vxp=read_data('vxi',tp);
    vxn=read_data('vxi',tn);

    p=pi+pe;

    % force in x direction
    [tens,pb,pt]=calc_force(bx,by,bz,p,c,grids);

    [lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,dirt);
    [~,x0]=max(lbz);
    ste=get_sub_matrix(tens.x,x0,y0,top,bottom,left,right);
    spb=get_sub_matrix(pb.x,x0,y0,top,bottom,left,right);
    spt=get_sub_matrix(pt.x,x0,y0,top,bottom,left,right);

    % dv_x/dt
    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [~,xp]=max(lbzp);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,xn]=max(lbzn);
    svp=get_sub_matrix(vxp,xp,y0,top,bottom,left,right);
    svn=get_sub_matrix(vxn,xn,y0,top,bottom,left,right);
    sn=get_sub_matrix(n,x0,y0,top,bottom,left,right);
    sfx=mi*sn.*(svn-svp)*wci;
    vrf(t)=calc_instant_RF_velocity(lbzp,lbzn,lx,wci,di)/vA;

    svi=get_sub_matrix(vi,x0,y0,5,5,5,5);
    vix(t)=mean(mean(svi))/vA;

    tte(t)=sum(sum(ste))/normf;
    tpb(t)=sum(sum(spb))/normf;
    tpt(t)=sum(sum(spt))/normf;
    tot(t)=tte(t)+tpb(t)+tpt(t);
    tfx(t)=sum(sum(sfx))/normf;
end
%}
f=figure;
lw=2;
fs=16;
thw=[0.008,0.10];
tlu=[0.20,0.1];
tlr=[0.1,0.05];

set(f,'Units','centimeter','Position',[10,10,30,12]);
ha = tight_subplot(1,2,thw,tlu,tlr);
axes(ha(1));
plot(tt,vix,'*r','LineWidth',lw); hold on
plot(tt,vrf,'*k','LineWidth',lw); hold off
xlabel('\Omega_{ci}t');
legend('v_{ix}','v_{DF}');
xlim([tt(1),tt(end)]);
set(gca,'FontSize',fs);

axes(ha(2));
p1=plot(tt,tte,'r','LineWidth',lw); hold on
p2=plot(tt,tpb,'g','LineWidth',lw);
p3=plot(tt,tpt,'b','LineWidth',lw);
p4=plot(tt,tot,'k','LineWidth',lw);
p5=plot(tt,tfx,'--r','LineWidth',lw); hold on
plot([0,100],[0,0],'--k','LineWidth',1); hold off
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('f_x');
set(gca,'FontSize',fs);
l1=legend([p1,p2],'\nabla \cdot (BB/\mu_0)','-\nabla \cdot (B^2/2\mu_0I)','Location','Best');
set(l1,...
    'Position',[0.791332880994011 0.306169114342868 0.157848321151061 0.21973093548965],...
    'FontSize',fs,...
    'FontName','Times New Roman');
set(l1,'Box','off');
ah=axes('position',get(gca,'position'),...
            'visible','off');
l2=legend(ah,[p3,p4,p5],'-\nabla \cdot (P_i+P_e)','Sum','m_i n_i dv_x/dt');
set(l2,...
    'Position',[0.766147777502538 0.59353287243953 0.156468528134006 0.21973093548965],...
    'FontSize',fs,...
    'FontName','Times New Roman');
set(l2,'Box','off');

annotation(f,'textbox',...
    [0.0157342657342657 0.864470853822114 0.0493881106767413 0.0829596394514289],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fs+2,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.520874125874126 0.855502243956643 0.0502622365248162 0.0829596394514289],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',fs+2,...
    'FontName','Times New Roman');


cd(outdir);
