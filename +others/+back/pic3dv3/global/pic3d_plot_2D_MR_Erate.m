%% plot MR rate by reconnection electric field
clear;
indir='E:\PIC\Cold-Ions\data';
outdir='E:\PIC\Cold-Ions\out';
vA=0.025;
% read data
cd(indir);
re=load('refield2d.dat');
tt=re(:,1);
nr=size(re,2);
xrange=[tt(1),tt(end)];
xrange=[0,50];
for i=2:nr
    f(i)=figure;
    plot(tt,-re(:,i)/vA,'k','LineWidth',2);
    xlim(xrange);
    xlabel('\Omega_{ci}t');
    ylabel('E_r');
    set(gca,'FontSize',14);
    cd(outdir);
    print(f(i), '-dpng','-r300',['MR_rate_RE',num2str(i-1),'.png']);
end
