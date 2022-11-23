function [IW1,IW2,IW3,IW4,Ki1,Ki2,Ki3]=Numerical_K_W
clear; %%%%%%%%%% 设置每个智能体的增益矩阵相同. %%%%% 用不等式放缩

A =[0 -1 
    1  0];
B =[1  
    0 ];
F=[0.05 0
    0 0.1];
eig(A)
[DIM,dim]=size(B);
N=4; % agent
DA=0.01*[1  1
    0  1  ];
EA=0.1*[ 2  0
     0  1 ];
DB=0.01*[ 2  0
          1  0 ];
EB=0.001*[1
    0 ];

L=[1 -1 0 0
0 1 0 -1
-1 0 1 0
-1 0 0 1 ]; % Laplace
C=[ 1 0 0 0 
    0 1 0 0 
    0 0 0 0 
    0 0 0 0 ]; %
H=L+C;
HI=kron(H,eye(DIM));

m=3;
mu1=0.5;
mu2=0.3;
mu3=0.2;
rho=1;
delta_i=0.1*diag([0.098 0.083 0.081 0.067]);
delta=1.0e-2;    %%%% 触发参数上界
%%%%%%%%% blkdiag :生成以矩阵块为对角线的矩阵. %%%%%%%%%%%
tau_M=0.02;
theta=0.03;
vartheta=sqrt(theta*(1-theta));

%% define scales
setlmis([])
[P,~,sP]=lmivar(1,[DIM 1]); %P1~=inv(P1)
[Q,~,sQ]=lmivar(1,[DIM 1]); %P1~=inv(P1)
[R,~,sR]=lmivar(1,[DIM 1]); %P1~=inv(P1)
[IP,~,sIP]=lmivar(3,[sP zeros(DIM,DIM) zeros(DIM,DIM) zeros(DIM,DIM)
                     zeros(DIM,DIM) sP zeros(DIM,DIM) zeros(DIM,DIM)
                     zeros(DIM,DIM) zeros(DIM,DIM) sP zeros(DIM,DIM)
                     zeros(DIM,DIM) zeros(DIM,DIM) zeros(DIM,DIM) sP]); % N*DIM
[IQ,~,sIQ]=lmivar(3,[sQ zeros(DIM,DIM) zeros(DIM,DIM) zeros(DIM,DIM)
             zeros(DIM,DIM) sQ zeros(DIM,DIM) zeros(DIM,DIM)
             zeros(DIM,DIM) zeros(DIM,DIM) sQ zeros(DIM,DIM)
             zeros(DIM,DIM) zeros(DIM,DIM) zeros(DIM,DIM) sQ]); % N*DIM
[IR,~,sIR]=lmivar(3,[sR zeros(DIM,DIM) zeros(DIM,DIM) zeros(DIM,DIM)
             zeros(DIM,DIM) sR zeros(DIM,DIM) zeros(DIM,DIM)
             zeros(DIM,DIM) zeros(DIM,DIM) sR zeros(DIM,DIM)
             zeros(DIM,DIM) zeros(DIM,DIM) zeros(DIM,DIM) sR]); % N*DIM
[W1,~,sW1]=lmivar(1,[DIM 1]); %W~=P~ W P~
[W2,~,sW2]=lmivar(1,[DIM 1]);
[W3,~,sW3]=lmivar(1,[DIM 1]);
[W4,~,sW4]=lmivar(1,[DIM 1]);
[IW,~,sIW]=lmivar(3,[sW1 zeros(DIM,DIM) zeros(DIM,DIM) zeros(DIM,DIM)
             zeros(DIM,DIM) sW2 zeros(DIM,DIM) zeros(DIM,DIM)
             zeros(DIM,DIM) zeros(DIM,DIM) sW3 zeros(DIM,DIM)
             zeros(DIM,DIM) zeros(DIM,DIM) zeros(DIM,DIM) sW4]); % N*DIM
