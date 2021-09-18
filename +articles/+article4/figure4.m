% function figure3_2()
%% plot the Ez, Ey, Nic
% writen by Liangjin Song on 20210626
%%
clear;
run('articles.article4.parameters.m');

%% the time
tt=30;
norm=prm.value.n0*prm.value.vA*prm.value.vA;

%% set the figure
f=figure('Position',[500,10,600,800]);
ha=slj.Plot.subplot(2,1,[0.0001,0.05],[0.085,0.07],[0.15,0.05]);

xz=0;
dir=0;
extra.xrange=[30,70];
extra.yrange=[-10,10];
extra.FontSize=14;

%% plot the overview of the Jic dot E
% read data
Nic=prm.read('Nh',tt);
Vic=prm.read('Vh',tt);
E=prm.read('E',tt);
ss=prm.read('stream',tt);
JE=Vic.dot(E);
JE=JE*Nic;

% figure;
axes(ha(1));
dh=0.05;
daxs=0.1;
extra.ylabel='Z [c/\omega_{pi}]';
extra.ColorbarPosition='North';
extra.caxis=[-1.5,1.5];
hbar=slj.Plot.overview(JE, ss, prm.value.lx, prm.value.lz, norm, extra);
hold on
% plot([50,50],[-5,5],'--r','LineWidth',1.5);
% set the colorbar
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
name='h';
JE=calc_J_dot_E(prm,name,tt);
l1=JE.get_line2d(xz, dir, prm, norm);
%%
name='l';
JE=calc_J_dot_E(prm,name,tt);
l2=JE.get_line2d(xz, dir, prm, norm);
%%
name='e';
JE=calc_J_dot_E(prm,name,tt);
l3=JE.get_line2d(xz, dir, prm, norm);


%% figure
ll=prm.value.lx;
lw=2;
axes(ha(2));
plot(ll,l1,'-r','LineWidth',lw); hold on
plot(ll,l2,'-g','LineWidth',lw);
plot(ll,l3,'-b','LineWidth',lw); hold off
xlim(extra.xrange);
xlabel('X [c/\omega_{pi}]');

set(gca,'FontSize',extra.FontSize);

function JE=calc_J_dot_E(prm,name,tt)
N=prm.read(['N',name],tt);
V=prm.read(['V',name],tt);
E=prm.read('E',tt);
JE=V.dot(E);
JE=JE*N;
JE=JE.filter2d(3);
end