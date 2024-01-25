%% plot the magnetic reconnection rate
% writen by Liangjin Song on 20200909
%%
clear;
indir='Z:\Simulation\sym\rec1d';
outdir='E:\';
prm=slj.Parameters(indir,outdir);

% wci=0.000312;
% di=40;
% c=0.5;
% vA=di*wci;
norm=prm.value.vA*0.1/prm.value.wci;

%% read data
cd(indir);
rate=load('flux2d.dat');
tt=rate(:,1);
mrate=diff(rate)/norm;

nf=size(mrate,2);
f=zeros(1,nf);

xrange=[tt(1),tt(end)];
% xrange=[0,50];
%% plot figure
for i=2:nf
    f(i)=figure;
    plot(tt(1:end-1),mrate(:,i),'k','LineWidth',2);
    xlim(xrange);
    xlabel('\Omega_{ci}t');
    ylabel('E_r');
    set(gca,'FontSize',14);
    cd(outdir);
    print(f(i), '-dpng','-r300',['MR_rate',num2str(i-1),'.png']);
end

