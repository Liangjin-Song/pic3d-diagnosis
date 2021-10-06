% function figure3_2()
%% plot the Ez, Ey, Nic
% writen by Liangjin Song on 20210626
%%
clear;
run('articles.article4.parameters.m');

%% the time
tt=30;
tt0=16;
tt2=25;
tt3=40;

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
extra.caxis=[-0.1,0.1];
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

JE=calc_J_dot_E(prm,name,tt0);
l0=JE.value(z0-dz:z0+dz, :);
l0=mean(l0,1)/norm;

JE=calc_J_dot_E(prm,name,tt2);
l2=JE.value(z0-dz:z0+dz, :);
l2=mean(l2,1)/norm;

JE=calc_J_dot_E(prm,name,tt3);
JE=prm.read('J',25);
JE=slj.Scalar(JE.y);
l3=JE.value(z0-dz:z0+dz, :);
l3=mean(l3,1)/prm.value.n0;


%% figure
ll=prm.value.lx;
lw=2;
axes(ha(2));
p0=plot(ll,l0,'-r','LineWidth',lw); hold on
p1=plot(ll,l1,'-b','LineWidth',lw);
% p3=plot(ll,l3,'-m','LineWidth',lw);
plot([0,100],[0,0],'--g','LineWidth',1.5);
xlim(extra.xrange);
legend([p0;p1],['\Omega_{ci}t=',num2str(tt0)],['\Omega_{ci}t=',num2str(tt2)]);
xlabel('X [c/\omega_{pi}]');
ylabel('J_{ic}\cdot E');
set(gca,'FontSize',extra.FontSize);






%% plot the overview of the average Jic dot E
% read data
% name='h';
% JE=calc_aver_J_dot_E(prm,name,tt);
% % figure;
% axes(ha(2));
% extra.ylabel='Z [c/\omega_{pi}]';
% extra.ColorbarPosition='North';
% extra.caxis=[-0.5,0.5];
% hbar=slj.Plot.overview(JE, ss, prm.value.lx, prm.value.lz, anorm, extra);
% hold on
% plot([0,100],[0,0],'--r','LineWidth',1.5);
% pos=get(ha(2),'Position');
% pos(2)=pos(2)-daxs;
% set(ha(2),'Position',pos);
% 
% pos=get(hbar,'Position');
% pos(2)=pos(2)+dh;
% set(hbar,'Position',pos);
% set(hbar,'AxisLocation','out');
% set(gca,'XTicklabel',[]);
% 
% %% Jic dot E, line
% %%
% l1=JE.value(z0-dz:z0+dz, :);
% l1=mean(l1,1)/anorm;
% 
% %% figure
% ll=prm.value.lx;
% lw=2;
% axes(ha(4));
% plot(ll,l1,'-r','LineWidth',lw);
% xlim(extra.xrange);
% xlabel('X [c/\omega_{pi}]');
% ylabel('J_{ic}\cdot E/ N_{ic}');
% set(gca,'FontSize',extra.FontSize);


%%
cd(outdir);
print('-dpng','-r300','figure2.png');


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