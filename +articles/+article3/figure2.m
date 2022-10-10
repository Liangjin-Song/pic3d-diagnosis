% function figure2()
%% plot the Ez, Ey, Nic
% writen by Liangjin Song on 20210626
%%
clear;
run('articles.article4.parameters.m');

%% the time
tt=30;
tt0=30;

z0=prm.value.nz/2;
dz=80;
norm=prm.value.n0*prm.value.vA*prm.value.vA;
anorm=prm.value.vA*prm.value.vA;

%% set the figure
f=figure('Position',[500,10,600,800]);
ha=slj.Plot.subplot(2,1,[0.0001,0.1],[0.13,0.07],[0.13,0.05]);

xz=0;
dir=0;
xz2=48;
dir2=1;
dh=0.055;
daxs=0.025;
extra.xrange=[30,70];
extra.yrange=[-10,10];
extra.FontSize=12;

%% plot the overview of the Jic dot E
% read data
name='h';
JE=calc_J_dot_E(prm,name,tt);
ss=prm.read('stream',tt);
% figure;
axes(ha(1));
extra.ylabel='Z [c/\omega_{pi}]';
extra.ColorbarPosition='North';
extra.caxis=[-0.5,0.5];
hbar=slj.Plot.overview(JE, ss, prm.value.lx, prm.value.lz, norm, extra);
hold on
plot([0,100],[0,0],'--r','LineWidth',1.5);
pos=get(ha(1),'Position');
pos(2)=pos(2)-daxs;
set(ha(1),'Position',pos);

pos=get(hbar,'Position');
pos(2)=pos(2)+dh;
set(hbar,'Position',pos);
set(hbar,'AxisLocation','out');
set(gca,'XTicklabel',[]);

%% Jic dot E, line
%%
l1=JE.value(z0-dz:z0+dz, :);
l1=mean(l1,1)/norm;

%% figure
ll=prm.value.lx;
lw=2;
axes(ha(2));
p0=plot(ll,l1,'-r','LineWidth',lw); hold on
plot([0,100],[0,0],'--b','LineWidth',1.5);
xlim(extra.xrange);
xlabel('X [c/\omega_{pi}]');
ylabel('J_{ic}\cdot E');
set(gca,'FontSize',extra.FontSize);


%% text box
annotation(f,'textbox',...
    [0.0683333333333334 0.875250001005828 0.0941666643569867 0.0462499989941716],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(f,'textbox',...
    [0.128333333333334 0.485250001005828 0.0958333309739829 0.0462499989941716],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');


%%
cd(outdir);
print(f,'-dpng','-r300','figure2.png');
% print(f,'-depsc','-painters','figure2.eps');
print(f,'-depsc','figure2.eps');


function JE=calc_J_dot_E(prm,name,tt)
N=prm.read(['N',name],tt);
V=prm.read(['V',name],tt);
E=prm.read('E',tt);
JE=V.dot(E);
JE=JE*N;
JE=JE.filter2d(3);
end

function JE=calc_aver_J_dot_E(prm,name,tt)
N=prm.read(['N',name],tt);
V=prm.read(['V',name],tt);
E=prm.read('E',tt);
JE=V.dot(E);
JE=JE.filter2d(5);
end