epsilon_1=lmivar(1,[1,1]);%\epsilon
epsilon_2=lmivar(1,[1,1]);%\epsilon
epsilon_3=lmivar(1,[1,1]);%\epsilon
[K1,~,sK1]=lmivar(2,[dim DIM]);%%%%%%%%%%%%%% 增益矩阵
[IK1,~,sIK1]=lmivar(3,[sK1 zeros(dim,DIM) zeros(dim,DIM) zeros(dim,DIM)
              zeros(dim,DIM) sK1 zeros(dim,DIM) zeros(dim,DIM)
              zeros(dim,DIM) zeros(dim,DIM) sK1 zeros(dim,DIM)
              zeros(dim,DIM) zeros(dim,DIM) zeros(dim,DIM) sK1]); % dim*N DIM*N
[K2,~,sK2]=lmivar(2,[dim DIM]);%%%%%%%%%%%%%% 增益矩阵
[IK2,~,sIK2]=lmivar(3,[sK2 zeros(dim,DIM) zeros(dim,DIM) zeros(dim,DIM)
              zeros(dim,DIM) sK2 zeros(dim,DIM) zeros(dim,DIM)
              zeros(dim,DIM) zeros(dim,DIM) sK2 zeros(dim,DIM)
              zeros(dim,DIM) zeros(dim,DIM) zeros(dim,DIM) sK2]); % dim*N DIM*N
[K3,~,sK3]=lmivar(2,[dim DIM]);%%%%%%%%%%%%%% 增益矩阵
[IK3,~,sIK3]=lmivar(3,[sK3 zeros(dim,DIM) zeros(dim,DIM) zeros(dim,DIM)
              zeros(dim,DIM) sK3 zeros(dim,DIM) zeros(dim,DIM)
              zeros(dim,DIM) zeros(dim,DIM) sK3 zeros(dim,DIM)
              zeros(dim,DIM) zeros(dim,DIM) zeros(dim,DIM) sK3]); % dim*N DIM*N

x1_=lmivar(2,[DIM*N DIM*N]); %M
x2_=lmivar(2,[DIM*N DIM*N]);
x3_=lmivar(2,[DIM*N DIM*N]);
x4_=lmivar(2,[DIM*N DIM*N]);
x5_=lmivar(2,[DIM*N DIM*N]);
x6_=lmivar(2,[DIM*N DIM*N]);
x7_=lmivar(2,[DIM*N DIM*N]);
x8_=lmivar(2,[DIM*N DIM*N]);
x9_=lmivar(2,[DIM*N DIM*N]);
 
y1_=lmivar(2,[DIM*N DIM*N]); %N
y2_=lmivar(2,[DIM*N DIM*N]);
y3_=lmivar(2,[DIM*N DIM*N]);
y4_=lmivar(2,[DIM*N DIM*N]);
y5_=lmivar(2,[DIM*N DIM*N]);
y6_=lmivar(2,[DIM*N DIM*N]);
y7_=lmivar(2,[DIM*N DIM*N]);
y8_=lmivar(2,[DIM*N DIM*N]);
y9_=lmivar(2,[DIM*N DIM*N]);
 
