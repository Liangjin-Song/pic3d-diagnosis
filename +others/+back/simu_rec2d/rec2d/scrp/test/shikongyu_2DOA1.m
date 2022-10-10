%% 
clc                  %����
clear all               %������б���������ȫ�ֱ���
format long             %��������ʾΪ�����Ϳ�ѧ����
tic;
N=1;                  %������
doa=[43]/180*pi;     %�źŵ����
M=15;                   %��Ԫ��
w=[1*10e8]';
f=w/2/pi;
c=3e8;
lambda=c/f; 
d=lambda/2;             %��Ԫ��� 
tmove=0.05;             %������Ԫ�˶�ʱ��
v=d/tmove;
T=(M-1)*tmove;          %ÿ�γ���ʱ��
P=length(w);            %�źŸ���
% B=zeros(P,M);           %����һ��P��M�е�0����
L=1000;                    %%���ݵȷ�Ϊ2��
for k=1:L 
    for i=1:M
B(i,k)=exp(1i*w*((i-1)*tmove+(k-1)*T))*exp(1i*w*(v*(k-1)*T+(i-1)*d)*sin(doa)/c);    %����ֵ
    end
end 
B=reshape(B,M*L,1);
xx=exp(1i*(w*[1:N]));                  %�����ź�
% xx=1
x=B*xx;  
x_angle=angle(x);
plot(x_angle);
snr=35;                 %�����
x=x+awgn(x,snr);                       %�����˹������
R=x*x';                                 %����Э������� 
[U,V]=eig(R);                           %��R������ֵ����������
UU=U(:,1:L*M-P);                          %���������ӿռ�
theta=-90:0.5:90; 
%%�׷�����
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
xlabel('DOA/��');
ylabel('Angular frequency w');
zlabel('amplitude')
figure(2)
contour(X,Y,Pmusic);
xlabel('DOA/��');
ylabel('Angular frequency w');
toc;
