% function figure1()
%%
% writen by Liangjin Song on 20210623
% the magnetic reconnection rate and the average energy gained by per particle
% the energy spectrum
%%
run('articles.article4.parameters.m');
%% panel a
% magnetic reconnection rate
dt=0.1;
norm=prm.value.vA*dt/prm.value.wci;
xrange=[0,50];
cd(indir);
rate=load('flux2d.dat');
ttm=rate(:,1);
mrate=diff(rate)/norm;

% average energy gained by per particle
cd(indir);
en=load('energy.dat');
nt=size(en,1);
dB=zeros(1,nt);
di=zeros(1,nt);
de=zeros(1,nt);
dic=zeros(1,nt);
dice=zeros(1,nt);
rdi=zeros(1,nt);
rde=zeros(1,nt);
rdic=zeros(1,nt);
rdice=zeros(1,nt);

for t=2:nt
    dB(t)=en(t,2)-en(1,2);
    de(t)=en(t,3)-en(1,3);
    di(t)=en(t,4)-en(1,4);
    dice(t)=en(t,5)-en(1,5);
    dic(t)=en(t,6)-en(1,6);
end
sum=-(di+de+dic+dice);
% the energy change ratio
dB=abs(dB);
for t=2:nt
    rdi(t)=di(t)/dB(t);
    rde(t)=de(t)/dB(t);
    rdic(t)=dic(t)/dB(t);
    rdice(t)=dice(t)/dB(t);
end
% the number of ions
Ni=3.6929e+08;
% the number of cold ions
Nic=1.2307e+09;
% average
% ions
adi=di/Ni;
% electrons
ade=(de+dice)/(Ni+Nic);
% cold ions
adic=dic/Nic;
% normalization
tta=0.1*(0:size(en,1)-1);
norm=0.5*prm.value.mi*prm.value.vA*prm.value.vA;

%% panel b
tt1=0;
tt2=14;
tt3=25;
tt4=35;
tt5=45;
tt6=50;

c=0.5;
vA=0.0125;
cva=c/vA;
cva=cva*cva;

%% read data
cd(indir);
sm1=reset_spectrum(prm.read('spctrmh',tt1),cva);
sm2=reset_spectrum(prm.read('spctrmh',tt2),cva);
sm3=reset_spectrum(prm.read('spctrmh',tt3),cva);
sm4=reset_spectrum(prm.read('spctrmh',tt4),cva);
sm5=reset_spectrum(prm.read('spctrmh',tt5),cva);
sm6=reset_spectrum(prm.read('spctrmh',tt6),cva);
xx=-4:0.1:4;

%% figure
f=figure('Position',[500,500,1000,400]);
axes('Position',[0.09,0.2,0.35,0.7]);
% subplot(1,2,1);
yyaxis left
plot(ttm(1:end-1),mrate(:,2),'k','LineWidth',2);
xlim(xrange);
ylabel('E_R');
set(gca,'ycolor','k');
yyaxis right
plot(tta, adi/norm, '-r', 'LineWidth', 2); hold on
plot(tta, ade/norm, '-b', 'LineWidth', 2);
plot(tta, adic/norm, '-m', 'LineWidth', 2); hold off
legend('E_R','Hot Ion', 'Electron', 'Cold Ion','Location','Best','Position',[0.0925000009387732 0.756875003390014 0.113999998122454 0.241249993219972]);
xlabel('\Omega_{ci}t');
ylabel('E_{aver}');
set(gca,'FontSize',14);
set(gca,'xcolor','k');
set(gca,'ycolor','r');

% subplot(1,2,2);
axes('Position',[0.62,0.2,0.35,0.7]);
p1=plot(xx, log10(sm1),'-k','LineWidth',2); hold on
p2=plot(xx,log10(sm2),'-c','LineWidth',2);
p3=plot(xx,log10(sm3),'-g','LineWidth',2);
p4=plot(xx,log10(sm4),'-r','LineWidth',2);
p5=plot(xx,log10(sm6),'-m','LineWidth',2);
p6=plot(xx,log10(sm5),'-b','LineWidth',2); hold off
legend([p1,p2,p3,p4,p6,p5],{['\Omega_{ci} t=',num2str(tt1)],['\Omega_{ci} t=',num2str(tt2)],['\Omega_{ci} t=',num2str(tt3)],['\Omega_{ci} t=',num2str(tt4)],['\Omega_{ci} t=',num2str(tt5)],['\Omega_{ci} t=',num2str(tt6)]});
xlim([-4,4]);
ylim([0,10]);
yticks(0:1:10);
yticklabels({'0','10^{1}','10^{2}','10^{3}','10^{4}','10^{5}','10^{6}','10^{7}','10^{8}','10^{9}','10^{10}'});
xlabel('E_{ic} [m_iv_A^2]');
ylabel('f_{ic}');
xticks(-4:1:4);
xticklabels({'10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}','10^{3}','10^{4}'});
set(gca,'FontSize',14);

%% text box
annotation(f,'textbox',...
    [0.021 0.856500001862645 0.0514999987632037 0.0874999981373549],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(f,'textbox',...
    [0.542 0.851500001862645 0.0524999987334013 0.0874999981373549],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(f,'arrow',[0.691 0.815000000000001],[0.2225 0.2225],...
    'Color',[1 0 0],...
    'HeadStyle','deltoid');

annotation(f,'textbox',...
    [0.693 0.211500002011657 0.072499998137355 0.0924999979883433],...
    'Color',[1 0 0],...
    'String',{'time'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

%% save
cd(outdir);
print(f,'-dpng','-r300','figure1.png');
print(f,'-depsc','-painters','figure1.eps');


function sm=reset_spectrum(sp,cva2)
ns=length(sp);
xx=-4:0.1:4;
nx=length(xx);
sm=zeros(1,nx);
for i=1:ns
    k=log10(i/ns*cva2);
    if k<=-4
        k=1;
    elseif k>=4
        k=nx;
    else
        k=round((nx-1)*(k-4)/8+nx);
    end
    sm(k)=sm(k)+sp(i);
end
% sm=filter1d(sm);
end

function sp=filter1d(sm)
n=1;
ns=length(sm);
sp=zeros(1,ns);
sp(1)=sm(1);
sp(ns)=sm(ns);
for i=1:n
    for j=2:ns-1
        sp(j)=sm(j-1)*0.25+sm(j)*0.6+sm(j+1)*0.25;
    end
end
end