z11_=lmivar(1,[DIM*N 1]);       %Z
z21_=lmivar(2,[DIM*N DIM*N]);
z22_=lmivar(1,[DIM*N 1]);
z31_=lmivar(2,[DIM*N DIM*N]);
z32_=lmivar(2,[DIM*N DIM*N]);
z33_=lmivar(1,[DIM*N 1]);
z41_=lmivar(2,[DIM*N DIM*N]);
z42_=lmivar(2,[DIM*N DIM*N]);
z43_=lmivar(2,[DIM*N DIM*N]);
z44_=lmivar(1,[DIM*N 1]);
z51_=lmivar(2,[DIM*N DIM*N]);
z52_=lmivar(2,[DIM*N DIM*N]);
z53_=lmivar(2,[DIM*N DIM*N]);
z54_=lmivar(2,[DIM*N DIM*N]);
z55_=lmivar(1,[DIM*N 1]);
z61_=lmivar(2,[DIM*N DIM*N]);
z62_=lmivar(2,[DIM*N DIM*N]);
z63_=lmivar(2,[DIM*N DIM*N]);
z64_=lmivar(2,[DIM*N DIM*N]);
z65_=lmivar(2,[DIM*N DIM*N]);
z66_=lmivar(1,[DIM*N 1]);
z71_=lmivar(2,[DIM*N DIM*N]);
z72_=lmivar(2,[DIM*N DIM*N]);
z73_=lmivar(2,[DIM*N DIM*N]);
z74_=lmivar(2,[DIM*N DIM*N]);
z75_=lmivar(2,[DIM*N DIM*N]);
z76_=lmivar(2,[DIM*N DIM*N]);
z77_=lmivar(1,[DIM*N 1]);
z81_=lmivar(2,[DIM*N DIM*N]);
z82_=lmivar(2,[DIM*N DIM*N]);
z83_=lmivar(2,[DIM*N DIM*N]);
z84_=lmivar(2,[DIM*N DIM*N]);
z85_=lmivar(2,[DIM*N DIM*N]);
z86_=lmivar(2,[DIM*N DIM*N]);
z87_=lmivar(2,[DIM*N DIM*N]);
z88_=lmivar(1,[DIM*N 1]);
z91_=lmivar(2,[DIM*N DIM*N]);
z92_=lmivar(2,[DIM*N DIM*N]);
z93_=lmivar(2,[DIM*N DIM*N]);
z94_=lmivar(2,[DIM*N DIM*N]);
z95_=lmivar(2,[DIM*N DIM*N]);
z96_=lmivar(2,[DIM*N DIM*N]);
z97_=lmivar(2,[DIM*N DIM*N]);
z98_=lmivar(2,[DIM*N DIM*N]);
z99_=lmivar(1,[DIM*N 1]);
 
%% first matrx
lmiterm([1 1 1 x1_],1,1,'s'); 
lmiterm([1 1 1 z11_],tau_M,1); 
lmiterm([1 1 1 IP],-1,1);  
lmiterm([1 1 1 IQ],1,1); 
 
