%% plot the MR rate
%% input the parameters
indir='E:\PIC\test2';
outdir='E:\PIC\test2';

dt=0.1;                     %·Ö±æÂÊ
norm=0.6*20;                    %norm=B0*di
norm2=0.6*0.06*dt/0.003;   %norm2= B0*Va*dt/wci

cd(indir);
xpoint=load('xpoint.dat');

[tt,lflux,lEr,uflus,uEr]=MR_rate(xpoint,norm,norm2,[0,15]);
% yrange=[0,0.3];

% H=figure(1);
% set(H,AX(1),'YLim',yrange);


cd(outdir);
% print(1,'-r300','-dpng','MR_rate1.png');
% print(2,'-r300','-dpng','MR_rate2.png');
% close(gcf);
% close(gcf);
% clear xpoint
