indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Poster';

tt1=0;
tt2=15;
tt3=25;
tt4=45;
tt5=50;

c=0.5;
vA=0.0125;
cva=c/vA;
cva=cva*cva;

%% read data
cd(indir);
sm1=reset_spectrum(pic3d_read_data('spctrmh',tt1),cva);
sm2=reset_spectrum(pic3d_read_data('spctrmh',tt2),cva);
sm3=reset_spectrum(pic3d_read_data('spctrmh',tt3),cva);
sm4=reset_spectrum(pic3d_read_data('spctrmh',tt4),cva);
sm5=reset_spectrum(pic3d_read_data('spctrmh',tt5),cva);
xx=-4:0.1:4;
figure;
plot(xx, log10(sm1),'-k','LineWidth',2); hold on
plot(xx,log10(sm2),'-r','LineWidth',2);
plot(xx,log10(sm3),'-g','LineWidth',2);
plot(xx,log10(sm4),'-b','LineWidth',2);
plot(xx,log10(sm5),'-m','LineWidth',2); hold off
legend({['\Omega_{ci} t=',num2str(tt1)],['\Omega_{ci} t=',num2str(tt2)],['\Omega_{ci} t=',num2str(tt3)],['\Omega_{ci} t=',num2str(tt4)],['\Omega_{ci} t=',num2str(tt5)]});
xlim([-4,4]);
ylim([0,10]);
yticks(0:1:10);
yticklabels({'0','10^{1}','10^{2}','10^{3}','10^{4}','10^{5}','10^{6}','10^{7}','10^{8}','10^{9}','10^{10}'});
xlabel('E_{ic} [mv_{A}^2]');
ylabel('f_{ic}');
xticks(-4:1:4);
xticklabels({'10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}','10^{3}','10^{4}'});
% title(['\Omega_{ci} t=',num2str(tt)]);
set(gca,'FontSize',14);
cd(outdir);
print('-dpng','-r300','spctrh.png');

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