lmiterm([1 2 1 x1_'],-1,1); 
lmiterm([1 2 1 x2_],1,1);
lmiterm([1 2 1 y1_'],1,1);
lmiterm([1 2 1 z21_],tau_M,1); 
  
lmiterm([1 2 2 x2_],-1,1,'s');
lmiterm([1 2 2 y2_],1,1,'s');
lmiterm([1 2 2 z22_],tau_M,1); 
 
lmiterm([1 3 1 x3_],1,1);
lmiterm([1 3 1 y1_'],-1,1);
lmiterm([1 3 1 z31_],tau_M,1); 
 
lmiterm([1 3 2 x3_],-1,1);
lmiterm([1 3 2 y2_'],-1,1);
lmiterm([1 3 2 y3_],1,1);
lmiterm([1 3 2 z32_],tau_M,1); 
 
lmiterm([1 3 3 IQ],-1,1);  
lmiterm([1 3 3 y3_],-1,1,'s'); 
lmiterm([1 3 3 z33_],tau_M,1); 
 
lmiterm([1 4 1 x4_],1,1); 
lmiterm([1 4 1 z41_],tau_M,1); 
 
lmiterm([1 4 2 x4_],-1,1);
lmiterm([1 4 2 y4_],1,1);
lmiterm([1 4 2 z42_],tau_M,1); 
 
lmiterm([1 4 3 y4_],-1,1);
lmiterm([1 4 3 z43_],tau_M,1); 
 
lmiterm([1 4 4 IW],-mu1,1); 
lmiterm([1 4 4 z44_],tau_M,1); 
 
lmiterm([1 5 1 x5_],1,1); 
lmiterm([1 5 1 z51_],tau_M,1); 
 
lmiterm([1 5 2 x5_],-1,1);
lmiterm([1 5 2 y5_],1,1);
lmiterm([1 5 2 z52_],tau_M,1); 
 
lmiterm([1 5 3 y5_],-1,1);
lmiterm([1 5 3 z53_],tau_M,1); 
 
lmiterm([1 5 4 z54_],tau_M,1); 
 
lmiterm([1 5 5 IW],-mu2,1); 
lmiterm([1 5 5 z55_],tau_M,1); 
 
 
lmiterm([1 6 1 x6_],1,1); 
lmiterm([1 6 1 z61_],tau_M,1); 
 
lmiterm([1 6 2 x6_],-1,1);
lmiterm([1 6 2 y6_],1,1);
lmiterm([1 6 2 z62_],tau_M,1); 
 
lmiterm([1 6 3 y6_],-1,1);
lmiterm([1 6 3 z63_],tau_M,1); 
 
lmiterm([1 6 4 z64_],tau_M,1); 
 
lmiterm([1 6 5 z65_],tau_M,1); 
 
lmiterm([1 6 6 z66_],tau_M,1); 
lmiterm([1 6 6 IW],-mu3,1); 
 
lmiterm([1 7 1 x7_],1,1); 
lmiterm([1 7 1 z71_],tau_M,1); 

lmiterm([1 7 2 x7_],-1,1);
lmiterm([1 7 2 y7_],1,1);
lmiterm([1 7 2 z72_],tau_M,1); 

lmiterm([1 7 3 y7_],-1,1);
lmiterm([1 7 3 z73_],tau_M,1); 

lmiterm([1 7 4 z74_],tau_M,1); 

lmiterm([1 7 5 z75_],tau_M,1); 

lmiterm([1 7 6 z76_],tau_M,1); 

lmiterm([1 7 7 z77_],tau_M,1); 
lmiterm([1 7 7 IP],-theta,1); 

lmiterm([1 8 1 x8_],1,1); 
lmiterm([1 8 1 z81_],tau_M,1); 

lmiterm([1 8 2 x8_],-1,1);
lmiterm([1 8 2 y8_],1,1);
lmiterm([1 8 2 z82_],tau_M,1); 

lmiterm([1 8 3 y8_],-1,1);
lmiterm([1 8 3 z83_],tau_M,1); 

lmiterm([1 8 4 z84_],tau_M,1); 

lmiterm([1 8 5 z85_],tau_M,1); 

lmiterm([1 8 6 z86_],tau_M,1); 

lmiterm([1 8 7 z87_],tau_M,1); 

lmiterm([1 8 8 z88_],tau_M,1); 
lmiterm([1 8 8 IP],-theta,1); 

lmiterm([1 9 1 x9_],1,1); 
lmiterm([1 9 1 z91_],tau_M,1); 

lmiterm([1 9 2 x9_],-1,1);
lmiterm([1 9 2 y9_],1,1);
lmiterm([1 9 2 z92_],tau_M,1); 

lmiterm([1 9 3 y9_],-1,1);
lmiterm([1 9 3 z93_],tau_M,1); 

lmiterm([1 9 4 z94_],tau_M,1); 

lmiterm([1 9 5 z95_],tau_M,1); 

lmiterm([1 9 6 z96_],tau_M,1); 

lmiterm([1 9 7 z97_],tau_M,1); 

lmiterm([1 9 8 z98_],tau_M,1); 

lmiterm([1 9 9 z99_],tau_M,1); 
lmiterm([1 9 9 IP],-theta,1); 


lmiterm([1 10 1 0],kron(eye(N),A));    
lmiterm([1 10 2 IK1],(1-theta)*kron(H,B),1);  
lmiterm([1 10 2 IK2],(1-theta)*kron(H,B),1); 
lmiterm([1 10 2 IK3],(1-theta)*kron(H,B),1); 
lmiterm([1 10 4 IK1],(1-theta)*kron(H,B),1);  
lmiterm([1 10 5 IK2],(1-theta)*kron(H,B),1); 
lmiterm([1 10 6 IK3],(1-theta)*kron(H,B),1); 
lmiterm([1 10 7 IK1],theta*kron(H,B),1);  
lmiterm([1 10 8 IK2],theta*kron(H,B),1); 
lmiterm([1 10 9 IK3],theta*kron(H,B),1); 

lmiterm([1 10 10 IP],rho^(2),1);  
lmiterm([1 10 10 0],-2*rho*eye(DIM*N)); % the dimension of P: DIM*N
lmiterm([1 10 10 epsilon_1],1,kron(eye(N),DA*DA'));  
lmiterm([1 10 10 epsilon_2],1,kron(H*H',DB*DB')); 
 
 
lmiterm([1 11 2 IK1],(-vartheta)*kron(H,B),1);  
lmiterm([1 11 2 IK2],(-vartheta)*kron(H,B),1); 
lmiterm([1 11 2 IK3],(-vartheta)*kron(H,B),1); 
lmiterm([1 11 4 IK1],(-vartheta)*kron(H,B),1);  
lmiterm([1 11 5 IK2],(-vartheta)*kron(H,B),1); 
lmiterm([1 11 6 IK3],(-vartheta)*kron(H,B),1); 
lmiterm([1 11 7 IK1],vartheta*kron(H,B),1);  
lmiterm([1 11 8 IK2],vartheta*kron(H,B),1); 
lmiterm([1 11 9 IK3],vartheta*kron(H,B),1); 
lmiterm([1 11 11 IP],rho^(2),1);  
lmiterm([1 11 11 0],-2*rho*eye(DIM*N)); % the dimension of P: DIM*N 
lmiterm([1 11 11 epsilon_3],1,kron(H*H',DB*DB')); 

 
lmiterm([1 12 1 0],sqrt(tau_M)*kron(eye(N),A));    
lmiterm([1 12 1 0],-sqrt(tau_M)*eye(N*DIM));    
lmiterm([1 12 2 IK1],sqrt(tau_M)*(1-theta)*kron(H,B),1);  
lmiterm([1 12 2 IK2],sqrt(tau_M)*(1-theta)*kron(H,B),1); 
lmiterm([1 12 2 IK3],sqrt(tau_M)*(1-theta)*kron(H,B),1); 
lmiterm([1 12 4 IK1],sqrt(tau_M)*(1-theta)*kron(H,B),1);  
lmiterm([1 12 5 IK2],sqrt(tau_M)*(1-theta)*kron(H,B),1); 
lmiterm([1 12 6 IK3],sqrt(tau_M)*(1-theta)*kron(H,B),1); 
lmiterm([1 12 7 IK1],sqrt(tau_M)*theta*kron(H,B),1);  
lmiterm([1 12 8 IK2],sqrt(tau_M)*theta*kron(H,B),1); 
lmiterm([1 12 9 IK3],sqrt(tau_M)*theta*kron(H,B),1); 
lmiterm([1 12 10 epsilon_1],1,sqrt(tau_M)*kron(eye(N),DA*DA'));  
lmiterm([1 12 10 epsilon_2],1,sqrt(tau_M)*kron(H*H',DB*DB')); 
% lmiterm([1 12 12 IR],1,1);
lmiterm([1 12 12 IR],rho^(2),1);  
lmiterm([1 12 12 0],-2*rho*eye(DIM*N)); % the dimension of P: DIM*N
lmiterm([1 12 12 epsilon_1],1,tau_M*kron(eye(N),DA*DA'));  
lmiterm([1 12 12 epsilon_2],1,tau_M*kron(H*H',DB*DB')); 
 
 
lmiterm([1 13 2 IK1],sqrt(tau_M)*(-vartheta)*kron(H,B),1);  
lmiterm([1 13 2 IK2],sqrt(tau_M)*(-vartheta)*kron(H,B),1); 
lmiterm([1 13 2 IK3],sqrt(tau_M)*(-vartheta)*kron(H,B),1); 
lmiterm([1 13 4 IK1],sqrt(tau_M)*(-vartheta)*kron(H,B),1);  
lmiterm([1 13 5 IK2],sqrt(tau_M)*(-vartheta)*kron(H,B),1); 
lmiterm([1 13 6 IK3],sqrt(tau_M)*(-vartheta)*kron(H,B),1); 
lmiterm([1 13 7 IK1],sqrt(tau_M)*vartheta*kron(H,B),1);  
lmiterm([1 13 8 IK2],sqrt(tau_M)*vartheta*kron(H,B),1); 
lmiterm([1 13 9 IK3],sqrt(tau_M)*vartheta*kron(H,B),1); 
lmiterm([1 13 11 epsilon_3],1, sqrt(tau_M)*kron(H*H',DB*DB')); 
% lmiterm([1 13 13 IR],1,1);
lmiterm([1 13 13 IR],rho^(2),1);  
lmiterm([1 13 13 0],-2*rho*eye(DIM*N)); % the dimension of P: DIM*N 
lmiterm([1 13 13 epsilon_3],1,tau_M*kron(H*H',DB*DB')); 

lmiterm([1 14 1 0],sqrt(m*theta)*kron(eye(N),F));  
lmiterm([1 14 14 IP],rho^(2),1);  
lmiterm([1 14 14 0],-2*rho*eye(DIM*N));

lmiterm([1 15 2 IW],1,kron(H,eye(DIM)));
lmiterm([1 15 4 IW],1/m,kron(H,eye(DIM)));
lmiterm([1 15 5 IW],1/m,kron(H,eye(DIM)));
lmiterm([1 15 6 IW],1/m,kron(H,eye(DIM)));
lmiterm([1 15 15 IW],-1/delta,1);  


%%% uncertain %%%
lmiterm([1 16 1 0],kron(eye(N),EA));
lmiterm([1 16 16 epsilon_1],-1,eye(DIM*N));
  
lmiterm([1 17 2 IK1],(1-theta)*kron(eye(N),EB),1);  
lmiterm([1 17 2 IK2],(1-theta)*kron(eye(N),EB),1);  
lmiterm([1 17 2 IK3],(1-theta)*kron(eye(N),EB),1);  
lmiterm([1 17 4 IK1],(1-theta)*kron(eye(N),EB),1);  
lmiterm([1 17 5 IK2],(1-theta)*kron(eye(N),EB),1);  
lmiterm([1 17 6 IK3],(1-theta)*kron(eye(N),EB),1);  
lmiterm([1 17 7 IK1],theta*kron(eye(N),EB),1);  
lmiterm([1 17 8 IK2],theta*kron(eye(N),EB),1); 
lmiterm([1 17 9 IK3],theta*kron(eye(N),EB),1); 
lmiterm([1 17 17 epsilon_2],-1,eye(DIM*N));
 
lmiterm([1 18 2 IK1],(-vartheta)*kron(eye(N),EB),1);  
lmiterm([1 18 2 IK2],(-vartheta)*kron(eye(N),EB),1);  
lmiterm([1 18 2 IK3],(-vartheta)*kron(eye(N),EB),1);  
lmiterm([1 18 4 IK1],(-vartheta)*kron(eye(N),EB),1);  
lmiterm([1 18 5 IK2],(-vartheta)*kron(eye(N),EB),1);  
lmiterm([1 18 6 IK3],(-vartheta)*kron(eye(N),EB),1);  
lmiterm([1 18 7 IK1],vartheta*kron(eye(N),EB),1);  
lmiterm([1 18 8 IK2],vartheta*kron(eye(N),EB),1); 
lmiterm([1 18 9 IK3],vartheta*kron(eye(N),EB),1); 
lmiterm([1 18 18 epsilon_3],-1,eye(DIM*N));

%% sceond matrx %%%
lmiterm([-2 1 1 z11_],1,1);
lmiterm([-2 2 1 z21_],1,1);
lmiterm([-2 2 2 z22_],1,1); 
lmiterm([-2 3 1 z31_],1,1);
lmiterm([-2 3 2 z32_],1,1); 
lmiterm([-2 3 3 z33_],1,1); 
lmiterm([-2 4 1 z41_],1,1); 
lmiterm([-2 4 2 z42_],1,1); 
lmiterm([-2 4 3 z43_],1,1); 
lmiterm([-2 4 4 z44_],1,1); 
lmiterm([-2 5 1 z51_],1,1); 
lmiterm([-2 5 2 z52_],1,1); 
lmiterm([-2 5 3 z53_],1,1); 
lmiterm([-2 5 4 z54_],1,1); 
lmiterm([-2 5 5 z55_],1,1); 
lmiterm([-2 6 1 z61_],1,1); 
lmiterm([-2 6 2 z62_],1,1); 
lmiterm([-2 6 3 z63_],1,1); 
lmiterm([-2 6 4 z64_],1,1); 
lmiterm([-2 6 5 z65_],1,1); 
lmiterm([-2 6 6 z66_],1,1); 
lmiterm([-2 7 1 z71_],1,1); 
lmiterm([-2 7 2 z72_],1,1); 
lmiterm([-2 7 3 z73_],1,1); 
lmiterm([-2 7 4 z74_],1,1); 
lmiterm([-2 7 5 z75_],1,1); 
lmiterm([-2 7 6 z76_],1,1); 
lmiterm([-2 7 7 z77_],1,1); 
lmiterm([-2 8 1 z81_],1,1); 
lmiterm([-2 8 2 z82_],1,1); 
lmiterm([-2 8 3 z83_],1,1); 
lmiterm([-2 8 4 z84_],1,1); 
lmiterm([-2 8 5 z85_],1,1); 
lmiterm([-2 8 6 z86_],1,1); 
lmiterm([-2 8 7 z87_],1,1); 
lmiterm([-2 8 8 z88_],1,1); 
lmiterm([-2 9 1 z91_],1,1); 
lmiterm([-2 9 2 z92_],1,1); 
lmiterm([-2 9 3 z93_],1,1); 
lmiterm([-2 9 4 z94_],1,1); 
lmiterm([-2 9 5 z95_],1,1); 
lmiterm([-2 9 6 z96_],1,1); 
lmiterm([-2 9 7 z97_],1,1); 
lmiterm([-2 9 8 z98_],1,1); 
lmiterm([-2 9 9 z99_],1,1);

lmiterm([-2 10 1 x1_'],1,1); 
lmiterm([-2 10 2 x2_'],1,1); 
lmiterm([-2 10 3 x3_'],1,1); 
lmiterm([-2 10 4 x4_'],1,1); 
lmiterm([-2 10 5 x5_'],1,1); 
lmiterm([-2 10 6 x6_'],1,1); 
lmiterm([-2 10 7 x7_'],1,1); 
lmiterm([-2 10 8 x8_'],1,1); 
lmiterm([-2 10 9 x9_'],1,1); 
lmiterm([-2 10 10 IR],-rho^(2),1); 
lmiterm([-2 10 10 0],2*rho); 

%% third matrx %%%
lmiterm([-3 1 1 z11_],1,1);
lmiterm([-3 2 1 z21_],1,1);
lmiterm([-3 2 2 z22_],1,1);
lmiterm([-3 3 1 z31_],1,1);
lmiterm([-3 3 2 z32_],1,1);
lmiterm([-3 3 3 z33_],1,1);
lmiterm([-3 4 1 z41_],1,1);
lmiterm([-3 4 2 z42_],1,1);
lmiterm([-3 4 3 z43_],1,1);
lmiterm([-3 4 4 z44_],1,1);
lmiterm([-3 5 1 z51_],1,1);
lmiterm([-3 5 2 z52_],1,1);
lmiterm([-3 5 3 z53_],1,1);
lmiterm([-3 5 4 z54_],1,1);
lmiterm([-3 5 5 z55_],1,1);
lmiterm([-3 6 1 z61_],1,1);
lmiterm([-3 6 2 z62_],1,1);
lmiterm([-3 6 3 z63_],1,1);
lmiterm([-3 6 4 z64_],1,1);
lmiterm([-3 6 5 z65_],1,1);
lmiterm([-3 6 6 z66_],1,1);
lmiterm([-3 7 1 z71_],1,1); 
lmiterm([-3 7 2 z72_],1,1); 
lmiterm([-3 7 3 z73_],1,1); 
lmiterm([-3 7 4 z74_],1,1); 
lmiterm([-3 7 5 z75_],1,1); 
lmiterm([-3 7 6 z76_],1,1); 
lmiterm([-3 7 7 z77_],1,1); 
lmiterm([-3 8 1 z81_],1,1); 
lmiterm([-3 8 2 z82_],1,1); 
lmiterm([-3 8 3 z83_],1,1); 
lmiterm([-3 8 4 z84_],1,1); 
lmiterm([-3 8 5 z85_],1,1); 
lmiterm([-3 8 6 z86_],1,1); 
lmiterm([-3 8 7 z87_],1,1); 
lmiterm([-3 8 8 z88_],1,1); 
lmiterm([-3 9 1 z91_],1,1); 
lmiterm([-3 9 2 z92_],1,1); 
lmiterm([-3 9 3 z93_],1,1); 
lmiterm([-3 9 4 z94_],1,1); 
lmiterm([-3 9 5 z95_],1,1); 
lmiterm([-3 9 6 z96_],1,1); 
lmiterm([-3 9 7 z97_],1,1); 
lmiterm([-3 9 8 z98_],1,1); 
lmiterm([-3 9 9 z99_],1,1);

lmiterm([-3 10 1 y1_'],1,1); 
lmiterm([-3 10 2 y2_'],1,1); 
lmiterm([-3 10 3 y3_'],1,1); 
lmiterm([-3 10 4 y4_'],1,1); 
lmiterm([-3 10 5 y5_'],1,1); 
lmiterm([-3 10 6 y6_'],1,1); 
lmiterm([-3 10 7 y7_'],1,1);
lmiterm([-3 10 8 y8_'],1,1);
lmiterm([-3 10 9 y9_'],1,1); 
lmiterm([-3 10 10 IR],-rho^(2),1); 
lmiterm([-3 10 10 0],2*rho); 

%% others
lmiterm([-4 1 1 IP],1,1); 
lmiterm([-5 1 1 IQ],1,1); 
lmiterm([-6 1 1 IR],1,1); 
lmiterm([-7 1 1 IW],1,1);
lmiterm([-8 1 1 epsilon_1],1,1); 
lmiterm([-9 1 1 epsilon_2],1,1); 
lmiterm([-10 1 1 epsilon_3],1,1); 
  
%% solve
G=getlmis;
[tmin,b]=feasp(G);
 
 IP=dec2mat(G,b,IP);
 IQ=dec2mat(G,b,IQ);
 IR=dec2mat(G,b,IR);
 IW=dec2mat(G,b,IW);
 IK1=dec2mat(G,b,IK1);
 IK2=dec2mat(G,b,IK2); %% 有随tau的增大而增大的趋势
 IK3=dec2mat(G,b,IK3);
 IP;
 IQ;
 IR;
 IW;
 IK1;
 IK2;
 IK3; 
% 
format long
IW1=IW([1;2],[1:2]);
IW2=IW([3:4],[3:4]);
IW3=IW([5;6],[5:6]);
IW4=IW([7;8],[7:8]);
 Ki1=IK1(1,[1:2]);
 Ki2=IK2(1,[1:2]);
 Ki3=IK3(1,[1:2]);
% 

n=10;

%%

save('E:\variable.mat')






