%% the electric field
clear;
%%
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article\Paper5';
prm = slj.Parameters(indir, outdir);

%% time
tt1= 30;
tt2= 40;
tt3= 50;

%% figure
f=figure('Position',[600,100,1000,400]);
ha=slj.Plot.subplot(1,2,[0.2,0.1],[0.18,0.05],[0.1,0.05]);
fs = 12;

%% panel a
axes(ha(1));

%% read data
xz = 25;
dir = 1;
norm = prm.value.vA;
ll = prm.value.lz;

E1 = prm.read('E', tt1);
le1=E1.get_line2d(xz,dir,prm,norm);
le1 = smooth1d(le1.lz);


E2 = prm.read('E', tt2);
le2=E2.get_line2d(xz,dir,prm,norm);
le2 = smooth1d(le2.lz);

E3 = prm.read('E', tt3);
le3=E3.get_line2d(xz,dir,prm,norm);
le3 = smooth1d(le3.lz);

plot(ll, le1, '-r', 'LineWidth', 2);
hold on
plot(ll, le2, '-k', 'LineWidth', 2);
plot(ll, le3, '-b', 'LineWidth', 2);
xlabel('Z [c/\omega_{pi}]');
ylabel('Ez');
xlim([-2, 2]);
legend(['t = ', num2str(tt1)], ['t = ', num2str(tt2)], ['t = ', num2str(tt3)]);
set(gca, 'FontSize', fs);

%% panel b
axes(ha(2));
cd(outdir);
iez = load('integral_of_Ez.mat');

plot(iez.tt, iez.rate, '-k', 'LineWidth', 2);
xlabel('\Omega_{ci}t');
ylabel('q\int_{-1}^{4} Ez dz');
xlim([4, 60]);
set(gca, 'FontSize', fs);

%%
annotation(f,'textbox',...
    [0.0460000000000001 0.854000001862645 0.0514999987632036 0.0874999981373549],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.51 0.854000001862645 0.0524999987334013 0.0874999981373549],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');

%% save
cd(outdir);
% print('-dpng', '-r300', 'figure10.png');


function sfd=smooth1d(lfd)
n=1;
nt=length(lfd);
sfd=lfd;
for i=1:n
    for j=2:nt-1
        sfd(j)=sfd(j-1)*0.25+sfd(j)*0.5+sfd(j+1)*0.25;
    end
end
end