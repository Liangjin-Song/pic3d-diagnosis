%% the distribution function as the time of z
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article\Paper5';
prm = slj.Parameters(indir, outdir);

%% suffix of the distribution function
% x-line
sfx11 = 'x800-1200_y418-661_z0-1';
sfx12 = 'x800-1200_y418-661_z0-1';
% FPR
sfx21 = 'x800-1200_y418-661_z0-1';
sfx22 = 'x1200-1600_y418-661_z0-1';
% outflow
sfx31 = 'x1600-2000_y418-661_z0-1';
sfx32 = 'x1600-2000_y418-661_z0-1';

%% figure
f=figure('Position',[100,10,1400,1200]);
ha=slj.Plot.subplot(4,3,[0.02,0.04],[0.1,0.07],[0.08,0.08]);

%% X-line
pst1.xrange = [24.5, 25.5];
pst1.yrange = [-100,100];
pst1.zrange = [-2, 4];
pst2 = pst1;
yrange1.vx = [-1, 1];
yrange1.vz = [-2, 2];
yrange2 = yrange1;
plot_phase_space_density(ha, 1, prm, sfx11, sfx12, pst1, pst2, yrange1, yrange2);

%% FPR
pst1.xrange = [28, 29];
pst1.yrange = [-100,100];
pst1.zrange = [-2, 4];
pst2 = pst1;
pst2.xrange = [30, 31];
yrange1.vx = [-2, 2];
yrange1.vz = [-2, 2];
yrange2 = yrange1;
plot_phase_space_density(ha, 2, prm, sfx21, sfx22, pst1, pst2, yrange1, yrange2);

%% outflow
pst1.xrange = [41, 42];
pst1.yrange = [-100,100];
pst1.zrange = [-2, 4];
pst2 = pst1;
yrange1.vx = [-2, 2];
yrange1.vz = [-2, 2];
yrange2 = yrange1;
plot_phase_space_density(ha, 3, prm, sfx31, sfx32, pst1, pst2, yrange1, yrange2);


%% label
annotation(f,'textbox',...
    [0.165 0.934387674933872 0.0774999979031938 0.0427435377897847],...
    'String',{'X-line'},...
    'LineStyle','none',...
    'FontSize',22,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.476428571428571 0.93339363914858 0.0617857126572303 0.0427435377897847],...
    'String',{'FPR'},...
    'LineStyle','none',...
    'FontSize',22,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.750714285714286 0.933393639148576 0.0939285688421557 0.0427435377897847],...
    'String',{'Outflow'},...
    'LineStyle','none',...
    'FontSize',22,...
    'FontName','Times New Roman');


annotation(f,'textbox',...
    [0.005 0.887667992966072 0.0582142841922386 0.0407554662784573],...
    'String',{'t=30'},...
    'LineStyle','none',...
    'FontSize',20,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.005 0.67494433491438 0.0582142841922386 0.0407554662784573],...
    'String',{'t=50'},...
    'LineStyle','none',...
    'FontSize',20,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.005 0.461226641077399 0.0582142841922386 0.0407554662784573],...
    'String',{'t=30'},...
    'LineStyle','none',...
    'FontSize',20,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.005 0.248502983025714 0.0582142841922386 0.0407554662784573],...
    'String',{'t=50'},...
    'LineStyle','none',...
    'FontSize',20,...
    'FontName','Times New Roman');



