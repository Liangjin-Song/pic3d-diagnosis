%% plot the MR rate
%% input the parameters
outdir='/data/simulation/rec2d_M100SBg00Sx/out/MR_Rate/';
dirr='/data/simulation/rec2d_M100SBg00Sx/data/';

dt=0.01;                     %·Ö±æÂÊ
norm=0.6*40;                    %norm=B0*di
norm2=0.6*0.03*dt/0.00075;   %norm2= B0*Va*dt/wci

cd(dirr);
xpoint=load('xpoint.dat');
% [ax,h1,h2]=
MR_rate(xpoint,norm,norm2);
% yrange=[0,0.3];

% H=figure(1);
% set(H,AX(1),'YLim',yrange);


% cd(outdir);
% print(1,'-r300','-dpng','MR_rate1.png');
% print(2,'-r300','-dpng','MR_rate2.png');
% close(gcf);
% close(gcf);
% clear xpoint
