%% get the component of the generalized ohm's law
%%
clear
indir='E:\PIC';
outdir='E:\PIC';
%%
tt=100;
nx=2400;
ny=1200;
di=20;
Lx=nx/di;
Ly=ny/di;
nx=nx/2;
ny=ny/2;
c=0.6;
norm=0.06;
% cut=30.7090;
cut=15;
dirt=0;
xrange=[0 Lx];
% xrange=[-Ly/2,Ly/2];
%%
cd(indir);
it=num2str(tt,'%3.3d');
% ohm=importdata(['ohmy_t',it,'.00.txt']);
ohm=importdata('ohmy_t100.00.mat');

ef=ohm(:,1);
evbi=ohm(:,2);
evbe=ohm(:,3);
dv=ohm(:,4);
dp=ohm(:,5);
%%
ef=reshape(ef,nx,ny);
ef=ef';
evbi=reshape(evbi,nx,ny);
evbi=evbi';
evbe=reshape(evbe,nx,ny);
evbe=evbe';
dv=reshape(dv,nx,ny);
dv=dv';
dp=reshape(dp,nx,ny);
dp=dp';


%{
aa=ef-evbi;
bb=ef-evbe;
cc=evbe+dp+dv;
jxb=-evbi+evbe;
%}
evbe=evbe-evbi;

% %% 高斯滤波
% H = fspecial('gaussian',[3 3],1);
% dv = imfilter(dv,H,'replicate');
% 
% %% 均值滤波
% dv=filter2(fspecial('average',3),dv);
% 
% %% 中值滤波
% dv=medfilt2(dv,[3 3]);


plot_line(ef,Lx,Ly,cut,norm,dirt,'k',1);
hold on
plot_line(evbi,Lx,Ly,cut,norm,dirt,'r');
plot_line(evbe,Lx,Ly,cut,norm,dirt,'b');
plot_line(dv,Lx,Ly,cut,norm,dirt,'g');
plot_line(dp,Lx,Ly,cut,norm,dirt,'y');

% ll=linspace(-Ly/2,Ly/2,ny);
% f=figure;
% plot(ll,ef/norm,'-k'); hold on
% plot(ll,evbi/norm,'-r');
% plot(ll,evbe/norm,'-b');
% plot(ll,dv/norm,'-g');
% plot(ll,dp/norm,'-m'); hold off



xlim(xrange)
legend('Electric field','Frozen-in term','Hall term','Pressure gradient term','Electron inertia term','location','best');
% legend('Electric field','Ion frozen-in term','Electron inertia term','Hall term','Pressure gradient term','location','best');

cd(outdir);
