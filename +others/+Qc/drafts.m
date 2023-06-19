clear      %%系统状态是zi=xi-x0
%% 触发状态和系统后的状态两个变量直接用相等的变量。
%% 时变的记忆包加入
v=load('E:\variable.mat');
P=v.Q; %% take out inv(P).
K=v.K;
A=v.A;    
B=v.B;
F=v.F;
H=v.H;
alpha = v.alpha; % >0
beta1=v.beta1;
% beta2 = 3.2312e+03; %%
lambda1=v.lambda1;
lambdaN=v.lambdaN;
delta=v.delta;   
s=v.s;
W1=(P*B)*(B'*P);
r=3;
rho1=0.8; rho2=2; rho3=0.3; %>0
mur=0.2;

mu1=0.5;
mu2=0.3;
mu3=0.2;

x00=[-1;-1;1;1];  %%%%%%%%%  领导智能体状态初值
z10=[1;3;-1;3]-x00; %%%%%%%%%  智能体初值
z20=[1;1.5;-1;0.5]-x00;
z30=[0;0.8;-1;3]-x00; 
z40=[-1;-1;0.2;2]-x00;
z50=[-1.5;-1;-3;2.4]-x00;
z60=[-3;-1.1;3.1;1.2]-x00;
z70=[0.1;1;0.2;-2]-x00;
X1=z10; X2=z20; X3=z30; X4=z40; X5=z50; X6=z60; X7=z70;  %% 记录系统状态

%%%%%%%%% 组合变量的历史触发初值 %%%%%%%% 
    O=[0;0;0;0];  I=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
    p1_1=(z10-z20)+(z10-z40)+(z10-z50) +0;  p1_2=p1_1; p1_3=p1_1; p1=p1_1;
    p2_1=(z20-z10)+(z20-z30) +(z20);     p2_2=p2_1; p2_3=p2_1;    p2=p2_1;
    p3_1=(z30-z20)+(z30-z50)+(z30-z60) +0;  p3_2=p3_1; p3_3=p3_1; p3=p3_1;
    p4_1=(z40-z10)+(z40-z70) +0;         p4_2=p4_1;  p4_3=p4_1;   p4=p4_1;
    p5_1=(z50-z10)+(z50-z30) +0;         p5_2=p5_1;  p5_3=p5_1;   p5=p5_1;
    p6_1=(z60-z30)+(z60-z70) +(z60);  p6_2=p6_1;  p6_3=p6_1;      p6=p6_1;
    p7_1=(z70-z40)+(z70-z60) +(z70);  p7_2=p7_1;  p7_3=p7_1;      p7=p7_1;
        RT1=rho1+rho2*exp(-rho3*norm(p1));    ceRT1=ceil(RT1);  % 动态变量的初值
        RT2=rho1+rho2*exp(-rho3*norm(p2));    ceRT2=ceil(RT2);
        RT3=rho1+rho2*exp(-rho3*norm(p3));    ceRT3=ceil(RT3);
        RT4=rho1+rho2*exp(-rho3*norm(p4));    ceRT4=ceil(RT4);
        RT5=rho1+rho2*exp(-rho3*norm(p5));    ceRT5=ceil(RT5);
        RT6=rho1+rho2*exp(-rho3*norm(p6));    ceRT6=ceil(RT6);
        RT7=rho1+rho2*exp(-rho3*norm(p7));    ceRT7=ceil(RT7);
P1=p1_1; P2=p2_1; P3=p3_1; P4=p4_1; P5=p5_1; P6=p6_1; P7=p7_1; %% 记录系统的组合状态

pk1=[O p1_3 p1_2 p1_1]; pk2=[O p2_3 p2_2 p2_1]; pk3=[O p3_3 p3_2 p3_1]; pk4=[O p4_3 p4_2 p4_1]; 
pk5=[O p5_3 p5_2 p5_1]; pk6=[O p6_3 p6_2 p6_1]; pk7=[O p7_3 p7_2 p7_1]; % 触发数组的初值
t1=O ;  t2=O ;  t3=O ;  t4=O ;  t5=O ;  t6=O ;  t7=O ;   % 触发数组的初始时刻
f1=0;  f2=0;  f3=0;  f4=0;  f5=0;  f6=0;  f7=0;   % 触发次数的初值
t=0;

h=0.001;  % 0.01
n=5000;    %仿真时长t=h*n. n=500
for k=1:n
    fx1=[0;0;0;0.333*sin(z10(3,1)) ];    fx2=[0;0;0;0.333*sin(z20(3,1)) ];    fx3=[0;0;0;0.333*sin(z30(3,1)) ];
        fx4=[0;0;0;0.333*sin(z40(3,1)) ];    fx5=[0;0;0;0.333*sin(z50(3,1)) ];    fx6=[0;0;0;0.333*sin(z60(3,1)) ];
            fx7=[0;0;0;0.333*sin(z70(3,1)) ];        %%% nonlinear %%%
%%   % 数值相差越小（越平稳），需要的历史数据越多，以防突变情况，于是rho3>0.
    rt1=rho1+rho2*exp(-rho3*norm(p1));  rt2=rho1+rho2*exp(-rho3*norm(p2));  rt3=rho1+rho2*exp(-rho3*norm(p3));
      rt4=rho1+rho2*exp(-rho3*norm(p4));  rt5=rho1+rho2*exp(-rho3*norm(p5));  rt6=rho1+rho2*exp(-rho3*norm(p6));
        rt7=rho1+rho2*exp(-rho3*norm(p7));    % N个智能体对应的动态参数变化
    cert1=ceil(rt1);  cert2=ceil(rt2);  cert3=ceil(rt3);  cert4=ceil(rt4);  cert5=ceil(rt5);  cert6=ceil(rt6);  cert7=ceil(rt7); 
    cert=[cert1 cert2 cert3 cert4 cert5 cert6 cert7];  % N个智能体的r(t)向上取整的数组
    RT1=[RT1 rt1]; RT2=[RT2 rt2]; RT3=[RT3 rt3]; RT4=[RT4 rt4]; RT5=[RT5 rt5]; RT6=[RT6 rt6]; RT7=[RT7 rt7]; % r(t)的数组
    ceRT1=[ceRT1 cert1];  ceRT2=[ceRT2 cert2];  ceRT3=[ceRT3 cert3];  ceRT4=[ceRT4 cert4];                   % r(t)取整的数组
      ceRT5=[ceRT5 cert5];  ceRT6=[ceRT6 cert6];  ceRT7=[ceRT7 cert7];
for i=1:7
    if cert(i)==1
        mu1(i)=1; mu2(i)=0; mu3(i)=0;
        r2(i)=0; r3(i)=0;
    elseif cert(i)==2
        mu1(i)=0.7; mu2(i)=0.3; mu3(i)=0;
        r2(i)=1/2; r3(i)=0;
    elseif cert(i)==3
        mu1(i)=0.5; mu2(i)=0.3; mu3(i)=0.2;
        r2(i)=1/2; r3(i)=1/3;
    else
        disp('error!')
    end
end
%%   
%     x0=(I+h*A)*x00+h*fx0;        %%%连续系统%%%
    z1=(I+h*A)*z10+h*fx1-h*B*(K*p1_1+r2(1)*K*p1_2+r3(1)*K*p1_3 );   %% Kr=1/r*K
    z2=(I+h*A)*z20+h*fx2-h*B*(K*p2_1+r2(2)*K*p2_2+r3(2)*K*p2_3 ); 
    z3=(I+h*A)*z30+h*fx3-h*B*(K*p3_1+r2(3)*K*p3_2+r3(3)*K*p3_3 ); 
    z4=(I+h*A)*z40+h*fx4-h*B*(K*p4_1+r2(4)*K*p4_2+r3(4)*K*p4_3 );
    z5=(I+h*A)*z50+h*fx5-h*B*(K*p5_1+r2(5)*K*p5_2+r3(5)*K*p5_3 );
    z6=(I+h*A)*z60+h*fx6-h*B*(K*p6_1+r2(6)*K*p6_2+r3(6)*K*p6_3 ); 
    z7=(I+h*A)*z70+h*fx7-h*B*(K*p7_1+r2(7)*K*p7_2+r3(7)*K*p7_3 );    
        p1=(z1-z2)+((z1)-(z4))+((z1)-(z5)) +0;   %%%% 组合变量的更新值
        p2=((z2)-(z1))+((z2)-(z3)) +(z2);
        p3=((z3)-(z2))+((z3)-(z5))+((z3)-(z6)) +0;
        p4=((z4)-(z1))+((z4)-(z7)) +0;
        p5=((z5)-(z1))+((z5)-(z3)) +0;
        p6=((z6)-(z3))+((z6)-(z7)) +(z6);
        p7=((z7)-(z4))+((z7)-(z6)) +(z7);  
    P1=[P1 p1]; P2=[P2 p2]; P3=[P3 p3]; P4=[P4 p4]; P5=[P5 p5]; P6=[P6 p6]; P7=[P7 p7];  % 记录pi的值用到r(t)里。
    X1=[X1 z1]; X2=[X2 z2]; X3=[X3 z3]; X4=[X4 z4]; X5=[X5 z5]; X6=[X6 z6]; X7=[X7 z7];  %%% 记录系统状态
    t=[t; k*h];
    z10=z1;   z20=z2;   z30=z3;   z40=z4;   z50=z5;   z60=z6;    z70=z7;
%%                              %%%%%%%%%%%%%%%%%%%%%%% 第一个智能体的 METS  %%%%%%%%%%%%%%%%%%%%%%  
    e11=p1-pk1(:,length(pk1));  % 触发误差，这里的pk1_1, p1_2,p1_3不受攻击
    e12=p1-pk1(:,length(pk1)-1);
    e13=p1-pk1(:,length(pk1)-2);
    if (k>=2200 && k<=2250)||(k>=3850 && k<=3950)
        W1=s*(P*B)*(B'*P);
    else
        W1=(P*B)*(B'*P);
    end
    if mu1(1)*(e11'*W1*e11)+mu2(1)*(e12'*W1*e12)+mu3(1)*(e13'*W1*e13)>delta*(p1'*W1*p1)
        p1_3=p1_2;
        p1_2=p1_1;
        p1_1=p1;
        pk1=[pk1 p1_1];   %%%  储存触发状态
        t1=[t1; k*h];
        f1=f1+1;        %%%  触发次数
        if (k>=2200 && k<=2250)||(k>=3850 && k<=3950) %先触发再攻击
            p1_1=s*p1_1;
            p1_2=s*p1_2;
            p1_3=s*p1_3;
        end
    end
    %%                     %%%%%%%%%%%%%%%%%%%%%%% 第二个METS   %%%%%%%%%%%%%%%%%%%
    e21=p2-pk2(:,length(pk2));  % 触发误差
    e22=p2-pk2(:,length(pk2)-1);
    e23=p2-pk2(:,length(pk2)-2);
    if (k>=90 && k<120)||(k>=500 && k<=640)||(k>1000 && k<=1040)||(k>=2200 && k<=2250)||(k>=3850 && k<=3950)  %先触发再攻击
        W1=s*(P*B)*(B'*P);
    else
        W1=(P*B)*(B'*P);
    end
    if mu1(2)*(e21'*W1*e21)+mu2(2)*(e22'*W1*e22)+mu3(2)*(e23'*W1*e23)>delta*(p2)'*W1*p2
        p2_3=p2_2;
        p2_2=p2_1;
        p2_1=p2;
        pk2=[pk2 p2];   %%%  储存触发状态
        t2=[t2; k*h];
        f2=f2+1;        %%%  触发次数      
        if (k>=90 && k<120)||(k>=500 && k<=640)||(k>1000 && k<=1040)||(k>=2200 && k<=2250)||(k>=3850 && k<=3950) %先触发再攻击
            p2_1=s*p2_1;
            p2_2=s*p2_2;
            p2_3=s*p2_3;
        end
    end
    %%                      %%%%%%%%%%%%%%%%%%%%%%% 第三个METS  %%%%%%%%%%%%%%%%%%%%%% 
    e31=p3-pk3(:,length(pk3));  % 触发误差
    e32=p3-pk3(:,length(pk3)-1);
    e33=p3-pk3(:,length(pk3)-2);
    if (k>1200 && k<=1260)||(k>=1560 && k<=1650)||(k>=1980 && k<=2050)  %先触发再攻击
        W1=s*(P*B)*(B'*P);
    else
        W1=(P*B)*(B'*P);
    end
    if mu1(3)*(e31'*W1*e31)+mu2(3)*(e32'*W1*e32)+mu3(3)*(e33'*W1*e33)>delta*(p3)'*W1*p3
        p3_3=p3_2;
        p3_2=p3_1;
        p3_1=p3;
        pk3=[pk3 p3];   %%%  储存触发状态
        t3=[t3; k*h];
        f3=f3+1;        %%%  触发次数
        if (k>1200 && k<=1260)||(k>=1560 && k<=1650)||(k>=1980 && k<=2050) %先触发再攻击
            p3_1=s*p3_1;
            p3_2=s*p3_2;
            p3_3=s*p3_3;
        end
    end
    %%                        %%%%%%%%%%%%%%%%%%%%%%% 第四个METS   %%%%%%%%%%%%%%%%%%%%%%% 
    e41=p4-pk4(:,length(pk4));  % 触发误差
    e42=p4-pk4(:,length(pk4)-1);
    e43=p4-pk4(:,length(pk4)-2);
    if (k>=90 && k<120)||(k>=500 && k<=640)||(k>1000 && k<=1040) %先触发再攻击
        W1=s*(P*B)*(B'*P);
    else
        W1=(P*B)*(B'*P);
    end
    if mu1(4)*(e41'*W1*e41)+mu2(4)*(e42'*W1*e42)+mu3(4)*(e43'*W1*e43)>delta*(p4)'*W1*p4
        p4_3=p4_2;
        p4_2=p4_1;
        p4_1=p4;
        pk4=[pk4 p4];   %%%  储存触发状态
        t4=[t4; k*h];
        f4=f4+1;        %%%  触发次数
        if (k>=90 && k<120)||(k>=500 && k<=640)||(k>1000 && k<=1040) %先触发再攻击
            p4_1=s*p4_1;
            p4_2=s*p4_2;
            p4_3=s*p4_3;
        end
    end
    %%                              %%%%%%%%%%%%%%%%%%%%%%% 第五个智能体的 METS  %%%%%%%%%%%%%%%%%%%%%%  
    e51=p5-pk5(:,length(pk5));  % 触发误差
    e52=p5-pk5(:,length(pk5)-1);
    e53=p5-pk5(:,length(pk5)-2);
    if (k>1200 && k<=1260)||(k>=1560 && k<=1650)||(k>=1980 && k<=2050) %先触发再攻击
        W1=s*(P*B)*(B'*P);
    else
        W1=(P*B)*(B'*P);
    end
    if mu1(5)*(e51'*W1*e51)+mu2(5)*(e52'*W1*e52)+mu3(5)*(e53'*W1*e53)>delta*(p5)'*W1*p5
        p5_3=p5_2;
        p5_2=p5_1;
        p5_1=p5;
        pk5=[pk5 p5];   %%%  储存触发状态
        t5=[t5; k*h];
        f5=f5+1;        %%%  触发次数
        if (k>1200 && k<=1260)||(k>=1560 && k<=1650)||(k>=1980 && k<=2050) %先触发再攻击
            p5_1=s*p5_1;
            p5_2=s*p5_2;
            p5_3=s*p5_3;
        end
    end
    %%                     %%%%%%%%%%%%%%%%%%%%%%% 第六个METS   %%%%%%%%%%%%%%%%%%%
    e61=p6-pk6(:,length(pk6));  % 触发误差
    e62=p6-pk6(:,length(pk6)-1);
    e63=p6-pk6(:,length(pk6)-2);
    if (k>=90 && k<120)||(k>=500 && k<=640)||(k>1000 && k<=1040) %先触发再攻击
        W1=s*(P*B)*(B'*P);
    else
        W1=(P*B)*(B'*P);
    end
    if mu1(6)*(e61'*W1*e61)+mu2(6)*(e62'*W1*e62)+mu3(6)*(e63'*W1*e63)>delta*(p6)'*W1*p6
        p6_3=p6_2;
        p6_2=p6_1;
        p6_1=p6;
        pk6=[pk6 p6];   %%%  储存触发状态
        t6=[t6; k*h];
        f6=f6+1;        %%%  触发次数
        if (k>=90 && k<120)||(k>=500 && k<=640)||(k>1000 && k<=1040) %先触发再攻击
            p6_1=s*p6_1;
            p6_2=s*p6_2;
            p6_3=s*p6_3;
        end
    end
    %%                      %%%%%%%%%%%%%%%%%%%%%%% 第七个METS  %%%%%%%%%%%%%%%%%%%%%% 
    e71=p7-pk7(:,length(pk7));  % 触发误差
    e72=p7-pk7(:,length(pk7)-1);
    e73=p7-pk7(:,length(pk7)-2);
    if mu1(7)*(e71'*W1*e71)+mu2(7)*(e72'*W1*e72)+mu3(7)*(e73'*W1*e73)>delta*(p7)'*W1*p7
        p7_3=p7_2;
        p7_2=p7_1;
        p7_1=p7;
        pk7=[pk7 p7];   %%%  储存触发状态
        t7=[t7; k*h];
        f7=f7+1;        %%%  触发次数       
    end
end
 %%
X1_1=X1(1,:);
X1_2=X1(2,:);
X2_1=X2(1,:);
X2_2=X2(2,:);
X3_1=X3(1,:);
X3_2=X3(2,:);
X4_1=X4(1,:);
X4_2=X4(2,:);

% figure;    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% alternate attacks %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% h=0.001;
% k12=[220:225]*h; k21=[385:395]*h; % 1 2
% k035=[120 :126]*h; k35=[156 :165]*h; k53=[198:205]*h;  % 3,5
% k246=[9:12]*h; k264=[50 :64]*h; k624=[100:104]*h;  %2 4,6
% x=([k12 k21 k12 k21 k035 k35 k53 k035 k35 k53 k246 k264 k624 k246 k264 k624 k246 k264 k624]);
% y=[1 1 2 2 3 3 3 5 5 5 2 2 2 4 4 4 6 6 6];
% y12=zeros(1,length(k12));
% 
% 
% up=1;
% s(1:n*h)=0;
%     s(0.09/h:0.12/h)=up;
%     s(0.19/h:0.24/h)=up;
%     s(0.5/h:0.64/h)=up;
%     s(1/h:1.04/h)=up;
%     s(1.85/h:1.95/h)=up;
%     s(2.2/h:2.25/h)=up;
% xx=h*(1:n);
% y=zeros(1,n);
% plot(xx,s,'color',[0.9,0.9,0.9]);  
% hold on  %%%%
% plot(xx,y,'color',[0.9,0.9,0.9]); 
% fill([xx fliplr(xx)],[y fliplr(s)],[0.9,0.9,0.9],'EdgeColor',[0.9,0.9,0.9]);%浅灰色
% plot([0,3],[3,3],'k') %
% hold on %%%%
% down=-2;
% s(1:n)=0;
%     s(0.09/h:0.12/h)=down;
%     s(0.19/h:0.24/h)=down;
%     s(0.5/h:0.64/h)=down;
%     s(1/h:1.04/h)=down;
%     s(1.85/h:1.95/h)=down;
%     s(2.2/h:2.25/h)=down;
% xx=h*(1:n);
% y=zeros(1,n);
% plot(xx,s,'color',[0.9,0.9,0.9]); 
% hold on %%%%
% plot(xx,y,'color',[0.9,0.9,0.9]); 
% OP54=fill([xx fliplr(xx)],[y fliplr(s)],[0.9,0.9,0.9],'EdgeColor',[0.9,0.9,0.9]);%浅灰色
% plot([0,3],[-1.999,-1.999],'k')
% hold on %%%%%
% OP4=plot(t,X4);
% OP=legend(OP54, {'Attack intervals'});%图例
% set(OP,'FontSize',5);%%% 图例大小
% xlabel('Time(s)')
% ylabel('x_{4}(t)-x_{0}(t)')



f1  
f2
f3
f4
f5
f6
f7
%%
figure;  %%%%%%%%%%%%%%%%%%%%%%%% error-time %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(t,X1)
hold on; plot(t,X2)
hold on; plot(t,X3)
hold on; plot(t,X4)
hold on; plot(t,X5)
hold on; plot(t,X6)
hold on; plot(t,X7)
xlabel('t(s)');  ylabel('z_{i}(t), i=1,2,...,7');
title(['\alpha=', num2str(alpha), ', \delta=', num2str(delta), ', h=', num2str(h), ', W=s*']) % 标注改动的参数

% figure;  %%%%%%%%%%%%%%%%%%%%%%%%%%%% dynamic-memory parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot(t,RT1,'color',[0.1,0.45,0.74],'linewidth',1.05)            % r(t)取值的变化
% hold on; plot(t,RT2,'color',[0.85,0.33,0.1],'linewidth',1.05)            % r(t)取值的变化
% hold on; plot(t,RT3,'color',[0.93,0.69,0.13],'linewidth',1.05)            % r(t)取值的变化
% hold on; plot(t,RT4,'color',[0.49,0.18,0.56],'linewidth',1.05)            % r(t)取值的变化
% hold on; plot(t,RT5,'color',[0.2,0.52,0.34],'linewidth',1.05)            % r(t)取值的变化
% hold on; plot(t,RT6,'color',[0.77,0.12,0.17],'linewidth',1.05)            % r(t)取值的变化
% hold on; plot(t,RT7,'color',[0.03,0.12,0.89],'linewidth',1.05)            % r(t)取值的变化
% axis([0 5 0 3]);
% grid on
% xlabel('t(s)'); ylabel('r_{i}(t), i=1,2,...,7');
% legend('r_{1}(t)','r_{2}(t)','r_{3}(t)','r_{4}(t)','r_{5}(t)','r_{6}(t)','r_{7}(t)','Location','SouthEast')

% figure;   %%%%%%%%%%%%%%%%%%%%%% event-triggered intervals %%%%%%%%%%%%%%%%%%%%%%%%%
% s1=t1(2:length(t1))-t1(1:length(t1)-1);
% s1=[0; s1];
% subplot(7,1,1);
% stem(t1(1:length(t1)),s1(1:length(t1)),'.');
% title('Event-triggered instants and intervals')
% xlim([0 5])
% % xlabel({'t(s)'});
% % ylabel('event intervals');
% 
% s2=t2(2:length(t2))-t2(1:length(t2)-1);
% s2=[0; s2];
% subplot(7,1,2);
% stem(t2(1:length(t2)),s2(1:length(t2)),'.');
% xlim([0 5])
% % xlabel({'t(s)'});
% % ylabel('event intervals');
% 
% s3=t3(2:length(t3))-t3(1:length(t3)-1);
% s3=[0; s3];
% subplot(7,1,3);
% stem(t3(1:length(t3)),s3(1:length(t3)),'.');
% % xlabel({'t(s)'});
% % ylabel('event intervals');
% 
% s4=t4(2:length(t4))-t4(1:length(t4)-1);
% s4=[0; s4];
% subplot(7,1,4);
% stem(t4(1:length(t4)),s4(1:length(t4)),'.');
% % xlabel({'t(s)'});
% % ylabel('event intervals');
% 
% s5=t5(2:length(t5))-t5(1:length(t5)-1);
% s5=[0; s5];
% subplot(7,1,5);
% stem(t5(1:length(t5)),s5(1:length(t5)),'.');
% xlim([0 5])
% % xlabel({'t(s)'});
% % ylabel('event intervals');
% 
% s6=t6(2:length(t6))-t6(1:length(t6)-1);
% s6=[0; s6];
% subplot(7,1,6);
% stem(t6(1:length(t6)),s6(1:length(t6)),'.');
% % xlabel({'t(s)'});
% % ylabel('event intervals');
% 
% s7=t7(2:length(t7))-t7(1:length(t7)-1);
% s7=[0; s7];
% subplot(7,1,7);
% stem(t7(1:length(t7)),s7(1:length(t7)),'.');
% xlabel({'t(s)'});
% % ylabel('event intervals');



