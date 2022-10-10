%% 
clc                  %清屏
clear all               %清除所有变量，包括全局变量
format long             %将数据显示为长整型科学计数
tic;
N=1;                  %快拍数
doa=[43]/180*pi;     %信号到达角
M=15;                   %阵元数
w=[1*10e8]';
f=w/2/pi;
c=3e8;
lambda=c/f; 
d=lambda/2;             %阵元间距 
tmove=0.05;             %相邻阵元运动时间
v=d/tmove;
T=(M-1)*tmove;          %每段持续时间
P=length(w);            %信号个数
% B=zeros(P,M);           %创建一个P行M列的0矩阵
L=1000;                    %%数据等分为2分
for k=1:L 
    for i=1:M
B(i,k)=exp(1i*w*((i-1)*tmove+(k-1)*T))*exp(1i*w*(v*(k-1)*T+(i-1)*d)*sin(doa)/c);    %矩阵赋值
    end
end 
B=reshape(B,M*L,1);
xx=exp(1i*(w*[1:N]));                  %仿真信号
% xx=1
x=B*xx;  
x_angle=angle(x);
plot(x_angle);
snr=35;                 %信噪比
x=x+awgn(x,snr);                       %加入高斯白噪声
R=x*x';                                 %数据协方差矩阵 
[U,V]=eig(R);                           %求R的特征值和特征向量
UU=U(:,1:L*M-P);                          %估计噪声子空间
theta=-90:0.5:90; 
%%谱峰搜索
lk=1e5;
fai_k=0.982e9/lk:1:1.018e9/lk; 
% for kk=4.9e8/lk:1:5.1e8/lk
for kk=1:length(fai_k)    
for ii=1:length(theta) 
 for tt=1:L
     AA1(tt,1)=exp(1i*(lk*fai_k(kk)*T*(tt-1)+lk*fai_k(kk)*T*(tt-1)*v*sin(theta(ii)/180*pi)/c));
 end
 for jj=1:M
   AA2(jj,1)=exp(1i*(lk*fai_k(kk))*((jj-1)*tmove+(jj-1)*d*sin(theta(ii)/180*pi)/c));
 end 
 AA=kron(AA1,AA2);
WW=AA'*UU*UU'*AA; 
Pmusic(kk,ii)=abs(1/ WW); 
end 
end
[xmax ymax]=find(Pmusic==max(max(Pmusic)));
sita_y=ymax*0.5-90.5;
fai_x=((xmax-1)*lk+0.982e9);
[X,Y]=meshgrid(-90:0.5:90,0.982e9:lk:1.018e9);
figure(1)
meshz(X,Y,Pmusic);
xlabel('DOA/。');
ylabel('Angular frequency w');
zlabel('amplitude')
figure(2)
contour(X,Y,Pmusic);
xlabel('DOA/。');
ylabel('Angular frequency w');
toc;