% annotation(f,'textbox',...
%     [0.0778571428571428 0.896620279129882 0.04035714186728 0.0367793232558025],...
%     'String',{'(a)'},...
%     'LineStyle','none',...
%     'FontSize',18,...
%     'FontName','Times');
% annotation(f,'textbox',...
%     [0.372142857142857 0.895626243344591 0.0410714275602784 0.0367793232558025],...
%     'String',{'(b)'},...
%     'LineStyle','none',...
%     'FontSize',18,...
%     'FontName','Times');
% annotation(f,'textbox',...
%     [0.664285714285714 0.895626243344589 0.04035714186728 0.0367793232558025],...
%     'String',{'(c)'},...
%     'LineStyle','none',...
%     'FontSize',18,...
%     'FontName','Times');
% annotation(f,'textbox',...
%     [0.0778571428571426 0.683896621078184 0.0410714275602784 0.0367793232558025],...
%     'String',{'(d)'},...
%     'LineStyle','none',...
%     'FontSize',18,...
%     'FontName','Times');
% annotation(f,'textbox',...
%     [0.372142857142857 0.682902585292897 0.04035714186728 0.0367793232558025],...
%     'String',{'(e)'},...
%     'LineStyle','none',...
%     'FontSize',18,...
%     'FontName','Times');
% annotation(f,'textbox',...
%     [0.663571428571429 0.683896621078186 0.038214284788285 0.0367793232558025],...
%     'String',{'(f)'},...
%     'LineStyle','none',...
%     'FontSize',18,...
%     'FontName','Times');
% annotation(f,'textbox',...
%     [0.0778571428571427 0.472166998811784 0.0410714275602784 0.0367793232558025],...
%     'String',{'(g)'},...
%     'LineStyle','none',...
%     'FontSize',18,...
%     'FontName','Times');
% annotation(f,'textbox',...
%     [0.371428571428571 0.471172963026496 0.0410714275602784 0.0367793232558025],...
%     'String',{'(h)'},...
%     'LineStyle','none',...
%     'FontSize',18,...
%     'FontName','Times');
% annotation(f,'textbox',...
%     [0.664285714285714 0.471172963026495 0.0374999990952867 0.0367793232558025],...
%     'String',{'(i)'},...
%     'LineStyle','none',...
%     'FontSize',18,...
%     'FontName','Times');
% annotation(f,'textbox',...
%     [0.0778571428571428 0.257455269189517 0.0374999990952867 0.0367793232558025],...
%     'String',{'(j)'},...
%     'LineStyle','none',...
%     'FontSize',18,...
%     'FontName','Times');
% annotation(f,'textbox',...
%     [0.371428571428571 0.258449304974805 0.0410714275602784 0.0367793232558025],...
%     'String',{'(k)'},...
%     'LineStyle','none',...
%     'FontSize',18,...
%     'FontName','Times');
% annotation(f,'textbox',...
%     [0.664285714285714 0.257455269189516 0.0374999990952867 0.0367793232558025],...
%     'String',{'(l)'},...
%     'LineStyle','none',...
%     'FontSize',18,...
%     'FontName','Times');



%%
cd(outdir);
% print('-dpng', '-r300', 'figure11.png');
% print(f,'-depsc','-painters','figure11.eps');



function plot_vx_vz_rz(ha1, ha2, spcs, prm, yrange1, yrange2)
extra.colormap='moon';
extra.log=true;
cx = 3.65;
%% rz-vz
axes(ha1);
extra.ylabel='Vic_x [V_A]';
dst=spcs.dstrv(3,1,prm.value.vA,6*40);
h = slj.Plot.field2d(dst.value, dst.ll.lr, dst.ll.lv,extra);
caxis([0, cx]);
delete(h);
xlim([-2, 4]);
ylim(yrange1);

%% rz-vz
axes(ha2);
extra.ylabel='Vic_z [V_A]';
dst=spcs.dstrv(3,3,prm.value.vA,6*40);
h = slj.Plot.field2d(dst.value, dst.ll.lr, dst.ll.lv,extra);
caxis([0, cx]);
delete(h);
xlim([-2, 4]);
ylim(yrange2);
end

function plot_phase_space_density(ha, i, prm, sfx1, sfx2, pst1, pst2, yrange1, yrange2)
tt1 = 30/prm.value.wci;
tt2 = 50/prm.value.wci;
%% t = 30
spc=prm.read(['PVh_ts',num2str(tt1),'_', sfx1]);
spc=spc.subposition(pst1.xrange,pst1.yrange,pst1.zrange);
plot_vx_vz_rz(ha(i), ha(i+6), spc, prm, yrange1.vx, yrange1.vz);
%% t = 50
spc=prm.read(['PVh_ts',num2str(tt2),'_', sfx2]);
spc=spc.subposition(pst2.xrange,pst2.yrange,pst2.zrange);
plot_vx_vz_rz(ha(i+3), ha(i+9), spc, prm, yrange2.vx, yrange2.vz);

%% figure
if i ~= 1
    ylabel(ha(i),[]);
    ylabel(ha(i+3),[]);
    ylabel(ha(i+6),[]);
    ylabel(ha(i+9),[]);
end
set(ha(i),'XTicklabel',[]);
set(ha(i+3),'XTicklabel',[]);
set(ha(i+6),'XTicklabel',[]);
xlabel(ha(i+9), 'Z [c/\omega_{pi}]');

%% colorbar
if i == 3
axes(ha(i+9));
h = colorbar;
ph = get(h, 'Position');
p1 = get(ha(i), 'Position');

p9 = get(ha(i+9), 'Position');
p9(3) = p1(3);
set(ha(i+9), 'Position', p9);

ph(1) = p9(1) + p9(3) + 0.01;
ph(2) = p9(2);
ph(4) = p1(2) - p9(2) + p1(4);
set(h, 'Position', ph);
set(h,'YTick',[0,0.5,1,1.5,2,2.5,3,3.5,4]','YTicklabel',{'0','10^{0.5}','10^1','10^{1.5}','10^2','10^{2.5}','10^3','10^{3.5}','10^4'});
end
end