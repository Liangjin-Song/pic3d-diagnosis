% function figure3_2()
%% plot the Ez, Ey, Nic
% writen by Liangjin Song on 20210626
%%
clear;
run('articles.article4.parameters.m');

%% the time
tt=16;

%% set the figure
figure1=figure('Position',[500,200,1000,400]);
ha=slj.Plot.subplot(1,2,[0.004,0.05],[0.085,0.07],[0.12,0.01]);
dh=0.11;
shh=0.157;
rth=0.62;
rtw=0.2;
xz=50;
dir=1;
extra.xrange=[40,60];
extra.yrange=[-5,5];
%% for Nic
ss=prm.read('stream',tt);
Nic=prm.read('Nh',tt);
Ne=prm.read('Ne',tt);
Nhe=prm.read('Nhe',tt);
Ni=prm.read('Nl',tt);
axes(ha(1));
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.ColorbarPosition='North';
hbar=slj.Plot.overview(Nic, ss, prm.value.lx, prm.value.lz, prm.value.n0, extra);
hold on
plot([50,50],[-5,5],'--r','LineWidth',1.5);
% set the colorbar
pos=get(hbar,'Position');
pos(2)=pos(2)+dh;
set(hbar,'Position',pos);
set(hbar,'AxisLocation','out');
hbar.Label.String='Nic';


%% the line for Nic
axes(ha(2));
ln=Nic.get_line2d(xz, dir, prm, prm.value.n0);
le=Ne.get_line2d(xz, dir, prm, prm.value.n0);
lhe=Nhe.get_line2d(xz, dir, prm, prm.value.n0);
li=Ni.get_line2d(xz, dir, prm, prm.value.n0);
le=le+lhe;
ll=prm.value.lz;
extra.linerange=[-1,1];
ln=slj.Physics.filter1d(ln,5);
plot(ln,ll,'-k','LineWidth',2); hold on
plot(le,ll,'-r','LineWidth',2);
plot(li,ll,'-b','LineWidth',2); hold off
legend('N_{ic}','N_e','N_{ih}','Position',[0.58166666500167 0.0109518342154768 0.0739999993145465 0.222499993741512]);
% set(gca,'Yticklabel',[]);
set(gca,'xaxislocation','top')
ylim(extra.linerange);
% set the figure
pos=get(ha(2),'Position');
pos(2)=pos(2)+shh;
pos(4)=pos(4)*rth;
pos(3)=pos(3)*rtw;
set(ha(2),'Position',pos);
set(gca,'FontSize',extra.FontSize);

%% text box
annotation(figure1,'textbox',...
    [0.087 0.809000002011656 0.056499998614192 0.0924999979883433],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(figure1,'textbox',...
    [0.534 0.804000002011655 0.0574999985843897 0.0924999979883433],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

%% save the figure
cd(outdir);
print(figure1,'-dpng','-r300','figure7.png');
print(figure1,'-depsc','figure7.eps');


%{
%% set the figure
f=figure('Position',[1000,10,600,800]);
ha=slj.Plot.subplot(3,2,[0.005,0.085],[0.085,0.07],[0.12,0.07]);

%% for E field
E=prm.read('E',tt);
ss=prm.read('stream',tt);
%% the line
xz=50;
dir=1;
lf=E.get_line2d(xz, dir, prm, prm.value.vA);
ll=prm.value.lz;
%% the figure property
dh=0.03;
extra.ylabel='Z [c/\omega_{pi}]';
extra.xrange=[40,60];
extra.yrange=[-5,5];
extra.linerange=[-1,1];
%% for Ez
axes(ha(1));
extra.caxis=[-1,1];
extra.ColorbarPosition='north';
hbar=slj.Plot.overview(E.z, ss, prm.value.lx, prm.value.lz, prm.value.vA, extra);
% set the colorbar
pos=get(hbar,'Position');
pos(2)=pos(2)+dh;
set(hbar,'Position',pos);
set(hbar,'AxisLocation','out');
hbar.Label.String='Ez';
extra=rmfield(extra,'caxis');

%% the line for Ez
axes(ha(2));
lz=slj.Physics.filter1d(lf.lz,5);
% lz=lf.lz;
plot(lz,ll,'-k','LineWidth',2);
% set(gca,'Yticklabel',[]);
set(gca,'xaxislocation','top')
set(gca,'XTick',[-0.5,0,0.5]);
ylim(extra.linerange);
% set the figure
shh=0.035;
rth=0.685;
rtw=0.3;
pos=get(ha(2),'Position');
pos(2)=pos(2)+shh;
pos(4)=pos(4)*rth;
pos(3)=pos(3)*rtw;
set(ha(2),'Position',pos);
set(gca,'FontSize',extra.FontSize);


%% for Ey
axes(ha(3));
extra.ColorbarPosition='north';
hbar=slj.Plot.overview(E.y, ss, prm.value.lx, prm.value.lz, prm.value.vA, extra);
% set the colorbar
pos=get(hbar,'Position');
pos(2)=pos(2)+dh;
set(hbar,'Position',pos);
set(hbar,'AxisLocation','out');
hbar.Label.String='Ey';

%% the line for Ey
axes(ha(4));
ly=slj.Physics.filter1d(lf.ly,5);
% ly=lf.ly;
plot(ly,ll,'-k','LineWidth',2);
% set(gca,'Yticklabel',[]);
set(gca,'xaxislocation','top')
% set(gca,'XTick',[-0.5,0,0.5]);
ylim(extra.yrange);
% set the figure
pos=get(ha(4),'Position');
pos(2)=pos(2)+shh;
pos(4)=pos(4)*rth;
pos(3)=pos(3)*rtw;
set(ha(4),'Position',pos);
set(gca,'FontSize',extra.FontSize);


%% for Nic
Nic=prm.read('Nh',tt);
Ne=prm.read('Ne',tt);
Nhe=prm.read('Nhe',tt);
Ni=prm.read('Nl',tt);
axes(ha(5));
extra.xlabel='X [c/\omega_{pi}]';
% extra=rmfield(extra,'caxis');
extra.ColorbarPosition='north';
hbar=slj.Plot.overview(Nic, ss, prm.value.lx, prm.value.lz, prm.value.n0, extra);
% set the colorbar
pos=get(hbar,'Position');
pos(2)=pos(2)+dh;
set(hbar,'Position',pos);
set(hbar,'AxisLocation','out');
hbar.Label.String='Nic';


%% the line for Nic
axes(ha(6));
ln=Nic.get_line2d(xz, dir, prm, prm.value.n0);
le=Ne.get_line2d(xz, dir, prm, prm.value.n0);
lhe=Nhe.get_line2d(xz, dir, prm, prm.value.n0);
li=Ni.get_line2d(xz, dir, prm, prm.value.n0);
le=le+lhe;
extra.linerange=[-1,1];
ln=slj.Physics.filter1d(ln,5);
plot(ln,ll,'-k','LineWidth',2); hold on
plot(le,ll,'-r','LineWidth',2);
plot(li,ll,'-b','LineWidth',2); hold off
legend('N_{ic}','N_e','N_i','Position',[0.566111109148264 0.00926459068209344 0.123333332190911 0.102499997131526]);
% set(gca,'Yticklabel',[]);
set(gca,'xaxislocation','top')
ylim(extra.linerange);
% set the figure
pos=get(ha(6),'Position');
pos(2)=pos(2)+shh;
pos(4)=pos(4)*rth;
pos(3)=pos(3)*rtw;
set(ha(6),'Position',pos);
set(gca,'FontSize',extra.FontSize);

%% save the figure
cd(outdir);
print('-dpng','-r300','figure1.png');
%}

